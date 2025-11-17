#!/bin/bash

set -e

echo "=========================================
Grafana Observability Stack Deployment
Using Helm Charts + Grafana Alloy
=========================================
"

# Check prerequisites
if ! command -v kubectl &> /dev/null; then
    echo "❌ Error: kubectl is not installed"
    exit 1
fi

if ! command -v helm &> /dev/null; then
    echo "❌ Error: Helm is not installed"
    echo ""
    echo "Install Helm:"
    echo "  macOS/Linux: brew install helm"
    echo "  Windows:     choco install kubernetes-helm"
    echo "  Script:      curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash"
    exit 1
fi

if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Error: Kubernetes cluster is not running"
    echo "Please enable Kubernetes in Docker Desktop settings"
    exit 1
fi

echo "✅ Prerequisites check passed"
echo "   - kubectl: $(kubectl version --client --short 2>/dev/null | head -1)"
echo "   - helm: $(helm version --short)"
echo "   - cluster: $(kubectl config current-context)"
echo ""

# Add Helm repositories
echo "📦 Adding Helm repositories..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
echo ""

# Create namespaces
echo "📁 Creating namespaces..."
kubectl create namespace observability --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace microservices --dry-run=client -o yaml | kubectl apply -f -
echo ""

# Deploy Grafana Loki for logs
echo "📊 Deploying Grafana Loki (Log Aggregation)..."
helm upgrade --install loki grafana/loki-stack \
  --namespace observability \
  --version 2.10.2 \
  --set loki.enabled=true \
  --set promtail.enabled=false \
  --set grafana.enabled=false \
  --set prometheus.enabled=false \
  --set loki.persistence.enabled=true \
  --set loki.persistence.size=5Gi \
  --set loki.config.auth_enabled=false \
  --set loki.config.ingester.chunk_idle_period=3m \
  --set loki.config.ingester.chunk_block_size=262144 \
  --set loki.config.ingester.chunk_retain_period=1m \
  --set loki.config.limits_config.retention_period=168h \
  --wait --timeout=5m
echo "✅ Loki deployed"
echo ""

# Deploy Grafana Tempo for traces
echo "🔍 Deploying Grafana Tempo (Distributed Tracing)..."
helm upgrade --install tempo grafana/tempo \
  --namespace observability \
  --version 1.10.1 \
  --set tempo.storage.trace.backend=local \
  --set tempo.storage.trace.local.path=/var/tempo/traces \
  --set tempo.receivers.otlp.protocols.grpc.endpoint="0.0.0.0:4317" \
  --set tempo.receivers.otlp.protocols.http.endpoint="0.0.0.0:4318" \
  --wait --timeout=5m
echo "✅ Tempo deployed"
echo ""

# Deploy Prometheus for metrics
echo "📈 Deploying Prometheus (Metrics Storage)..."
helm upgrade --install prometheus prometheus-community/prometheus \
  --namespace observability \
  --version 25.27.0 \
  --set server.persistentVolume.size=5Gi \
  --set server.retention=7d \
  --set alertmanager.enabled=false \
  --set prometheus-pushgateway.enabled=false \
  --set prometheus-node-exporter.enabled=false \
  --set kube-state-metrics.enabled=true \
  --wait --timeout=5m
echo "✅ Prometheus deployed"
echo ""

# Deploy Grafana Alloy (replaces OpenTelemetry Collector)
echo "🔄 Deploying Grafana Alloy (Unified Telemetry Agent)..."
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: alloy-config
  namespace: observability
data:
  config.alloy: |
    // Prometheus metrics scraping
    prometheus.scrape "kubernetes" {
      targets = discovery.kubernetes.targets
      forward_to = [prometheus.remote_write.default.receiver]
    }

    discovery.kubernetes "pods" {
      role = "pod"
    }

    prometheus.remote_write "default" {
      endpoint {
        url = "http://prometheus-server.observability.svc.cluster.local/api/v1/write"
      }
    }

    // OTLP receivers for microservices
    otelcol.receiver.otlp "default" {
      grpc {
        endpoint = "0.0.0.0:4317"
      }
      http {
        endpoint = "0.0.0.0:4318"
      }

      output {
        metrics = [otelcol.exporter.prometheus.default.input]
        logs    = [otelcol.exporter.loki.default.input]
        traces  = [otelcol.exporter.otlp.tempo.input]
      }
    }

    // Export metrics to Prometheus
    otelcol.exporter.prometheus "default" {
      forward_to = [prometheus.remote_write.default.receiver]
    }

    // Export logs to Loki
    otelcol.exporter.loki "default" {
      forward_to = [loki.write.default.receiver]
    }

    loki.write "default" {
      endpoint {
        url = "http://loki.observability.svc.cluster.local:3100/loki/api/v1/push"
      }
    }

    // Export traces to Tempo
    otelcol.exporter.otlp "tempo" {
      client {
        endpoint = "tempo.observability.svc.cluster.local:4317"
        tls {
          insecure = true
        }
      }
    }
EOF

helm upgrade --install alloy grafana/alloy \
  --namespace observability \
  --version 0.9.2 \
  --set alloy.configMap.name=alloy-config \
  --set alloy.configMap.key=config.alloy \
  --set controller.type=deployment \
  --set controller.replicas=1 \
  --wait --timeout=5m
echo "✅ Grafana Alloy deployed"
echo ""

# Deploy Grafana with datasources pre-configured
echo "📊 Deploying Grafana (Visualization Dashboard)..."
helm upgrade --install grafana grafana/grafana \
  --namespace observability \
  --version 8.5.2 \
  --set adminUser=admin \
  --set adminPassword=admin \
  --set service.type=NodePort \
  --set service.nodePort=30300 \
  --set persistence.enabled=true \
  --set persistence.size=5Gi \
  --set datasources."datasources\.yaml".apiVersion=1 \
  --set datasources."datasources\.yaml".datasources[0].name=Prometheus \
  --set datasources."datasources\.yaml".datasources[0].type=prometheus \
  --set datasources."datasources\.yaml".datasources[0].url=http://prometheus-server.observability.svc.cluster.local \
  --set datasources."datasources\.yaml".datasources[0].isDefault=true \
  --set datasources."datasources\.yaml".datasources[0].access=proxy \
  --set datasources."datasources\.yaml".datasources[1].name=Loki \
  --set datasources."datasources\.yaml".datasources[1].type=loki \
  --set datasources."datasources\.yaml".datasources[1].url=http://loki.observability.svc.cluster.local:3100 \
  --set datasources."datasources\.yaml".datasources[1].access=proxy \
  --set datasources."datasources\.yaml".datasources[2].name=Tempo \
  --set datasources."datasources\.yaml".datasources[2].type=tempo \
  --set datasources."datasources\.yaml".datasources[2].url=http://tempo.observability.svc.cluster.local:3100 \
  --set datasources."datasources\.yaml".datasources[2].access=proxy \
  --set datasources."datasources\.yaml".datasources[2].jsonData.tracesToLogsV2.datasourceUid='loki' \
  --set datasources."datasources\.yaml".datasources[2].jsonData.tracesToMetrics.datasourceUid='prometheus' \
  --set datasources."datasources\.yaml".datasources[2].jsonData.serviceMap.datasourceUid='prometheus' \
  --wait --timeout=5m
echo "✅ Grafana deployed"
echo ""

echo "=========================================
✅ Observability Stack Deployed Successfully!
=========================================
"

echo "📋 Deployed Components:"
kubectl get pods -n observability -o wide

echo ""
echo "=========================================
🌐 Access Information
=========================================

📊 Grafana Dashboard:
   URL:      http://localhost:30300
   Username: admin
   Password: admin

   Pre-configured datasources:
   ✅ Prometheus (metrics)
   ✅ Loki (logs)
   ✅ Tempo (traces)

🔧 Components:
   • Grafana Alloy:  Unified telemetry collection (OTLP receiver)
   • Prometheus:     Metrics storage & querying
   • Loki:          Log aggregation
   • Tempo:         Distributed tracing

📡 OTLP Endpoints (for microservices):
   gRPC: alloy.observability.svc.cluster.local:4317
   HTTP: alloy.observability.svc.cluster.local:4318

=========================================
"

echo "Next steps:"
echo "1. Deploy microservices: ./scripts/04-deploy-microservices.sh"
echo "2. Access Grafana at http://localhost:30300"
echo "3. Generate traffic: ./scripts/06-generate-traffic.sh"
echo ""

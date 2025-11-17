#!/bin/bash

set -e

echo "========================================="
echo "Deploying Observability Stack with Helm"
echo "========================================="

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo "Error: Helm is not installed"
    echo "Please install Helm: https://helm.sh/docs/intro/install/"
    exit 1
fi

echo "✓ Helm is installed"
helm version --short
echo ""

# Add Helm repositories
echo "Adding Helm repositories..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

echo ""
echo "Creating namespaces..."
kubectl create namespace observability --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace microservices --dry-run=client -o yaml | kubectl apply -f -

echo ""
echo "Deploying MinIO (S3-compatible storage)..."
helm upgrade --install minio bitnami/minio \
  --namespace observability \
  --set auth.rootUser=minioadmin \
  --set auth.rootPassword=minioadmin \
  --set mode=standalone \
  --set persistence.size=10Gi \
  --set service.type=NodePort \
  --set service.nodePorts.api=30000 \
  --set service.nodePorts.console=30001 \
  --set defaultBuckets="mimir-blocks,mimir-ruler,loki-chunks,tempo-blocks" \
  --wait

echo ""
echo "Deploying Grafana Loki (Logs)..."
helm upgrade --install loki grafana/loki \
  --namespace observability \
  --set loki.auth_enabled=false \
  --set loki.commonConfig.replication_factor=1 \
  --set singleBinary.replicas=1 \
  --set monitoring.selfMonitoring.enabled=false \
  --set monitoring.lokiCanary.enabled=false \
  --set test.enabled=false \
  --wait

echo ""
echo "Deploying Grafana Tempo (Traces)..."
helm upgrade --install tempo grafana/tempo \
  --namespace observability \
  --set tempo.searchEnabled=true \
  --set tempo.metricsGenerator.enabled=true \
  --set tempo.storage.trace.backend=local \
  --wait

echo ""
echo "Deploying Prometheus (Metrics)..."
helm upgrade --install prometheus prometheus-community/prometheus \
  --namespace observability \
  --set server.persistentVolume.size=5Gi \
  --set alertmanager.enabled=false \
  --set kube-state-metrics.enabled=true \
  --set prometheus-node-exporter.enabled=false \
  --set prometheus-pushgateway.enabled=false \
  --wait

echo ""
echo "Deploying Grafana (Visualization)..."
helm upgrade --install grafana grafana/grafana \
  --namespace observability \
  --set adminUser=admin \
  --set adminPassword=admin \
  --set service.type=NodePort \
  --set service.nodePort=30300 \
  --set persistence.enabled=true \
  --set persistence.size=5Gi \
  --set datasources."datasources\.yaml".apiVersion=1 \
  --set datasources."datasources\.yaml".datasources[0].name=Prometheus \
  --set datasources."datasources\.yaml".datasources[0].type=prometheus \
  --set datasources."datasources\.yaml".datasources[0].url=http://prometheus-server \
  --set datasources."datasources\.yaml".datasources[0].isDefault=true \
  --set datasources."datasources\.yaml".datasources[1].name=Loki \
  --set datasources."datasources\.yaml".datasources[1].type=loki \
  --set datasources."datasources\.yaml".datasources[1].url=http://loki:3100 \
  --set datasources."datasources\.yaml".datasources[2].name=Tempo \
  --set datasources."datasources\.yaml".datasources[2].type=tempo \
  --set datasources."datasources\.yaml".datasources[2].url=http://tempo:3100 \
  --wait

echo ""
echo "Deploying OpenTelemetry Collector..."
helm upgrade --install opentelemetry-collector prometheus-community/opentelemetry-collector \
  --namespace observability \
  --set mode=deployment \
  --set config.receivers.otlp.protocols.grpc.endpoint="0.0.0.0:4317" \
  --set config.receivers.otlp.protocols.http.endpoint="0.0.0.0:4318" \
  --set config.exporters.prometheus.endpoint="0.0.0.0:8889" \
  --set config.exporters.loki.endpoint="http://loki:3100/loki/api/v1/push" \
  --set config.exporters.otlp.endpoint="tempo:4317" \
  --set config.service.pipelines.metrics.receivers[0]=otlp \
  --set config.service.pipelines.metrics.exporters[0]=prometheus \
  --set config.service.pipelines.traces.receivers[0]=otlp \
  --set config.service.pipelines.traces.exporters[0]=otlp \
  --set config.service.pipelines.logs.receivers[0]=otlp \
  --set config.service.pipelines.logs.exporters[0]=loki \
  --wait

echo ""
echo "✓ Observability stack deployed successfully!"
echo ""
echo "Observability Stack Status:"
kubectl get pods -n observability

echo ""
echo "========================================="
echo "Access Information"
echo "========================================="
echo ""
echo "Grafana Dashboard:"
echo "  URL: http://localhost:30300"
echo "  Username: admin"
echo "  Password: admin"
echo ""
echo "MinIO Console:"
echo "  URL: http://localhost:30001"
echo "  Username: minioadmin"
echo "  Password: minioadmin"
echo ""

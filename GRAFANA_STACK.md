# Grafana Observability Stack

**Modern, Production-Ready Observability Using Grafana Alloy + Helm Charts**

## Overview

This deployment uses the complete Grafana observability stack with **Grafana Alloy** as the unified telemetry agent, replacing the older OpenTelemetry Collector. Everything is deployed using official Helm charts for maximum reliability.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Microservices                            │
│  ┌──────────────┐           ┌──────────────┐               │
│  │ User Service │◄──────────┤Order Service │               │
│  │   (8081)     │           │   (8082)     │               │
│  └──────┬───────┘           └──────┬───────┘               │
│         │ OTLP                     │ OTLP                   │
└─────────┼──────────────────────────┼────────────────────────┘
          │                          │
          ▼                          ▼
┌─────────────────────────────────────────────────────────────┐
│              Grafana Alloy (Unified Agent)                  │
│        OTLP Receiver → Metrics, Logs, Traces                │
└─────┬──────────┬──────────┬─────────────────────────────────┘
      │          │          │
      ▼          ▼          ▼
┌─────────┐ ┌───────┐ ┌───────┐
│Prometheus│ │ Loki  │ │ Tempo │
│(Metrics)│ │ (Logs)│ │(Traces│
└────┬────┘ └───┬───┘ └───┬───┘
     │          │          │
     └──────────┴──────────┘
                │
                ▼
          ┌──────────┐
          │ Grafana  │ ← Unified Visualization
          │  (3000)  │
          └──────────┘
```

## Why Grafana Alloy?

✅ **Native Grafana Integration** - Built by Grafana Labs for their stack
✅ **Simpler Configuration** - Easier than OpenTelemetry Collector
✅ **Better Performance** - Optimized for Grafana ecosystem
✅ **Future-Proof** - Active development and support
✅ **Unified Agent** - Replaces multiple agents (Prometheus, Loki, Tempo agents)

### Alloy vs OpenTelemetry Collector

| Feature | Grafana Alloy | OTEL Collector |
|---------|---------------|----------------|
| Configuration | River language (simpler) | YAML (complex) |
| Grafana Integration | Native | Via exporters |
| Learning Curve | Low | High |
| Components | All-in-one | Modular |
| Best For | Grafana stack | Vendor-neutral |

## Components Deployed

All via official Helm charts:

| Component | Chart | Version | Purpose |
|-----------|-------|---------|---------|
| **Grafana Alloy** | `grafana/alloy` | 0.9.2 | Unified telemetry collection |
| **Prometheus** | `prometheus-community/prometheus` | 25.27.0 | Metrics storage |
| **Loki** | `grafana/loki` | 6.16.0 | Log aggregation |
| **Tempo** | `grafana/tempo` | 1.10.1 | Distributed tracing |
| **Grafana** | `grafana/grafana` | 8.5.2 | Visualization dashboard |

## Prerequisites

1. **Docker Desktop** with Kubernetes enabled
2. **Helm 3.x** installed
3. **kubectl** installed

### Install Helm

```bash
# macOS/Linux
brew install helm

# Windows
choco install kubernetes-helm

# Or using script
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Quick Start

### One-Command Deployment

```bash
./scripts/deploy-all-grafana.sh
```

This will:
1. ✅ Clean up any existing deployments
2. ✅ Build Docker images for microservices
3. ✅ Deploy Grafana observability stack (Alloy, Prometheus, Loki, Tempo, Grafana)
4. ✅ Deploy microservices (user-service, order-service)
5. ✅ Display access information

**Deployment time:** ~5-7 minutes

## Access Services

### Grafana Dashboard
```
URL:      http://localhost:30300
Username: admin
Password: admin
```

**Pre-configured datasources:**
- ✅ Prometheus (metrics) - Default
- ✅ Loki (logs)
- ✅ Tempo (traces) - With correlation to logs and metrics

### Microservices

```bash
# User Service
kubectl port-forward -n microservices svc/user-service 8081:8081
curl http://localhost:8081/api/users

# Order Service
kubectl port-forward -n microservices svc/order-service 8082:8082
curl http://localhost:8082/api/orders
```

## Telemetry Flow

### Metrics
```
Microservices → Alloy (OTLP) → Prometheus → Grafana
```

### Logs
```
Microservices → Alloy (OTLP) → Loki → Grafana
```

### Traces
```
Microservices → Alloy (OTLP) → Tempo → Grafana
```

## Configuration

### Grafana Alloy Configuration

Located in `scripts/deploy-observability-grafana.sh` (ConfigMap):

```river
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
```

### Microservice Configuration

Microservices are configured to send telemetry to Alloy:

```yaml
env:
- name: OTEL_EXPORTER_OTLP_ENDPOINT
  value: "http://alloy.observability.svc.cluster.local:4318"
- name: OTEL_SERVICE_NAME
  value: "user-service"
```

## Useful Commands

### View All Pods
```bash
kubectl get pods -n observability
kubectl get pods -n microservices
```

### Check Helm Releases
```bash
helm list -n observability
```

### View Logs
```bash
# Alloy logs
kubectl logs -n observability -l app.kubernetes.io/name=alloy

# Grafana logs
kubectl logs -n observability -l app.kubernetes.io/name=grafana

# Microservice logs
kubectl logs -n microservices -l app=user-service
kubectl logs -n microservices -l app=order-service
```

### Access Prometheus
```bash
kubectl port-forward -n observability svc/prometheus-server 9090:80
# Open: http://localhost:9090
```

### Access Loki
```bash
kubectl port-forward -n observability svc/loki-gateway 3100:80
# LogQL: http://localhost:3100
```

## Generate Sample Traffic

```bash
./scripts/06-generate-traffic.sh
```

Then check Grafana for:
- **Metrics**: Dashboard → Explore → Prometheus → Query: `http_server_requests_seconds_count`
- **Logs**: Dashboard → Explore → Loki → Query: `{service_name="user-service"}`
- **Traces**: Dashboard → Explore → Tempo → Search

## Cleanup

### Remove Everything
```bash
./scripts/cleanup-observability.sh
```

This removes:
- All Helm releases
- All manual deployments
- Namespaces (observability, microservices)
- Persistent volumes

### Remove Only Observability Stack
```bash
helm uninstall grafana -n observability
helm uninstall alloy -n observability
helm uninstall prometheus -n observability
helm uninstall loki -n observability
helm uninstall tempo -n observability
```

## Troubleshooting

### Pods Not Starting
```bash
# Check pod status
kubectl get pods -n observability -o wide

# Describe problematic pod
kubectl describe pod <pod-name> -n observability

# Check logs
kubectl logs <pod-name> -n observability
```

### Helm Issues
```bash
# Check release status
helm status grafana -n observability

# View values
helm get values grafana -n observability

# Debug installation
helm install grafana grafana/grafana -n observability --debug --dry-run
```

### Alloy Not Receiving Data
```bash
# Check Alloy is running
kubectl get pods -n observability -l app.kubernetes.io/name=alloy

# Check Alloy logs
kubectl logs -n observability -l app.kubernetes.io/name=alloy

# Verify microservices can reach Alloy
kubectl run -it --rm debug --image=curlimages/curl --restart=Never -- \
  curl -v http://alloy.observability.svc.cluster.local:4318/v1/metrics
```

### No Data in Grafana
1. Check datasource configuration in Grafana
2. Verify Alloy is receiving data
3. Check Prometheus/Loki/Tempo are healthy
4. Generate traffic: `./scripts/06-generate-traffic.sh`

## Customization

### Change Retention Periods

Edit `scripts/deploy-observability-grafana.sh`:

```bash
# Prometheus retention
--set server.retention=30d

# Loki retention (in config)
--set loki.limits_config.retention_period=168h
```

### Add Custom Dashboards

```bash
# Create ConfigMap with dashboard JSON
kubectl create configmap my-dashboard \
  --from-file=dashboard.json \
  -n observability

# Mount in Grafana
helm upgrade grafana grafana/grafana \
  --set dashboardsConfigMaps[0]=my-dashboard
```

### Scale Components

```bash
# Scale Alloy
helm upgrade alloy grafana/alloy \
  --set controller.replicas=3 \
  -n observability

# Scale Loki
helm upgrade loki grafana/loki \
  --set singleBinary.replicas=3 \
  -n observability
```

## Production Considerations

For production deployments:

1. **Use External Storage**
   - Replace filesystem storage with S3/GCS/Azure Blob
   - Configure in Helm values

2. **Enable Authentication**
   - Configure Grafana OAuth/LDAP
   - Set strong admin passwords

3. **Set Resource Limits**
   - Adjust CPU/memory based on load
   - Configure HPA for auto-scaling

4. **Configure Retention**
   - Set appropriate data retention periods
   - Configure backup strategies

5. **High Availability**
   - Run multiple replicas
   - Use persistent volumes
   - Configure anti-affinity

## Resources

- [Grafana Alloy Documentation](https://grafana.com/docs/alloy/latest/)
- [Grafana Helm Charts](https://github.com/grafana/helm-charts)
- [Prometheus Helm Charts](https://github.com/prometheus-community/helm-charts)
- [OpenTelemetry Documentation](https://opentelemetry.io/docs/)

## Advantages Over Previous Setup

| Aspect | Old (OTEL + Manual YAML) | New (Alloy + Helm) |
|--------|--------------------------|---------------------|
| Configuration | 1000+ lines YAML | ~200 lines scripts |
| Deployment | Multiple scripts | One command |
| Reliability | Configuration errors | Pre-tested charts |
| Maintenance | Manual updates | `helm upgrade` |
| Debugging | Complex | Simplified |
| Documentation | Self-documented | Official docs |
| Community | Limited | Active Grafana community |

---

**Built with ❤️ using Grafana Stack and Helm**

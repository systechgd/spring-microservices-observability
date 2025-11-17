# Helm-Based Deployment Guide

This guide uses **Helm charts** for deploying the observability stack - a much simpler and more reliable approach than raw YAML manifests.

## Why Helm?

✅ **Production-ready** - Official charts tested by thousands of users
✅ **Less configuration** - Sensible defaults that just work
✅ **Easy updates** - One command to upgrade versions
✅ **No crashes** - Charts handle dependencies and configurations correctly
✅ **Community support** - Maintained by Grafana and Prometheus teams

## Prerequisites

1. **Docker Desktop** with Kubernetes enabled
2. **Helm 3.x** installed

### Install Helm

```bash
# macOS/Linux (Homebrew)
brew install helm

# Windows (Chocolatey)
choco install kubernetes-helm

# Script (any OS)
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

Verify installation:
```bash
helm version
```

## One-Command Deployment

```bash
./scripts/deploy-all-helm.sh
```

That's it! This will:
1. ✅ Build microservice Docker images
2. ✅ Deploy observability stack using Helm charts:
   - MinIO (S3 storage)
   - Loki (logs)
   - Tempo (traces)
   - Prometheus (metrics)
   - Grafana (visualization)
   - OpenTelemetry Collector
3. ✅ Deploy microservices

## What Gets Deployed

### Observability Stack (via Helm)

| Component | Chart | Purpose |
|-----------|-------|---------|
| MinIO | `bitnami/minio` | S3-compatible storage |
| Loki | `grafana/loki` | Log aggregation |
| Tempo | `grafana/tempo` | Distributed tracing |
| Prometheus | `prometheus-community/prometheus` | Metrics storage |
| Grafana | `grafana/grafana` | Visualization dashboard |
| OTEL Collector | `prometheus-community/opentelemetry-collector` | Telemetry collection |

### Microservices (Custom)

- **user-service** - User management microservice
- **order-service** - Order management microservice

## Access Services

### Grafana Dashboard
```
URL: http://localhost:30300
Username: admin
Password: admin
```

Pre-configured datasources:
- ✅ Prometheus (metrics)
- ✅ Loki (logs)
- ✅ Tempo (traces)

### MinIO Console
```
URL: http://localhost:30001
Username: minioadmin
Password: minioadmin
```

### Microservices
```bash
# User Service
kubectl port-forward -n microservices svc/user-service 8081:8081
# Access: http://localhost:8081/api/users

# Order Service
kubectl port-forward -n microservices svc/order-service 8082:8082
# Access: http://localhost:8082/api/orders
```

## Verify Deployment

```bash
# Check all pods are running
kubectl get pods -n observability

# List installed Helm releases
helm list -n observability

# Check Grafana is accessible
curl -I http://localhost:30300
```

## Customize Configuration

All Helm values can be customized in `scripts/deploy-observability-helm.sh`.

Example - Change Grafana admin password:
```bash
helm upgrade --install grafana grafana/grafana \
  --namespace observability \
  --set adminPassword=MySecurePassword123
```

## Upgrade Components

```bash
# Update Helm repositories
helm repo update

# Upgrade specific component
helm upgrade grafana grafana/grafana -n observability

# Upgrade all
helm upgrade --reuse-values grafana grafana/grafana -n observability
helm upgrade --reuse-values loki grafana/loki -n observability
helm upgrade --reuse-values tempo grafana/tempo -n observability
```

## Cleanup

```bash
# Uninstall everything
helm uninstall minio -n observability
helm uninstall loki -n observability
helm uninstall tempo -n observability
helm uninstall prometheus -n observability
helm uninstall grafana -n observability
helm uninstall opentelemetry-collector -n observability

kubectl delete namespace observability
kubectl delete namespace microservices
```

## Troubleshooting

### Check Helm release status
```bash
helm status grafana -n observability
```

### View Helm values
```bash
helm get values grafana -n observability
```

### Check pod logs
```bash
kubectl logs -n observability -l app.kubernetes.io/name=grafana
```

### Debug failed installation
```bash
helm install grafana grafana/grafana -n observability --debug --dry-run
```

## Advantages Over Raw YAML

| Aspect | Raw YAML | Helm Charts |
|--------|----------|-------------|
| Configuration | 500+ lines manual | 10-20 lines values |
| Updates | Manual editing | `helm upgrade` |
| Dependencies | Manual ordering | Automatic |
| Best practices | DIY | Built-in |
| Testing | Manual | Chart tests |
| Rollback | Complex | `helm rollback` |
| Community | None | Thousands of users |

## Next Steps

1. Access Grafana at http://localhost:30300
2. Generate traffic: `./scripts/06-generate-traffic.sh`
3. Explore pre-configured dashboards
4. Create custom dashboards for your metrics
5. Set up alerting rules in Prometheus

## Resources

- [Grafana Helm Charts](https://github.com/grafana/helm-charts)
- [Prometheus Community Charts](https://github.com/prometheus-community/helm-charts)
- [Bitnami Charts](https://github.com/bitnami/charts)
- [Helm Documentation](https://helm.sh/docs/)

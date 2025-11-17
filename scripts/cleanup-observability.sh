#!/bin/bash

set -e

echo "=========================================
Cleaning Up Old Observability Stack
=========================================
"

echo "🗑️  Uninstalling Helm releases..."
helm uninstall grafana -n observability 2>/dev/null && echo "  ✅ Grafana removed" || echo "  ⏭️  Grafana not found"
helm uninstall alloy -n observability 2>/dev/null && echo "  ✅ Alloy removed" || echo "  ⏭️  Alloy not found"
helm uninstall prometheus -n observability 2>/dev/null && echo "  ✅ Prometheus removed" || echo "  ⏭️  Prometheus not found"
helm uninstall loki -n observability 2>/dev/null && echo "  ✅ Loki removed" || echo "  ⏭️  Loki not found"
helm uninstall tempo -n observability 2>/dev/null && echo "  ✅ Tempo removed" || echo "  ⏭️  Tempo not found"
helm uninstall minio -n observability 2>/dev/null && echo "  ✅ MinIO removed" || echo "  ⏭️  MinIO not found"
helm uninstall opentelemetry-collector -n observability 2>/dev/null && echo "  ✅ OTEL Collector removed" || echo "  ⏭️  OTEL Collector not found"
helm uninstall pyroscope -n observability 2>/dev/null && echo "  ✅ Pyroscope removed" || echo "  ⏭️  Pyroscope not found"
echo ""

echo "🗑️  Deleting manual deployments..."
kubectl delete deployment --all -n observability 2>/dev/null || echo "  ⏭️  No deployments found"
kubectl delete statefulset --all -n observability 2>/dev/null || echo "  ⏭️  No statefulsets found"
kubectl delete service --all -n observability 2>/dev/null || echo "  ⏭️  No services found"
kubectl delete configmap --all -n observability 2>/dev/null || echo "  ⏭️  No configmaps found"
kubectl delete job --all -n observability 2>/dev/null || echo "  ⏭️  No jobs found"
kubectl delete pvc --all -n observability 2>/dev/null || echo "  ⏭️  No PVCs found"
echo ""

echo "⏳ Waiting for resources to be deleted..."
sleep 5

echo "🗑️  Deleting namespaces..."
kubectl delete namespace observability --ignore-not-found=true
kubectl delete namespace microservices --ignore-not-found=true
echo ""

echo "✅ Cleanup complete!"
echo ""
echo "You can now deploy the new stack with:"
echo "  ./scripts/deploy-all-grafana.sh"
echo ""

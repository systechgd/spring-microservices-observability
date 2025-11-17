#!/bin/bash

set -e

echo "========================================="
echo "Deploying Observability Stack"
echo "========================================="

cd "$(dirname "$0")/.."

echo "Creating namespaces..."
kubectl apply -f k8s/namespace.yaml

echo "Waiting for namespaces to be ready..."
sleep 2

echo ""
echo "Deploying MinIO (S3-compatible storage)..."
# Delete existing minio-setup job if it exists (Jobs are immutable)
kubectl delete job minio-setup -n observability --ignore-not-found=true
kubectl apply -f k8s/observability/minio.yaml

echo "Waiting for MinIO to be ready..."
kubectl wait --for=condition=ready pod -l app=minio -n observability --timeout=120s

echo "Waiting for MinIO setup job to complete..."
kubectl wait --for=condition=complete job/minio-setup -n observability --timeout=180s

echo ""
echo "Deploying OpenTelemetry Collector..."
kubectl apply -f k8s/observability/otel-collector.yaml

echo ""
echo "Deploying Mimir (Metrics Storage)..."
kubectl apply -f k8s/observability/mimir.yaml

echo ""
echo "Deploying Loki (Logs Storage)..."
kubectl apply -f k8s/observability/loki.yaml

echo ""
echo "Deploying Tempo (Traces Storage)..."
kubectl apply -f k8s/observability/tempo.yaml

echo ""
echo "Deploying Pyroscope (Profiling)..."
kubectl apply -f k8s/observability/pyroscope.yaml

echo ""
echo "Deploying Grafana (Visualization)..."
kubectl apply -f k8s/observability/grafana.yaml

echo ""
echo "Waiting for observability stack to be ready..."
echo "This may take a few minutes..."

kubectl wait --for=condition=ready pod -l app=otel-collector -n observability --timeout=180s
kubectl wait --for=condition=ready pod -l app=grafana -n observability --timeout=180s

echo ""
echo "✓ Observability stack deployed successfully!"
echo ""
echo "Observability Stack Status:"
kubectl get pods -n observability

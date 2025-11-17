#!/bin/bash

set -e

echo "========================================="
echo "Deploying Microservices"
echo "========================================="

cd "$(dirname "$0")/.."

echo "Deploying user-service..."
kubectl apply -f k8s/microservices/user-service.yaml

echo ""
echo "Deploying order-service..."
kubectl apply -f k8s/microservices/order-service.yaml

echo ""
echo "Waiting for microservices to be ready..."
echo "This may take a few minutes..."

kubectl wait --for=condition=ready pod -l app=user-service -n microservices --timeout=180s
kubectl wait --for=condition=ready pod -l app=order-service -n microservices --timeout=180s

echo ""
echo "✓ Microservices deployed successfully!"
echo ""
echo "Microservices Status:"
kubectl get pods -n microservices

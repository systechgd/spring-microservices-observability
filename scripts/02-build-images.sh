#!/bin/bash

set -e

echo "========================================="
echo "Building Docker Images"
echo "========================================="

CLUSTER_NAME="spring-microservices-observability"

cd "$(dirname "$0")/.."

echo "Building user-service..."
docker build -t user-service:latest -f microservices/user-service/Dockerfile .

echo "Building order-service..."
docker build -t order-service:latest -f microservices/order-service/Dockerfile .

echo ""
echo "Loading images into kind cluster..."
kind load docker-image user-service:latest --name "${CLUSTER_NAME}"
kind load docker-image order-service:latest --name "${CLUSTER_NAME}"

echo ""
echo "✓ Docker images built and loaded into kind cluster successfully!"
echo ""
docker images | grep -E "(user-service|order-service)"

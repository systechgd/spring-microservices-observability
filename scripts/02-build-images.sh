#!/bin/bash

set -e

echo "========================================="
echo "Building Docker Images"
echo "========================================="

cd "$(dirname "$0")/.."

echo "Building user-service..."
docker build -t user-service:latest -f microservices/user-service/Dockerfile .

echo "Building order-service..."
docker build -t order-service:latest -f microservices/order-service/Dockerfile .

echo ""
echo "✓ Docker images built successfully!"
echo ""
docker images | grep -E "(user-service|order-service)"
echo ""
echo "Note: Images are automatically available to Docker Desktop Kubernetes"
echo ""

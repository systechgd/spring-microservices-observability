#!/bin/bash

set -e

echo "========================================="
echo "Complete Observability POC Deployment"
echo "Docker Desktop Kubernetes"
echo "========================================="

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Check if kubectl is available and Kubernetes is running
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed"
    exit 1
fi

if ! kubectl cluster-info &> /dev/null; then
    echo "Error: Kubernetes cluster is not running"
    echo "Please enable Kubernetes in Docker Desktop settings"
    exit 1
fi

echo "✓ Kubernetes cluster is running"
kubectl cluster-info | head -1
echo ""

# Step 1: Build Docker images
"$SCRIPT_DIR/02-build-images.sh"

# Step 2: Deploy observability stack
"$SCRIPT_DIR/03-deploy-observability.sh"

# Step 3: Deploy microservices
"$SCRIPT_DIR/04-deploy-microservices.sh"

echo ""
echo "========================================="
echo "✓ Complete deployment finished!"
echo "========================================="
echo ""

# Step 4: Show access information
"$SCRIPT_DIR/05-access-services.sh"

echo ""
echo "Next steps:"
echo "1. Access Grafana dashboard at http://localhost:30300"
echo "2. Run './scripts/06-generate-traffic.sh' to create sample data"
echo "3. Explore metrics, logs, and traces in Grafana"
echo ""

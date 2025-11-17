#!/bin/bash

set -e

echo "========================================="
echo "Complete Observability POC Deployment"
echo "========================================="

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Step 1: Setup Kind Cluster
"$SCRIPT_DIR/01-setup-kind-cluster.sh"

# Step 2: Build Docker images
"$SCRIPT_DIR/02-build-images.sh"

# Step 3: Deploy observability stack
"$SCRIPT_DIR/03-deploy-observability.sh"

# Step 4: Deploy microservices
"$SCRIPT_DIR/04-deploy-microservices.sh"

echo ""
echo "========================================="
echo "✓ Complete deployment finished!"
echo "========================================="
echo ""

# Step 5: Show access information
"$SCRIPT_DIR/05-access-services.sh"

echo ""
echo "Next steps:"
echo "1. Access Grafana dashboard"
echo "2. Run './scripts/06-generate-traffic.sh' to create sample data"
echo "3. Explore metrics, logs, and traces in Grafana"
echo ""

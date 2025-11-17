#!/bin/bash

set -e

echo "========================================="
echo "Complete Observability POC Deployment"
echo "Docker Desktop Kubernetes + Helm"
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

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo "Error: Helm is not installed"
    echo ""
    echo "Install Helm with one of these methods:"
    echo ""
    echo "# Using Homebrew (macOS/Linux):"
    echo "brew install helm"
    echo ""
    echo "# Using Chocolatey (Windows):"
    echo "choco install kubernetes-helm"
    echo ""
    echo "# Using Script:"
    echo "curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash"
    echo ""
    exit 1
fi

echo "✓ Kubernetes cluster is running"
kubectl cluster-info | head -1
echo ""
echo "✓ Helm is installed"
helm version --short
echo ""

# Step 1: Build Docker images
"$SCRIPT_DIR/02-build-images.sh"

# Step 2: Deploy observability stack with Helm
"$SCRIPT_DIR/deploy-observability-helm.sh"

# Step 3: Deploy microservices
"$SCRIPT_DIR/04-deploy-microservices.sh"

echo ""
echo "========================================="
echo "✓ Complete deployment finished!"
echo "========================================="
echo ""

echo "Access your services:"
echo ""
echo "📊 Grafana Dashboard:"
echo "   http://localhost:30300"
echo "   Username: admin / Password: admin"
echo ""
echo "💾 MinIO Console:"
echo "   http://localhost:30001"
echo "   Username: minioadmin / Password: minioadmin"
echo ""
echo "🔧 Microservices:"
echo "   kubectl port-forward -n microservices svc/user-service 8081:8081"
echo "   kubectl port-forward -n microservices svc/order-service 8082:8082"
echo ""
echo "Next steps:"
echo "1. Access Grafana dashboard at http://localhost:30300"
echo "2. Run './scripts/06-generate-traffic.sh' to create sample data"
echo "3. Explore metrics, logs, and traces in Grafana"
echo ""

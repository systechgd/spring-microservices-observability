#!/bin/bash

set -e

echo "
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║   Spring Microservices Observability Stack               ║
║   Powered by Grafana + Helm                              ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Prerequisites check
echo "🔍 Checking prerequisites..."

if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found. Please install kubectl."
    exit 1
fi

if ! command -v helm &> /dev/null; then
    echo "❌ Helm not found. Please install Helm."
    echo ""
    echo "Install Helm:"
    echo "  macOS/Linux: brew install helm"
    echo "  Windows:     choco install kubernetes-helm"
    echo "  Script:      curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash"
    exit 1
fi

if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker Desktop."
    exit 1
fi

if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Kubernetes cluster not running."
    echo "Please enable Kubernetes in Docker Desktop settings."
    exit 1
fi

echo "✅ All prerequisites met!"
echo "   - Docker Desktop: Running"
echo "   - Kubernetes: $(kubectl version --short 2>&1 | grep Server | cut -d':' -f2 | xargs)"
echo "   - Helm: $(helm version --short)"
echo ""

# Cleanup old stack if exists
echo "🧹 Cleaning up old deployments (if any)..."
"$SCRIPT_DIR/cleanup-observability.sh" 2>/dev/null || true
echo ""

# Build Docker images
echo "🔨 Building microservice Docker images..."
"$SCRIPT_DIR/02-build-images.sh"
echo ""

# Deploy observability stack
echo "🚀 Deploying Grafana Observability Stack..."
"$SCRIPT_DIR/deploy-observability-grafana.sh"
echo ""

# Update microservice configurations for Alloy
echo "📝 Updating microservice configurations..."
kubectl create namespace microservices --dry-run=client -o yaml | kubectl apply -f -

# Deploy microservices
echo "🚀 Deploying microservices..."
"$SCRIPT_DIR/04-deploy-microservices.sh"
echo ""

echo "
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║   ✅ DEPLOYMENT COMPLETE!                                ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝

📊 GRAFANA DASHBOARD
   URL:      http://localhost:30300
   Username: admin
   Password: admin

🎯 WHAT'S DEPLOYED

   Observability Stack (Helm):
   ✅ Grafana Alloy    - Unified telemetry agent (replaces OpenTelemetry)
   ✅ Prometheus       - Metrics storage & queries
   ✅ Loki            - Log aggregation
   ✅ Tempo           - Distributed tracing
   ✅ Grafana         - Visualization dashboard

   Microservices:
   ✅ user-service    - Port 8081
   ✅ order-service   - Port 8082

📡 ARCHITECTURE

   Microservices → Grafana Alloy (OTLP) → {Prometheus, Loki, Tempo} → Grafana

🎬 NEXT STEPS

   1. Open Grafana: http://localhost:30300
   2. Generate traffic: ./scripts/06-generate-traffic.sh
   3. Explore dashboards for metrics, logs, and traces

🔧 USEFUL COMMANDS

   # View all components
   kubectl get pods -n observability
   kubectl get pods -n microservices

   # Check Helm releases
   helm list -n observability

   # Access microservices
   kubectl port-forward -n microservices svc/user-service 8081:8081
   kubectl port-forward -n microservices svc/order-service 8082:8082

   # View logs
   kubectl logs -n observability -l app.kubernetes.io/name=alloy
   kubectl logs -n microservices -l app=user-service

   # Cleanup everything
   ./scripts/cleanup-observability.sh

═══════════════════════════════════════════════════════════

Happy Observing! 🎉
"

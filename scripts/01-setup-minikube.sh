#!/bin/bash

set -e

echo "========================================="
echo "Setting up Minikube for Observability POC"
echo "========================================="

# Check if minikube is installed
if ! command -v minikube &> /dev/null; then
    echo "Error: minikube is not installed"
    echo "Please install minikube: https://minikube.sigs.k8s.io/docs/start/"
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed"
    echo "Please install kubectl: https://kubernetes.io/docs/tasks/tools/"
    exit 1
fi

echo "Starting Minikube with recommended settings..."
minikube start \
    --cpus=4 \
    --memory=8192 \
    --disk-size=20g \
    --driver=docker

echo "Enabling required addons..."
minikube addons enable metrics-server
minikube addons enable ingress

echo "Configuring Docker environment to use Minikube's Docker daemon..."
eval $(minikube docker-env)

echo ""
echo "✓ Minikube setup complete!"
echo "✓ Use 'eval \$(minikube docker-env)' to configure your shell"
echo ""

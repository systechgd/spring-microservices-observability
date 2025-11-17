#!/bin/bash

set -e

echo "========================================="
echo "Setting up Kind Cluster for Observability POC"
echo "========================================="

# Check if kind is installed
if ! command -v kind &> /dev/null; then
    echo "Error: kind is not installed"
    echo "Please install kind: https://kind.sigs.k8s.io/docs/user/quick-start/#installation"
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed"
    echo "Please install kubectl: https://kubernetes.io/docs/tasks/tools/"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "Error: Docker is not running"
    echo "Please start Docker Desktop"
    exit 1
fi

CLUSTER_NAME="spring-microservices-observability"

# Check if cluster already exists
if kind get clusters 2>/dev/null | grep -q "^${CLUSTER_NAME}$"; then
    echo "Kind cluster '${CLUSTER_NAME}' already exists."
    read -p "Do you want to delete and recreate it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Deleting existing cluster..."
        kind delete cluster --name "${CLUSTER_NAME}"
    else
        echo "Using existing cluster..."
        kubectl cluster-info --context "kind-${CLUSTER_NAME}"
        exit 0
    fi
fi

echo "Creating Kind cluster with 2 nodes (1 control-plane + 1 worker)..."
kind create cluster --config kind-cluster-config.yaml --wait 5m

echo "Verifying cluster is ready..."
kubectl cluster-info --context "kind-${CLUSTER_NAME}"

echo "Checking nodes..."
kubectl get nodes

echo "Installing metrics-server for HPA support..."
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo "Patching metrics-server for kind (disable TLS verification)..."
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[
  {
    "op": "add",
    "path": "/spec/template/spec/containers/0/args/-",
    "value": "--kubelet-insecure-tls"
  }
]'

echo "Waiting for metrics-server to be ready..."
kubectl wait --for=condition=ready pod -l k8s-app=metrics-server -n kube-system --timeout=120s || true

echo ""
echo "✓ Kind cluster setup complete!"
echo "✓ Cluster name: ${CLUSTER_NAME}"
echo "✓ Nodes: 2 (1 control-plane + 1 worker)"
echo "✓ Kubernetes version: v1.34.0"
echo ""
echo "Context set to: kind-${CLUSTER_NAME}"
echo "You can now build and deploy the services."
echo ""

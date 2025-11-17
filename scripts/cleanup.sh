#!/bin/bash

echo "========================================="
echo "Cleaning up Observability POC"
echo "========================================="

read -p "This will delete all deployments. Continue? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Deleting microservices..."
    kubectl delete namespace microservices --ignore-not-found=true

    echo "Deleting observability stack..."
    kubectl delete namespace observability --ignore-not-found=true

    echo ""
    echo "✓ Cleanup complete!"
    echo ""
    echo "To completely remove Minikube:"
    echo "  minikube delete"
fi

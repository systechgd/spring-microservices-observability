#!/bin/bash

echo "========================================="
echo "Service Access Information"
echo "========================================="

MINIKUBE_IP=$(minikube ip)

echo ""
echo "Grafana Dashboard:"
echo "  URL: http://$MINIKUBE_IP:30300"
echo "  Username: admin"
echo "  Password: admin"

echo ""
echo "To access microservices, create port-forwards:"
echo ""
echo "User Service:"
echo "  kubectl port-forward -n microservices svc/user-service 8081:8081"
echo "  Then access: http://localhost:8081/api/users"
echo ""

echo "Order Service:"
echo "  kubectl port-forward -n microservices svc/order-service 8082:8082"
echo "  Then access: http://localhost:8082/api/orders"
echo ""

echo "MinIO Console (S3 Storage):"
echo "  kubectl port-forward -n observability svc/minio 9001:9001"
echo "  Then access: http://localhost:9001"
echo "  Username: minioadmin"
echo "  Password: minioadmin"
echo ""

echo "OpenTelemetry Collector:"
echo "  kubectl port-forward -n observability svc/otel-collector 8888:8888"
echo "  Metrics: http://localhost:8888/metrics"
echo ""

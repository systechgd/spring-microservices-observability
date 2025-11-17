#!/bin/bash

echo "========================================="
echo "Generating Sample Traffic"
echo "========================================="

echo "Setting up port-forwards..."

# Kill any existing port-forwards
pkill -f "kubectl port-forward" || true

# Start port-forwards in background
kubectl port-forward -n microservices svc/user-service 8081:8081 > /dev/null 2>&1 &
kubectl port-forward -n microservices svc/order-service 8082:8082 > /dev/null 2>&1 &

sleep 5

echo ""
echo "Generating traffic to microservices..."
echo "This will create traces, metrics, and logs for visualization in Grafana"
echo ""

for i in {1..20}; do
    echo "Request $i/20"

    # User service requests
    curl -s http://localhost:8081/api/users > /dev/null
    curl -s http://localhost:8081/api/users/1 > /dev/null
    curl -s http://localhost:8081/api/users/active > /dev/null

    # Order service requests (these will call user-service internally)
    curl -s http://localhost:8082/api/orders > /dev/null
    curl -s http://localhost:8082/api/orders/user/1 > /dev/null
    curl -s http://localhost:8082/api/orders/status/PENDING > /dev/null

    sleep 2
done

echo ""
echo "✓ Traffic generation complete!"
echo ""
echo "You should now see data in Grafana:"
echo "- Metrics in Mimir datasource"
echo "- Logs in Loki datasource"
echo "- Traces in Tempo datasource"
echo ""

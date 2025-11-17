# Deployment Guide - Microservices Observability POC

## Step-by-Step Deployment Instructions

This guide provides detailed instructions for deploying the complete observability stack to a kind (Kubernetes IN Docker) cluster for your management presentation.

---

## Prerequisites Checklist

Before starting, ensure you have:

- [ ] **Docker Desktop** installed and running
  - Verify: `docker --version`
  - Required: Docker 20.10 or higher
  - Note: Docker Desktop includes Kubernetes

- [ ] **kind** (Kubernetes IN Docker) installed
  - Verify: `kind version`
  - Required: v0.20 or higher
  - Install: https://kind.sigs.k8s.io/docs/user/quick-start/#installation

- [ ] **kubectl** installed
  - Verify: `kubectl version --client`
  - Required: v1.27 or higher
  - Install: https://kubernetes.io/docs/tasks/tools/

- [ ] **System Resources Available**
  - Minimum: 4 CPU cores, 8 GB RAM, 20 GB disk
  - Recommended: 8 CPU cores, 16 GB RAM, 40 GB disk

- [ ] **Cluster Configuration**
  - 2-node kind cluster (1 control-plane + 1 worker)
  - Kubernetes version: v1.34.0

---

## Deployment Timeline

Total deployment time: **~15-20 minutes**

| Step | Time | Description |
|------|------|-------------|
| 1 | 3-5 min | Setup kind cluster |
| 2 | 5-8 min | Build and load Docker images |
| 3 | 5-7 min | Deploy observability stack |
| 4 | 2-3 min | Deploy microservices |
| 5 | 1-2 min | Verify deployment |

---

## Option 1: Quick Deployment (Recommended)

### Single Command Deployment

```bash
./scripts/deploy-all.sh
```

This automated script will:
1. Create kind cluster with 2 nodes (k8s v1.34)
2. Build and load microservice Docker images into kind
3. Deploy complete observability stack
4. Deploy both microservices
5. Display access URLs

**⏰ Expected completion: 15-20 minutes**

---

## Option 2: Step-by-Step Deployment

### Step 1: Setup kind Cluster

```bash
./scripts/01-setup-kind-cluster.sh
```

**What this does:**
- Creates a 2-node kind cluster (1 control-plane + 1 worker)
- Uses Kubernetes v1.34.0
- Configures port mappings for accessing services (Grafana: 30300, MinIO: 30000/30001)
- Installs metrics-server for resource monitoring

**Expected output:**
```
✓ Kind cluster setup complete!
✓ Cluster name: spring-microservices-observability
✓ Nodes: 2 (1 control-plane + 1 worker)
✓ Kubernetes version: v1.34.0
```

**⏰ Time: 3-5 minutes**

---

### Step 2: Build and Load Docker Images

```bash
./scripts/02-build-images.sh
```

**What this does:**
- Builds user-service Docker image
- Builds order-service Docker image
- Loads images into kind cluster for use by Kubernetes

**Expected output:**
```
Building user-service...
Building order-service...
✓ Docker images built successfully!

REPOSITORY        TAG       IMAGE ID       CREATED         SIZE
user-service      latest    abc123...      5 seconds ago   450MB
order-service     latest    def456...      3 seconds ago   460MB
```

**⏰ Time: 5-8 minutes** (depends on internet speed for dependencies)

---

### Step 3: Deploy Observability Stack

```bash
./scripts/03-deploy-observability.sh
```

**What this does:**
- Creates `observability` namespace
- Deploys MinIO for S3-compatible storage
- Deploys OpenTelemetry Collector
- Deploys Mimir (metrics storage)
- Deploys Loki (log storage)
- Deploys Tempo (trace storage)
- Deploys Pyroscope (profiling)
- Deploys Grafana (visualization)

**Expected output:**
```
Creating namespaces...
Deploying MinIO (S3-compatible storage)...
Deploying OpenTelemetry Collector...
Deploying Mimir (Metrics Storage)...
Deploying Loki (Logs Storage)...
Deploying Tempo (Traces Storage)...
Deploying Pyroscope (Profiling)...
Deploying Grafana (Visualization)...
✓ Observability stack deployed successfully!

Observability Stack Status:
NAME                              READY   STATUS    RESTARTS   AGE
grafana-xxx                       1/1     Running   0          2m
loki-0                           1/1     Running   0          3m
mimir-0                          1/1     Running   0          4m
minio-xxx                        1/1     Running   0          5m
otel-collector-xxx               1/1     Running   0          4m
pyroscope-0                      1/1     Running   0          2m
tempo-0                          1/1     Running   0          3m
```

**⏰ Time: 5-7 minutes** (includes waiting for pods to be ready)

---

### Step 4: Deploy Microservices

```bash
./scripts/04-deploy-microservices.sh
```

**What this does:**
- Creates `microservices` namespace
- Deploys user-service (2 replicas)
- Deploys order-service (2 replicas)
- Waits for all pods to be ready

**Expected output:**
```
Deploying user-service...
Deploying order-service...
✓ Microservices deployed successfully!

Microservices Status:
NAME                              READY   STATUS    RESTARTS   AGE
order-service-xxx                 1/1     Running   0          1m
order-service-yyy                 1/1     Running   0          1m
user-service-xxx                  1/1     Running   0          2m
user-service-yyy                  1/1     Running   0          2m
```

**⏰ Time: 2-3 minutes**

---

### Step 5: Access Services

```bash
./scripts/05-access-services.sh
```

**Expected output:**
```
========================================
Service Access Information
========================================

Grafana Dashboard:
  URL: http://localhost:30300
  Username: admin
  Password: admin
  (exposed via NodePort through kind cluster)

MinIO Console (S3 Storage):
  URL: http://localhost:30001
  Username: minioadmin
  Password: minioadmin
  (exposed via NodePort through kind cluster)

To access microservices, create port-forwards:

User Service:
  kubectl port-forward -n microservices svc/user-service 8081:8081
  Then access: http://localhost:8081/api/users

Order Service:
  kubectl port-forward -n microservices svc/order-service 8082:8082
  Then access: http://localhost:8082/api/orders
```

---

## Verification Steps

### 1. Check All Pods Are Running

```bash
kubectl get pods -n observability
kubectl get pods -n microservices
```

**Expected:** All pods should show `STATUS: Running` and `READY: 1/1`

---

### 2. Access Grafana

1. Open browser: `http://localhost:30300`
   - (Thanks to kind's port mapping, services are accessible on localhost)

2. Login:
   - Username: `admin`
   - Password: `admin`

4. Verify datasources:
   - Go to **Configuration → Data Sources**
   - Should see: Mimir, Loki, Tempo, Pyroscope

---

### 3. Test Microservices

Open new terminal and create port-forwards:

**Terminal 1 - User Service:**
```bash
kubectl port-forward -n microservices svc/user-service 8081:8081
```

**Terminal 2 - Order Service:**
```bash
kubectl port-forward -n microservices svc/order-service 8082:8082
```

**Terminal 3 - Test APIs:**
```bash
# Test user service
curl http://localhost:8081/api/users
curl http://localhost:8081/api/users/1

# Test order service (will call user service internally)
curl http://localhost:8082/api/orders
curl http://localhost:8082/api/orders/user/1
```

---

### 4. Generate Sample Data

Run the traffic generator to create observability data:

```bash
./scripts/06-generate-traffic.sh
```

This will:
- Create port-forwards automatically
- Generate 20 rounds of API requests
- Create metrics, logs, and traces

**⏰ Time: ~1 minute**

---

## Exploring Observability Data in Grafana

### View Metrics (Mimir)

1. In Grafana, go to **Explore**
2. Select **Mimir** datasource
3. Try these queries:

```promql
# Request rate
rate(http_server_requests_seconds_count[5m])

# Response time (95th percentile)
histogram_quantile(0.95, rate(http_server_requests_seconds_bucket[5m]))

# Error rate
rate(http_server_requests_seconds_count{status=~"5.."}[5m])
```

---

### View Logs (Loki)

1. In Grafana, go to **Explore**
2. Select **Loki** datasource
3. Try these queries:

```logql
# All logs from user-service
{service_name="user-service"}

# Error logs
{service_name="user-service"} |= "error"

# Logs for specific user ID
{service_name="order-service"} |= "userId: 1"
```

---

### View Traces (Tempo)

1. In Grafana, go to **Explore**
2. Select **Tempo** datasource
3. Click **Search**
4. Filter by service: `user-service` or `order-service`
5. Click on a trace to see:
   - Request flow across services
   - Time spent in each service
   - Span details

**Look for:**
- Traces showing order-service → user-service calls
- Multi-span traces for distributed requests
- Correlated logs and metrics

---

### View Service Map

1. In Grafana, go to **Explore**
2. Select **Tempo** datasource
3. Click **Service Graph**
4. See visual representation of service dependencies

---

## Troubleshooting

### Pods Not Starting

```bash
# Check pod status
kubectl get pods -n observability
kubectl get pods -n microservices

# Check pod logs
kubectl logs -n observability <pod-name>

# Check pod events
kubectl describe pod -n observability <pod-name>
```

---

### Cannot Access Grafana

```bash
# Check service
kubectl get svc -n observability grafana

# Check if port 30300 is accessible
curl http://$(minikube ip):30300/api/health
```

---

### Microservices Not Receiving Traffic

```bash
# Check if OTEL Collector is running
kubectl get pods -n observability -l app=otel-collector

# Check collector logs
kubectl logs -n observability -l app=otel-collector

# Check microservice logs
kubectl logs -n microservices -l app=user-service
```

---

### MinIO Issues

```bash
# Check MinIO status
kubectl get pods -n observability -l app=minio

# Check if buckets were created
kubectl logs -n observability -l job-name=minio-setup
```

---

## Cleanup

### Remove All Deployments

```bash
./scripts/cleanup.sh
```

This will:
- Delete `microservices` namespace
- Delete `observability` namespace
- Remove all pods, services, and persistent volumes

---

### Stop Minikube (Keeps Data)

```bash
minikube stop
```

Restart later with:
```bash
minikube start
```

---

### Delete Minikube Completely

```bash
minikube delete
```

**Warning:** This removes all data permanently!

---

## Management Presentation Tips

### 1. Demo Flow

1. **Introduction (2 min)**
   - Show architecture diagram
   - Explain observability stack components

2. **Live System (5 min)**
   - Show running pods: `kubectl get pods --all-namespaces`
   - Access Grafana dashboard
   - Show datasources configured

3. **Metrics Demo (3 min)**
   - Run traffic generator
   - Show request rate increasing
   - Show response time metrics
   - Show error tracking

4. **Distributed Tracing (3 min)**
   - Make API call to order-service
   - Show trace in Tempo
   - Highlight service-to-service call
   - Show trace-to-logs correlation

5. **Logs Demo (2 min)**
   - Show structured logs in Loki
   - Filter by service
   - Show trace ID correlation

6. **Scalability (2 min)**
   - Explain how to add more services
   - Show configuration reusability
   - Discuss 40+ services architecture

---

### 2. Key Talking Points

**Why OpenTelemetry?**
- Industry standard (CNCF graduated)
- Vendor neutral
- Future-proof for 40+ services

**Why Grafana Stack?**
- Unified platform
- Cost-effective (open source)
- Production-proven at scale

**Long-term Storage (MinIO/S3)?**
- Cost-effective long-term retention
- Scalable storage
- Cloud-ready (compatible with AWS S3)

---

### 3. Questions to Anticipate

**Q: How does this scale to 40+ services?**
A: Each service uses the same OpenTelemetry configuration. Observability stack components (Mimir, Loki, Tempo) are horizontally scalable.

**Q: What about production security?**
A: POC uses basic auth. Production would add: TLS, OAuth2, network policies, secrets management, RBAC.

**Q: Cost implications?**
A: All components are open source. Main costs are infrastructure (compute, storage). S3 storage is cost-effective for long-term data.

**Q: Integration with existing systems?**
A: OpenTelemetry supports 40+ languages and frameworks. Can integrate with existing logging, monitoring, APM tools.

---

## Next Steps After POC

1. **Add 3-5 more sample services** to demonstrate scale
2. **Implement authentication** (OAuth2, JWT)
3. **Add alerting rules** in Grafana
4. **Create custom dashboards** for business metrics
5. **Setup CI/CD pipeline** for automated deployments
6. **Document SLIs/SLOs** for service reliability
7. **Cloud migration plan** (AWS EKS, GCP GKE, Azure AKS)

---

## Support & Resources

**Documentation:**
- README.md - Overview and quick start
- This file - Detailed deployment guide

**Logs:**
```bash
# View all logs
kubectl logs -n observability --all-containers --tail=100

# View specific component
kubectl logs -n observability -l app=otel-collector
```

**Status Check:**
```bash
# Overall health
kubectl get pods --all-namespaces
kubectl get svc --all-namespaces

# Resource usage
kubectl top pods -n observability
kubectl top pods -n microservices
```

---

**Good luck with your management presentation! 🚀**

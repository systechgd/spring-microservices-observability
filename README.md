# Spring Microservices Observability POC

A complete **Production-Ready Observability Stack** for Spring Boot microservices deployed on Minikube, featuring the modern Grafana observability stack with OpenTelemetry instrumentation.

## 🎯 Overview

This POC demonstrates a scalable observability solution for **40+ microservices** using industry-standard tools:

- **2 Sample Microservices**: User Service & Order Service (Java 21, Spring Boot 3.2, Gradle)
- **OpenTelemetry**: Industry-standard telemetry collection (CNCF graduated)
- **Grafana Stack**: Complete observability platform
  - **Mimir**: Long-term metrics storage
  - **Loki**: Log aggregation and querying
  - **Tempo**: Distributed tracing
  - **Pyroscope**: Continuous profiling
  - **Grafana**: Unified visualization dashboard
- **MinIO**: S3-compatible long-term storage
- **Kubernetes**: Production-ready deployment on Minikube

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Microservices                            │
│  ┌──────────────┐           ┌──────────────┐                │
│  │ User Service │◄──────────┤Order Service │                │
│  │   (8081)     │           │   (8082)     │                │
│  └──────┬───────┘           └──────┬───────┘                │
│         │ OTLP                     │ OTLP                    │
└─────────┼──────────────────────────┼─────────────────────────┘
          │                          │
          ▼                          ▼
┌─────────────────────────────────────────────────────────────┐
│              OpenTelemetry Collector                         │
│        (Metrics, Traces, Logs Collection)                    │
└─────┬──────────┬──────────┬──────────┬─────────────────────┘
      │          │          │          │
      ▼          ▼          ▼          ▼
┌─────────┐ ┌───────┐ ┌───────┐ ┌──────────┐
│  Mimir  │ │ Loki  │ │ Tempo │ │Pyroscope │
│(Metrics)│ │ (Logs)│ │(Traces│ │(Profiles)│
└────┬────┘ └───┬───┘ └───┬───┘ └────┬─────┘
     │          │          │          │
     └──────────┴──────────┴──────────┘
                    │
                    ▼
              ┌──────────┐
              │  MinIO   │ ← S3-compatible long-term storage
              │   (S3)   │
              └──────────┘
                    │
                    ▼
              ┌──────────┐
              │ Grafana  │ ← Unified Visualization
              │  (3000)  │
              └──────────┘
```

## 📦 Technology Stack

### Microservices
- **Language**: Java 21
- **Framework**: Spring Boot 3.2.1
- **Build Tool**: Gradle 8.5
- **Database**: H2 (in-memory)
- **Instrumentation**: OpenTelemetry Java Agent

### Observability Stack
| Component | Purpose | Port | Storage |
|-----------|---------|------|---------|
| OpenTelemetry Collector | Telemetry collection & forwarding | 4317, 4318 | - |
| Grafana Mimir | Metrics storage (Prometheus-compatible) | 8080 | MinIO |
| Grafana Loki | Log aggregation & storage | 3100 | MinIO |
| Grafana Tempo | Distributed tracing | 3200 | MinIO |
| Grafana Pyroscope | Continuous profiling | 4040 | Local |
| Grafana | Unified visualization | 3000 | - |
| MinIO | S3-compatible object storage | 9000, 9001 | PVC |

## 🚀 Quick Start

### Prerequisites

1. **Docker**: For container runtime
2. **Minikube**: Local Kubernetes cluster
3. **kubectl**: Kubernetes CLI
4. **Java 21**: For local development (optional)
5. **Gradle**: For building (optional, wrapper included)

### One-Command Deployment

```bash
./scripts/deploy-all.sh
```

This will:
1. ✅ Setup Minikube with recommended settings
2. ✅ Build Docker images for both microservices
3. ✅ Deploy complete observability stack
4. ✅ Deploy both microservices
5. ✅ Display access information

### Step-by-Step Deployment

```bash
# 1. Setup Minikube
./scripts/01-setup-minikube.sh

# 2. Build Docker images
./scripts/02-build-images.sh

# 3. Deploy observability stack
./scripts/03-deploy-observability.sh

# 4. Deploy microservices
./scripts/04-deploy-microservices.sh

# 5. View access information
./scripts/05-access-services.sh

# 6. Generate sample traffic (optional)
./scripts/06-generate-traffic.sh
```

## 🌐 Access Services

### Grafana Dashboard
```
URL: http://<minikube-ip>:30300
Username: admin
Password: admin
```

Get Minikube IP:
```bash
minikube ip
```

### Microservices (via port-forward)

**User Service**:
```bash
kubectl port-forward -n microservices svc/user-service 8081:8081
```
- API: http://localhost:8081/api/users
- Health: http://localhost:8081/actuator/health
- Metrics: http://localhost:8081/actuator/prometheus

**Order Service**:
```bash
kubectl port-forward -n microservices svc/order-service 8082:8082
```
- API: http://localhost:8082/api/orders
- Health: http://localhost:8082/actuator/health
- Metrics: http://localhost:8082/actuator/prometheus

### MinIO Console (S3 Storage)
```bash
kubectl port-forward -n observability svc/minio 9001:9001
```
- URL: http://localhost:9001
- Username: minioadmin
- Password: minioadmin

## 📊 Sample API Requests

### User Service

```bash
# Get all users
curl http://localhost:8081/api/users

# Get user by ID
curl http://localhost:8081/api/users/1

# Get active users
curl http://localhost:8081/api/users/active

# Create user
curl -X POST http://localhost:8081/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "username": "newuser",
    "email": "newuser@example.com",
    "firstName": "New",
    "lastName": "User",
    "active": true
  }'
```

### Order Service

```bash
# Get all orders
curl http://localhost:8082/api/orders

# Get order by ID
curl http://localhost:8082/api/orders/1

# Get orders for a user (demonstrates distributed tracing)
curl http://localhost:8082/api/orders/user/1

# Get orders by status
curl http://localhost:8082/api/orders/status/PENDING

# Create order (calls user-service for validation)
curl -X POST http://localhost:8082/api/orders \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "productName": "Laptop",
    "quantity": 1,
    "totalAmount": 1299.99,
    "status": "PENDING"
  }'
```

## 🔍 Observability Features

### 1. Metrics (Mimir)
- **Request Rate**: Requests per second by service and endpoint
- **Response Time**: Latency percentiles (p50, p95, p99)
- **Error Rate**: 4xx and 5xx error rates
- **JVM Metrics**: Memory, GC, threads
- **Custom Metrics**: Business metrics via Micrometer

**Query Example**:
```promql
rate(http_server_requests_seconds_count[5m])
```

### 2. Logs (Loki)
- **Structured Logging**: JSON format with correlation IDs
- **Trace Correlation**: Logs linked to traces via trace ID
- **Log Levels**: DEBUG, INFO, WARN, ERROR
- **Context Propagation**: Request ID, user ID, service name

**Query Example**:
```logql
{service_name="user-service"} |= "error"
```

### 3. Distributed Tracing (Tempo)
- **End-to-End Traces**: Track requests across services
- **Service Dependencies**: Automatic service graph generation
- **Performance Analysis**: Identify bottlenecks
- **Error Tracking**: Trace failed requests

**Features**:
- Automatic instrumentation via OpenTelemetry
- Trace-to-logs correlation
- Trace-to-metrics correlation
- Service map visualization

### 4. Continuous Profiling (Pyroscope)
- **CPU Profiling**: Identify performance hotspots
- **Memory Profiling**: Track memory allocation
- **Flame Graphs**: Visual performance analysis
- **Historical Comparison**: Compare profiles over time

## 🏢 Production Readiness

This POC is designed for management presentation and includes:

### Scalability
- ✅ Horizontal scaling support for all components
- ✅ Designed for 40+ microservices
- ✅ Load balancing with Kubernetes services
- ✅ Auto-scaling ready (HPA compatible)

### Reliability
- ✅ Health checks (liveness & readiness probes)
- ✅ Resource limits and requests
- ✅ Persistent storage for observability data
- ✅ High availability configurations

### Security
- ✅ Non-root containers
- ✅ Resource quotas
- ✅ Network policies ready
- ✅ Secret management structure

### Observability
- ✅ Complete telemetry (metrics, logs, traces, profiles)
- ✅ Service-to-service correlation
- ✅ SLI/SLO monitoring ready
- ✅ Alert rules structure

## 📁 Project Structure

```
spring-microservices-observability/
├── microservices/
│   ├── user-service/          # User management service
│   │   ├── src/
│   │   ├── Dockerfile
│   │   └── build.gradle
│   └── order-service/         # Order management service
│       ├── src/
│       ├── Dockerfile
│       └── build.gradle
├── k8s/
│   ├── namespace.yaml         # Kubernetes namespaces
│   ├── microservices/         # Microservice deployments
│   │   ├── user-service.yaml
│   │   └── order-service.yaml
│   └── observability/         # Observability stack
│       ├── otel-collector.yaml
│       ├── mimir.yaml
│       ├── loki.yaml
│       ├── tempo.yaml
│       ├── pyroscope.yaml
│       ├── grafana.yaml
│       └── minio.yaml
├── scripts/                   # Deployment automation
│   ├── deploy-all.sh
│   ├── 01-setup-minikube.sh
│   ├── 02-build-images.sh
│   ├── 03-deploy-observability.sh
│   ├── 04-deploy-microservices.sh
│   ├── 05-access-services.sh
│   ├── 06-generate-traffic.sh
│   └── cleanup.sh
├── build.gradle              # Root Gradle configuration
├── settings.gradle           # Gradle settings
├── docker-compose.yml        # Local development
└── README.md
```

## 🔧 Configuration

### OpenTelemetry Configuration

Both microservices are pre-configured with OpenTelemetry:

```yaml
# application.yml
otel:
  service:
    name: ${spring.application.name}
  exporter:
    otlp:
      endpoint: http://otel-collector:4318
  metrics:
    exporter: otlp
  traces:
    exporter: otlp
  logs:
    exporter: otlp
```

### Resource Requirements

**Minimum for POC (2 services)**:
- CPU: 4 cores
- Memory: 8 GB
- Disk: 20 GB

**Recommended for 40+ services**:
- CPU: 8-16 cores
- Memory: 16-32 GB
- Disk: 50-100 GB

## 📈 Monitoring & Dashboards

### Pre-configured Dashboards
1. **Microservices Overview**: Request rate, latency, errors
2. **Service Dependencies**: Auto-generated service map
3. **JVM Metrics**: Memory, GC, threads per service
4. **Distributed Traces**: End-to-end request tracking

### Custom Dashboards
Add custom dashboards by creating ConfigMaps in `k8s/observability/`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboard-custom
  namespace: observability
data:
  custom-dashboard.json: |
    { ... }
```

## 🧹 Cleanup

```bash
# Remove all deployments
./scripts/cleanup.sh

# Delete Minikube cluster
minikube delete
```

## 🔄 Adding More Microservices

To add additional microservices:

1. **Create service structure**:
   ```
   microservices/new-service/
   ├── src/
   ├── Dockerfile
   └── build.gradle
   ```

2. **Add to settings.gradle**:
   ```gradle
   include 'microservices:new-service'
   ```

3. **Include OpenTelemetry dependencies** (automatic via root build.gradle)

4. **Create Kubernetes manifest**:
   ```yaml
   # k8s/microservices/new-service.yaml
   ```

5. **Build and deploy**:
   ```bash
   eval $(minikube docker-env)
   docker build -t new-service:latest -f microservices/new-service/Dockerfile .
   kubectl apply -f k8s/microservices/new-service.yaml
   ```

## 🎓 Learning Resources

### OpenTelemetry
- [OpenTelemetry Java](https://opentelemetry.io/docs/instrumentation/java/)
- [Spring Boot with OpenTelemetry](https://spring.io/blog/2022/10/12/observability-with-spring-boot-3)

### Grafana Stack
- [Grafana Mimir](https://grafana.com/oss/mimir/)
- [Grafana Loki](https://grafana.com/oss/loki/)
- [Grafana Tempo](https://grafana.com/oss/tempo/)
- [Grafana Pyroscope](https://grafana.com/oss/pyroscope/)

## 📝 Why This Stack?

### OpenTelemetry vs Grafana Alloy

**✅ OpenTelemetry Selected** because:
1. **Industry Standard**: CNCF graduated project
2. **Vendor Neutral**: Works with any observability backend
3. **Mature Java Support**: Excellent Spring Boot auto-instrumentation
4. **Future-proof**: Wide adoption across industry
5. **Community**: Large community, extensive documentation
6. **Management Confidence**: Recognized standard for enterprise

**Grafana Alloy** (not selected):
- Newer, less mature
- Grafana-specific
- Smaller community
- Good for unified agent, but less proven at scale

### Storage Backend: MinIO vs Cloud S3

For this POC, MinIO provides:
- Local S3-compatible storage
- Easy Minikube deployment
- Production S3 compatibility
- Simple migration path to AWS/GCP/Azure

## 🚀 Next Steps for Production

1. **Security**:
   - Enable TLS/SSL
   - Implement authentication (OAuth2, JWT)
   - Add network policies
   - Secure secrets with Vault/Sealed Secrets

2. **High Availability**:
   - Scale observability components
   - Add load balancers
   - Configure replication
   - Implement backup/restore

3. **Monitoring**:
   - Define SLIs/SLOs
   - Create alert rules
   - Setup on-call rotation
   - Configure notification channels

4. **CI/CD**:
   - Automate builds (Jenkins, GitLab CI, GitHub Actions)
   - Implement GitOps (ArgoCD, Flux)
   - Add automated testing
   - Progressive delivery (Canary, Blue-Green)

## 📞 Support

For issues or questions:
- Check logs: `kubectl logs -n <namespace> <pod-name>`
- Check events: `kubectl get events -n <namespace>`
- Verify connectivity: `kubectl exec -it <pod> -- /bin/sh`

## 📄 License

This is a POC project for demonstration purposes.

---

**Created for Management POC** - Demonstrating production-ready observability for 40+ microservices architecture.

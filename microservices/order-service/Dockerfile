# Build stage
FROM gradle:8.5-jdk21 AS build
WORKDIR /app

# Copy gradle files
COPY settings.gradle build.gradle ./
COPY microservices/order-service/build.gradle ./microservices/order-service/

# Download dependencies
RUN gradle microservices:order-service:dependencies --no-daemon || true

# Copy source code
COPY microservices/order-service/src ./microservices/order-service/src

# Build application
RUN gradle microservices:order-service:bootJar --no-daemon

# Runtime stage
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy jar from build stage
COPY --from=build /app/microservices/order-service/build/libs/order-service.jar app.jar

# Change ownership
RUN chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 8082

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8082/actuator/health || exit 1

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]

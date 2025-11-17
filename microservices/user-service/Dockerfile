# Build stage
FROM gradle:8.5-jdk21 AS build
WORKDIR /app

# Copy gradle files
COPY settings.gradle build.gradle ./
COPY microservices/user-service/build.gradle ./microservices/user-service/

# Download dependencies
RUN gradle microservices:user-service:dependencies --no-daemon || true

# Copy source code
COPY microservices/user-service/src ./microservices/user-service/src

# Build application
RUN gradle microservices:user-service:bootJar --no-daemon

# Runtime stage
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copy jar from build stage
COPY --from=build /app/microservices/user-service/build/libs/user-service.jar app.jar

# Change ownership
RUN chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 8081

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8081/actuator/health || exit 1

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]

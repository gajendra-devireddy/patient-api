# Build Stage
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Production Stage - Hardened Container
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Non-root User Creation for Security Compliance
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy Built Artifact
COPY --from=builder /app/target/*.jar app.jar
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
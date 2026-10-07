# Stage 1: Build & Cache Dependencies
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app

# Cache Maven dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build (Run unit tests during build)
COPY src ./src
RUN mvn clean package -DskipTests=false

# Stage 2: Production Runtime
FROM eclipse-temurin:17-jre-alpine@sha256:d8122c4f8d5500e5e03a11d21b72186718bbd1ef20993510e3034963507d35eb
WORKDIR /app

# Non-root user compliance
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy single application artifact safely
COPY --from=builder /app/target/patient-api-*.jar app.jar
RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
# ---------- STAGE 1: Build ----------
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build

WORKDIR /app

# Copy all source files to /app
COPY . .

# Build the project, skipping tests
RUN ./mvnw clean package -DskipTests

# ---------- STAGE 2: Run ----------
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Use official Maven image with JDK 21 for building the project
FROM maven:3-openjdk-21 AS build

# Set the working directory inside the container
WORKDIR /

# Copy your Maven project files into the container
COPY pom.xml .
COPY src ./src

# Run Maven to build your app (skip tests for faster builds, optional)
RUN mvn clean install -DskipTests

# Use official OpenJDK 21 runtime image for running the app
FROM openjdk:21-jre-slim

# Set the working directory for the runtime container
WORKDIR /

# Copy the built artifact from the build container
COPY --from=build /target/my-app.jar /my-app.jar

# Command to run your Spring Boot application
CMD ["java", "-jar", "/my-app.jar"]

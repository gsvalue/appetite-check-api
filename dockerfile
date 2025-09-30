# Use official Maven image with JDK 21 for building the project
FROM maven:3.9.0-openjdk-21 AS build

# Set the working directory inside the container
WORKDIR /

# Copy the pom.xml and src directory for Maven build
COPY pom.xml .
COPY src ./src

# Run Maven to build the project
RUN mvn clean package -DskipTests

# Use official OpenJDK 21 runtime as a base image for the final runtime
FROM openjdk:21-jre-slim

# Set the working directory for the app
WORKDIR /

# Copy the compiled JAR file from the build image to the runtime image
COPY --from=build /target/*.jar app.jar

# Expose the port your app is running on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Use official Maven image with JDK 21 for building the project
FROM maven:3-openjdk-21 AS build

WORKDIR /

COPY pom.xml .
COPY src ./src

RUN mvn clean install -DskipTests

# Use official OpenJDK 21 runtime image (no -jre-slim tag exists)
FROM openjdk:21-slim

WORKDIR /

COPY --from=build /app/target/*.jar /app/app.jar

CMD ["java", "-jar", "/app/app.jar"]

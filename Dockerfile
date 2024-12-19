# FROM openjdk:17
# RUN mkdir -p /app/SP
# WORKDIR /app/SP
# COPY ./target/asi2-backendmarket-monolithic-student-0.0.1-SNAPSHOT.jar asi2-backendmarket-monolithic-student-0.0.1-SNAPSHOT.jar
# CMD ["java","-jar","asi2-backendmarket-monolithic-student-0.0.1-SNAPSHOT.jar"]

# Build stage
FROM maven:3.9 AS build
WORKDIR /usr/app
COPY . .
RUN mvn clean package

# Package stage
FROM eclipse-temurin:21-alpine
WORKDIR /usr/app
ENV SERVER_ADDRESS="0.0.0.0"
COPY --from=build /usr/app/target/*.jar app.jar
EXPOSE 8083
ENTRYPOINT java -jar app.jar

# Créez une image Docker légère basée sur l'image adoptopenjdk:17-jre
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY target/*.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]



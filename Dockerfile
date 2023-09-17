# Créez une image Docker légère basée sur l'image adoptopenjdk:17-jre
FROM eclipse-temurin:17-jdk-jammy

# Copiez le fichier JAR construit à partir de l'étape précédente
COPY --from=builder /app/target/crud-*.jar /app/app.jar

# Exposez le port sur lequel l'application Spring Boot écoute

# Commande pour exécuter l'application Spring Boot
CMD ["java", "-jar", "/app/app.jar"]


# Utilisez l'image de base Eclipse Temurin avec JDK 17
FROM eclipse-temurin:17-jdk-jammy

# Définissez le répertoire de travail
WORKDIR /app

# Copiez le fichier pom.xml et le fichier mvnw
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# Téléchargez les dépendances Maven
RUN ./mvnw dependency:resolve

# Copiez le reste du code source
COPY src ./src

# Compilez l'application
RUN ./mvnw clean install

# Créez une image Docker légère basée sur l'image adoptopenjdk:17-jre
FROM eclipse-temurin:17-jdk-jammy

# Copiez le fichier JAR construit à partir de l'étape précédente
COPY --from=builder /app/target/crud-*.jar /app/app.jar

# Exposez le port sur lequel l'application Spring Boot écoute
EXPOSE 8080

# Commande pour exécuter l'application Spring Boot
CMD ["java", "-jar", "/app/app.jar"]


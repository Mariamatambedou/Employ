pipeline {
    agent any
    stages {
        stage('Clean') {
            steps {
                // Supprimez le répertoire existant s'il existe, sans générer d'erreur s'il n'existe pas
                bat 'rmdir /s /q Employ || exit 0'
            }
        }

        stage('Clone') {
            steps {
                // Clonez le nouveau dépôt Git
                bat 'git clone https://github.com/Mariamatambedou/Employ.git Employ'
            }
        }

        stage('Build') {
            steps {
                // Construisez votre projet Spring Boot avec Maven
                bat 'mvn clean install -f Employ/pom.xml'
            }
        }

        stage('Archive JAR') {
            steps {
                // Archivez le fichier JAR en tant que artefact
                archiveArtifacts artifacts: 'Employ/target/*.jar', allowEmptyArchive: true
            }
        }

        stage('Test') {
           steps {
        // Exécutez les tests Maven par défaut sont la
            bat 'mvn test -f Employ/pom.xml'
            }
        }
        environment {
        // Vous pouvez définir ici les variables d'environnement nécessaires
        DOCKER_HUB_CREDENTIALS = credentials('tambadou-dockerhub')
        DOCKER_IMAGE_NAME = 'tambedou/app'
        DOCKERFILE_PATH = 'Dockerfile'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    dockerImage = docker.build("${DOCKER_IMAGE_NAME}"

    }
}

pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('tambadou-dockerhub')
        DOCKER_IMAGE_NAME = 'tambedou/app'
        DOCKERFILE_PATH = 'Dockerfile'
    }

    stages {
        stage('Clean') {
            steps {
                // Supprimez le répertoire existant s'il existe, sans générer d'erreur s'il n'existe pas
                sh 'rm -rf Employ || true'
            }
        }

        stage('Clone') {
            steps {
                // Clonez le nouveau dépôt Git
                sh 'git clone https://github.com/Mariamatambedou/Employ.git Employ'
            }
        }

        stage('Build') {
            steps {
                // Construisez votre projet Spring Boot avec Maven
                sh 'mvn clean install -f Employ/pom.xml'
            }
        }

        stage('Archive JAR') {
            steps {
                // Archivez le fichier JAR en tant qu'artefact
                archiveArtifacts artifacts: 'Employ/target/*.jar', allowEmptyArchive: true
            }
        }

        stage('Test') {
            steps {
                // Exécutez les tests Maven par défaut
                sh 'mvn test -f Employ/pom.xml'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    dockerImage = docker.build("${DOCKER_IMAGE_NAME}", "--file ${DOCKERFILE_PATH} .")
                }
            }
        }
    }
}

pipeline {
    agent any
     environment {
        DOCKER_REGISTRY = 'docker.io' // Ex: docker.io/votre_utilisateur
        IMAGE_NAME = 'testim2'
        IMAGE_TAG = 'latest'
        DOCKERFILE_PATH = 'Employ/Dockerfile' // Chemin spécifique à Windows
         DOCKER_HUB_TOKEN = credentials('keygit')
    }
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
                bat 'mvn clean install'
            }
        }

        stage('Archive JAR') {
            steps {
                // Archivez le fichier JAR en tant que artefact
                archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true
            }
        }

        stage('Test') {
           steps {
        // Exécutez les tests Maven par défaut sont la
            bat 'mvn test'
            }
        }
        stage('Build and Push Docker Image') {
        steps {
        script {
            // Construire l'image Docker en spécifiant le chemin du Dockerfile
            bat "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} -f ${DOCKERFILE_PATH} ."
            
            // Utilisez le jeton d'authentification Docker Hub pour vous connecter
            bat "echo ${DOCKER_HUB_TOKEN} | docker login -u tambedou --password-stdin ${DOCKER_REGISTRY}"
            
            // Poussez l'image Docker vers le registre
            bat "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
        }
    }
}


    }
}


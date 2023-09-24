pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'docker.io'
        IMAGE_NAME = 'testim2'
        IMAGE_TAG = 'latest'
        DOCKERFILE_PATH = 'Employ/Dockerfile'
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
                withCredentials([string(credentialsId: 'HUBKEY', variable: 'DOCKER_HUB_PASSWORD')]) {
                    script {
                        // Construire l'image Docker en spécifiant le chemin du Dockerfile
                        def dockerBuildCmd = "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} -f ${DOCKERFILE_PATH} ."
                        echo "Commande Docker Build: ${dockerBuildCmd}"
                        bat dockerBuildCmd
                        
                        // Utilisez le mot de passe Docker Hub pour vous connecter
                        def dockerLoginCmd = "echo ${DOCKER_HUB_PASSWORD} | docker login -u tambedou89mariama@gmail.com --password-stdin ${DOCKER_REGISTRY}"
                        echo "Commande Docker Login: ${dockerLoginCmd}"
                        bat dockerLoginCmd
                        
                        // Poussez l'image Docker vers le registre
                        def dockerPushCmd = "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                        echo "Commande Docker Push: ${dockerPushCmd}"
                        bat dockerPushCmd
                    }
                }
            }
        }
    










    }
}


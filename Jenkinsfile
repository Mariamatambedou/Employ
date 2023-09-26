pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'docker.io/tambedou' // Exemple : docker.io/votre_utilisateur
        IMAGE_NAME = 'jpimage3'
        IMAGE_TAG = 'latest'
        DOCKERFILE_PATH = 'Employ/Dockerfile' // Chemin spécifique à Linux
        DOCKER_HUB_USERNAME = 'tambedou'
        DOCKER_HUB_TOKEN = 'Github'
        
    }

    stages {
        stage('Checkout') {
            steps {
                // Utilisation des informations d'identification pour Git
                checkout([$class: 'GitSCM', 
                    branches: [[name: 'main']], 
                    userRemoteConfigs: [[
                        url: 'https://github.com/Mariamatambedou/Employ.git'
                    ]]
                ])
            }
        }

        stage('Build and Test') {
            steps {
                // Nettoyez le projet
                sh 'mvn clean install'

                // Vérifiez les dépendances
                // sh 'mvn dependency:resolve'

                // Exécutez la phase package
                sh 'mvn package'

                // Vérifiez si l'étape précédente a réussi
                script {
                    if (currentBuild.resultIsWorseOrEqualTo('FAILURE')) {
                        error("La construction a échoué. Vérifiez les journaux de construction.")
                    }
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Construire l'image Docker en spécifiant le chemin du Dockerfile
                    sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} -f ${DOCKERFILE_PATH} ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Authentification Docker Hub en utilisant le token d'authentification
                    sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_TOKEN}"

                    // Poussez l'image vers Docker Hub
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminé avec succès!'
        }
        failure {
            echo 'Le pipeline a échoué. Veuillez vérifier les étapes précédentes.'
        }
    }
}

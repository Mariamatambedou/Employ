pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('HUBKEY')
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
                // Archivez le fichier JAR en tant qu'artefact
                archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: true
            }
        }

        stage('Test') {
            steps {
                // Exécutez les tests Maven par défaut
                bat 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t tambedou/jenkins-docker-hub .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
               
                    bat 'echo Docker1997? | docker login -u tambedou --password-stdin'
                
            }
        }

        stage('Push Docker Image') {
            steps {
                bat 'docker push tambedou/jenkins-docker-hub'
            }
        }
    }
    post {
        always {
            bat 'docker logout'
        }
    }
}

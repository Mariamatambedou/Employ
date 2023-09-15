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
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerImageName = 'dockerimage:tag' // Remplacez par le nom et la version souhaités
                    def dockerfile = '''
                        FROM eclipse-temurin:17-jdk-jammy
                        WORKDIR /app
                        COPY Employ/target/*.jar app.jar
                        ENTRYPOINT ["java", "-jar", "app.jar"]
                    '''
                    writeFile file: 'Dockerfile', text: dockerfile
                    bat "docker build -t $dockerImageName ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    bat 'docker login -u tambedou -p Docker1997? https://hub.docker.com/repository/docker/tambedou/app'

                    def dockerImageName = 'dockerimage:tag' // Remplacez par le nom et la version de l'image Docker
                    bat "docker push $dockerImageName"
                }
            }
        }

    }
}


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
                bat 'mvn clean install'
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
        stage('Run Docker Container') {
    steps {
        script {
            def dockerImageName = 'dockerimage:tag' // Remplacez par le nom et la version de votre image Docker
            def containerName = 'my-container' // Remplacez par le nom de votre choix pour le conteneur
            
            // Exécutez le conteneur à partir de votre image Docker
            bat "docker run -d --name $containerName -p 8087:8080 $dockerImageName"
        }
    }
}
        stage('Push Docker Image to Docker Hub') {
    steps {
        script {
            def dockerImageName = 'dockerhubusername/dockerimage:tag' // Remplacez par votre nom d'utilisateur Docker Hub et le nom de l'image souhaités
            def dockerHubCredentials = credentials('keygit') // Utilisez le secret Jenkins pour le token Docker Hub
            def dockerHubToken = dockerHubCredentials.getPassword() // Récupérez le mot de passe (token) du secret

            // Utilisez le token pour vous connecter à Docker Hub
            bat "docker login -u dockerhubusername -p ${dockerHubToken}"
            bat "docker push $dockerImageName"
        }
    }
}


    }
}


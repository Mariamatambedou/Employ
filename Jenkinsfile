pipeline {
  agent any
  
  environment {
    DOCKER_HUB_CREDENTIALS = credentials('tambadou-dockerhub')
  }  

   stages {
    stage('Build') {
      steps {
        sh 'docker build -t tambedou/app .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $ DOCKER_HUB_CREDENTIALS | docker login -u $ DOCKER_HUB_CREDENTIALS --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push  tambedou/app'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
       

    
        
    
}


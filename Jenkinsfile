pipeline {
  agent any

  environment {
    IMAGE_NAME = 'finead-todo-app'
    DOCKER_HUB_CREDS = 'docker-hub-credentials'
  }

  stages {
    stage('Build') {
      steps {
        echo 'Installing dependencies...'
        sh 'npm install'
      }
    }

    stage('Test') {
      steps {
        echo 'Running unit tests...'
        sh 'npm test'
      }
    }

    stage('Containerize') {
      steps {
        echo 'Building Docker image...'
        sh "docker build -t ${IMAGE_NAME}:latest ."
      }
    }

    stage('Push') {
      steps {
        echo 'Pushing to Docker Hub...'
        withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDS}", passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
          sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
          sh "docker tag ${IMAGE_NAME}:latest \$DOCKER_USER/${IMAGE_NAME}:latest"
          sh "docker push \$DOCKER_USER/${IMAGE_NAME}:latest"
        }
      }
    }
  }

  post {
    always {
      echo 'Cleanup...'
      sh "docker rmi ${IMAGE_NAME}:latest || true"
    }
  }
}
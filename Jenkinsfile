pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub')
        DEV_IMAGE  = 'nishal3098/devops-build-dev'
        PROD_IMAGE = 'nishal3098/devops-build-prod'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin'
            }
        }

        stage('Build & Push - DEV') {
            when { branch 'dev' }
            steps {
                sh 'docker build -t $DEV_IMAGE:$BUILD_NUMBER -t $DEV_IMAGE:latest .'
                sh 'docker push $DEV_IMAGE:$BUILD_NUMBER'
                sh 'docker push $DEV_IMAGE:latest'
            }
        }

        stage('Build & Push - PROD') {
            when { branch 'master' }
            steps {
                sh 'docker build -t $PROD_IMAGE:$BUILD_NUMBER -t $PROD_IMAGE:latest .'
                sh 'docker push $PROD_IMAGE:$BUILD_NUMBER'
                sh 'docker push $PROD_IMAGE:latest'
            }
        }

        stage('Deploy') {
            when { branch 'master' }
            steps {
                sh 'docker pull $PROD_IMAGE:latest'
                sh 'docker stop devops-build || true'
                sh 'docker rm devops-build || true'
                sh 'docker run -d --name devops-build -p 80:80 --restart unless-stopped $PROD_IMAGE:latest'
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}
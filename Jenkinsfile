pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t my-nginx-image .'
            }
        }
        stage('Docker Run & Test') {
            steps {
                sh 'docker rm -f test-nginx-container || true'
                sh 'docker run -d -p 8081:80 --name test-nginx-container my-nginx-image'
                sh 'curl -I http://localhost:8081'
            }
        }
    }
}

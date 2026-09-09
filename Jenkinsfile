def app

pipeline {
    agent any

    environment {
        REGISTRY_URL = 'ghcr.io/mejrichawki157-rgb'
        IMAGE_NAME   = "${env.REGISTRY_URL}/jenkins-docker-demo"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    app = docker.build("${env.IMAGE_NAME}")
                }
            }
        }

        stage('Docker Run & Test') {
            steps {
                sh 'docker rm -f test-nginx-container || true'
                sh "docker run -d -p 8081:80 --name test-nginx-container ${env.IMAGE_NAME}"
                sh 'docker exec test-nginx-container curl -I http://localhost'
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry('https://ghcr.io', 'jenkins-credentials-id-new') {
                        app.push("latest")
                        app.push("version-${env.BUILD_NUMBER}")
                    }
                }
            }
        }
    }
}

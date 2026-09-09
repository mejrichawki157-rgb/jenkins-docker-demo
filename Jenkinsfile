pipeline {
    agent any
    environment {
        REGISTRY_URL = 'ghcr.io/mejrichawki157-rgb'
        IMAGE_NAME = "${env.REGISTRY_URL}/jenkins-docker-demo"
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
                    // N-buildiw el-image b el-latest w n-taggiwiha m-baɛd
                    sh "docker build -t ${env.IMAGE_NAME}:latest -t ${env.IMAGE_NAME}:version-${env.BUILD_ID} ."
                }
            }
        }
        stage('Docker Run & Test') {
            steps {
                sh 'docker rm -f test-nginx-container || true'
                sh "docker run -d -p 8081:80 --name test-nginx-container ${env.IMAGE_NAME}:latest"
                sh 'docker exec test-nginx-container curl -I http://localhost'
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry('https://ghcr.io', 'jenkins-credentials-id-new') {
                        // Tawa el-tags el-zouj mawjoudin w y-t-poussyiw b-najaħ
                        sh "docker push ${env.IMAGE_NAME}:latest"
                        sh "docker push ${env.IMAGE_NAME}:version-${env.BUILD_ID}"
                    }
                }
            }
        }
    }
}

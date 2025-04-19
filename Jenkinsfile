pipeline {
    agent any
     tools {
        jdk 'java21'
     }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_cred')
        DOCKER_IMAGE = "molla2011/jpetstore"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/abdallahelmalawany/Java_DevOps_CICD_project.git'
            }
        }
        stage('Build') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }
        stage('Test') {
            steps {
                sh './mvnw test'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub_cred') {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").push()
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_NUMBER}").push('latest')
                    }
                }
            }
        }
        stage('Deploy with Ansible') {
            steps {
                ansiblePlaybook(
                    playbook: 'ansibleplaybook.yaml',
                    inventory: 'inventory',
                    extras: "-e docker_image=${DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                )
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}

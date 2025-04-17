pipeline {
    agent any
    tools {
        jdk 'java21'
    }
    environment {
        JAVA_HOME = "${tool 'java21'}"
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install -Dcargo.servlet.port=8081 -DskipTests'
                sh 'ls -al target/'  // Verify the JAR file is in the target folder
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test -Dcargo.servlet.port=8081'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t 'molla2011/finalproject:latest' ."
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub_cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push molla2011/finalproject:latest
                    '''
                }
            }
        }
    }
}


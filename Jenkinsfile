pipeline {
    agent {
        kubernetes {
            yamlFile 'kube_yamls/jenkins/jenkins-pod.yaml'
            retries 2
        }
    }
     environment {
        IMAGE_NAME = 'quickstart'
        TAG = "${env.BUILD_ID}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                container('maven') {
                   git (
                        url:'git@github.com:samuel-cavalcanti/quarkus-quickstart.git',
                        branch: 'main',
                        credentialsId: 'DEPLOY_KEY',
                        )
                }
            }
        }

        stage('Test and build'){
            steps {
                container('maven') {
                   sh 'mvn -B -ntp verify'
                }
            }
        }
        
        stage('Build docker Image'){
            steps {
                   container('docker') {
                    script {
                        withCredentials([usernamePassword(
                            credentialsId: 'DOCKERHUB',
                            usernameVariable: 'REGISTRY_USER',
                            passwordVariable: 'REGISTRY_PASSWORD'
                        )]) {
                            sh """
                            docker build -t ${env.REGISTRY_USER}/${env.IMAGE_NAME}:${env.TAG} .
                            docker login -u $REGISTRY_USER -p $REGISTRY_PASSWORD
                            docker tag ${env.REGISTRY_USER}/${env.IMAGE_NAME}:${env.TAG} ${env.REGISTRY_USER}/${env.IMAGE_NAME}:latest
                            docker push ${env.REGISTRY_USER}/${env.IMAGE_NAME}:${env.TAG}
                            docker push ${env.REGISTRY_USER}/${env.IMAGE_NAME}:latest
                            """
                        }
                    }
                }
            }
        }
    }
}

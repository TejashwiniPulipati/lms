pipeline {
    agent any

    environment {
        REGISTRY_CREDENTIALS = "dockerhub-credentials"
        KUBECONFIG_CRED = 'kubeconfig'
    }    

    stages {
        stage('Extract Version') {
            steps {
                script {
                    def packageJson = readJSON file: 'webapp/package.json'
                    env.APP_VERSION = packageJson.version
                    echo "App Version: ${APP_VERSION}"
                }
            }
        }

        stage('Build and Push Docker Images and deploy in containers') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: REGISTRY_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

                        docker build -t pulipatitejashwini/lms-fe:${APP_VERSION} webapp/
                        docker push pulipatitejashwini/lms-fe:${APP_VERSION}
                        
                        """
                    }
                }
            }
        }

        stage('Deploy-to-kuberbetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_CRED')]) {
                sh """
                export KUBECONFIG=\$KUBECONFIG_CRED
                echo "Using Kubeconfig: \$KUBECONFIG_CRED"
                ls -R
                sed -i 's|IMAGE_VERSION|${APP_VERSION}|g' deployment.yml
                kubectl apply -f deployment.yml
                """
                }
            }
        }

    }
}

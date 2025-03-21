pipeline {
    agent any

    environment {
        REGISTRY_CREDENTIALS = "dockerhub-credentials"
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

        stage('Build and Push Docker Images') {
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

        stage('Setup Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Provision Docker Server') {
            steps {
                script {
                    // -auto-approve means Terraform will apply the changes without asking for confirmation.
                    //returnStdout: true captures Terraform's output as a variable.
                    //.trim() removes unnecessary whitespaces from the output.
                    //def terraformOutput = ...Stores the Terraform output in the variable terraformOutput.
                    //echo "Terraform Output: ${terraformOutput}" - Prints the Terraform execution output in the Jenkins console logs.
                    //If the server does not exist, Terraform will create it.
                    //If the server already exists, Terraform will return:
                    //Terraform Output: 
                    //No changes. Infrastructure is up-to-date.
                    def terraformOutput = sh(script: 'terraform apply -auto-approve', returnStdout: true).trim()
                    echo "Terraform Output: ${terraformOutput}"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

    

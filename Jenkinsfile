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

        stage('Build and Push Docker Images and deploy in containers') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: REGISTRY_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

                        docker container rm -f lms-db || true
                        docker container run -dt --name lms-db -e POSTGRES_PASSWORD=app12345 postgres
                        
                        
                        docker build -t pulipatitejashwini/lms-be:${APP_VERSION} api/
                        docker push pulipatitejashwini/lms-be:${APP_VERSION}
                        docker container rm -f lms-be || true
                        docker run -dt --name lms-be -p 8081:8080 \
                             -e DATABASE_URL="postgresql://postgres:app12345@lms-db:5432/postgres?schema=public" pulipatitejashwini/lms-be:${APP_VERSION}

                        docker build -t pulipatitejashwini/lms-fe:${APP_VERSION} webapp/
                        docker push pulipatitejashwini/lms-fe:${APP_VERSION}
                        docker container rm -f lms-fe || true
                        docker run -dt --name lms-fe -p 80:80 \
                             -e VITE_API_URL=http://lms-be:8080/api pulipatitejashwini/lms-fe:${APP_VERSION}
                        
                        """
                    }
                }
            }
        }

    }
}

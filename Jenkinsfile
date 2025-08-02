pipeline{
    agent any
    tools {
        maven 'MAVEN3.9'
    }
    environment {
        DOCKER_IMAGE = "vpro-app-image"
        CONTAINER_NAME = "vpro-container"
        WAR_DEST_PATH = "Docker-files/app"
    }

    stages {
        stage('Fetch Code') {
            steps {
                git branch: 'master', url: 'https://github.com/diabolushari/docker.git'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn install -DskipTests'
            }
        }
        stage('Unit Test') {
            steps {
                bat 'mvn test'
            }
        }
        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }
        stage('Copy Artifact to Local Folder and app floder') {
            steps {
                bat 'copy target\\*.war D:\\Study\\P1\\Myartifacts\\'
                bat 'copy target\\vprofile-v2.war Docker-files\\app\\ROOT.war'
                bat 'copy target\\vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war'
            }
        }
        stage('Prepare WAR for Docker') {
            steps {
                bat 'copy target\\*.war myapp.war'
            }
        }
        stage('Clean Previous Container') {
            steps {
                bat 'docker rm -f %CONTAINER_NAME% || exit 0'
            }
        }
        stage('Stop Previous Containers') {
            steps {
                bat 'docker-compose down || exit 0'
            }
        }

        stage('Start with Docker Compose') {
            steps {
                bat 'docker-compose up --build -d'
            }
        }
        
        stage('Build Docker Images for K8s') {
            steps {
                bat 'copy target\\vprofile-v2.war Docker-files\\app\\vprofile-v2.war'
                bat 'docker build -t vprocontainers/vprofileapp:%BUILD_NUMBER% -f Docker-files/app/Dockerfile .'
                bat 'docker build -t vprocontainers/vprofiledb:%BUILD_NUMBER% -f Docker-files/db/Dockerfile .'
                bat 'docker build -t vprocontainers/vprofileweb:%BUILD_NUMBER% -f Docker-files/web/Dockerfile .'
            }
        }
        
        stage('Push to Registry') {
            steps {
                bat 'docker push vprocontainers/vprofileapp:%BUILD_NUMBER%'
                bat 'docker push vprocontainers/vprofiledb:%BUILD_NUMBER%'
                bat 'docker push vprocontainers/vprofileweb:%BUILD_NUMBER%'
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                bat 'kubectl apply -f k8s/namespace.yaml'
                bat 'kubectl apply -f k8s/mysql-deployment.yaml'
                bat 'kubectl apply -f k8s/memcached-deployment.yaml'
                bat 'kubectl apply -f k8s/rabbitmq-deployment.yaml'
                bat 'kubectl apply -f k8s/vproapp-deployment.yaml'
                bat 'kubectl apply -f k8s/nginx-deployment.yaml'
            }
        }
        
        stage('Verify Auto-Scaling') {
            steps {
                bat 'kubectl get hpa -n vprofile'
                bat 'kubectl get pods -n vprofile'
                bat 'kubectl apply -f k8s/load-test.yaml'
                bat 'timeout 30 && kubectl get hpa vproapp-hpa -n vprofile'
            }
        }
    }    
    post {
        success {
            echo "Deployment successful!"
            echo "Docker: http://localhost:8081"
            echo "Kubernetes: kubectl get svc -n vprofile"
        }
        failure {
            echo "Pipeline failed."
        }
        always {
            bat 'docker system prune -f || exit 0'
        }
    }  
}

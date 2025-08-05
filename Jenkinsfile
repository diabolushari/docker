pipeline{
    agent any
    tools {
        maven 'MAVEN3.9'
    }
    environment {
        DOCKER_IMAGE = "vpro-app-image"
        CONTAINER_NAME = "vpro-container"
        WAR_DEST_PATH = "Docker-files/app"
        KUBECONFIG = "C:\\Users\\Harikrishnan B S\\.kube\\config"
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
                bat "docker build -t diabolus6/vprofileapp:latest -f Docker-files/app/Dockerfile Docker-files/app"
                bat "docker build -t diabolus6/vprofiledb:latest -f Docker-files/db/Dockerfile Docker-files/db"
                bat "docker build -t diabolus6/vprofileweb:latest -f Docker-files/web/Dockerfile Docker-files/web"
            }
        }

        stage('Debug K8s Access') {
            steps {
                bat 'kubectl config get-contexts'
                bat 'kubectl cluster-info'
            }
        }

        stage('Push Docker Images to Docker Hub') {
            steps {
                bat "docker login -u diabolus6 -p Stuffoli@123"
                bat "docker push diabolus6/vprofileapp:latest"
                bat "docker push diabolus6/vprofiledb:latest"
                bat "docker push diabolus6/vprofileweb:latest"
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                bat 'kubectl apply -f k8s/namespace.yaml --validate=false'
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
                bat 'ping -n 31 127.0.0.1 > nul'
                bat 'kubectl get hpa vproapp-hpa -n vprofile'
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

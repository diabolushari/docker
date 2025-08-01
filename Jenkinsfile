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
                bat "copy target\\vprofile-v2.war Docker-files\\app\\ROOT.war"
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
    }    
    post {
        success {
            echo "Deployment successful! App running on http://<jenkins-host>:8080"
        }
        failure {
            echo "Pipeline failed."
        }
        always {
            bat 'docker-compose up -d'
        }
    }  
}

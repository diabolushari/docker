# Jenkins Docker Setup

## Option 1: Install Docker on Jenkins Server
1. Install Docker Desktop on the Jenkins server
2. Start Docker Desktop
3. Verify with: `docker version`

## Option 2: Jenkins Pipeline with Docker
Add this to your Jenkinsfile:

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    // Check if Docker is running
                    bat 'docker version'
                    // Build and run containers
                    bat 'docker-compose up --build -d'
                }
            }
        }
    }
}
```

## Option 3: Use Docker Socket (Linux/WSL)
Mount Docker socket in Jenkins container:
```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins
```
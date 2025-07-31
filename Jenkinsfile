pipeline {
    
	agent any	
	tools {
        maven "MAVEN3.9"
    }	
    environment {
        // Nexus and SonarQube variables removed
        ARTVERSION = "${env.BUILD_ID}"
    }
	
    stages {
        stage('BUILD') {
            steps {
                bat 'mvn clean install -DskipTests'
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
        stage('UNIT TEST') {
            steps {
                bat 'mvn test'
            }
        }

        stage('DOCKER COMPOSE UP (LOCAL)') {
            steps {
                bat 'docker-compose up -d'
            }
        }

	    stage('INTEGRATION TEST') {
            steps {
                bat 'mvn verify -DskipUnitTests'
            }
        }
		
        stage ('CODE ANALYSIS WITH CHECKSTYLE') {
            steps {
                bat 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
            }
        }
    }
}

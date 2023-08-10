pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your GitHub repository
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'https://github.com/sodhanareddy/DevOpsFinal']]])
            }
        }
        
        stage('Build and Deploy') {
            steps {
                // Build the Docker image
                script {
                    def customImage = docker.build("web-app:${env.BUILD_NUMBER}")
                }
                
                // Run the Docker container
                script {
                    customImage.inside {
                        sh 'docker run -d -p 8080:80 web-app:${env.BUILD_NUMBER}'
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Clean up: Stop the running container
            script {
                sh 'docker stop $(docker ps -a -q --filter ancestor=web-app:${env.BUILD_NUMBER})'
                sh 'docker rm $(docker ps -a -q --filter ancestor=web-app:${env.BUILD_NUMBER})'
            }
        }
    }
}

#!/usr/bin/env groovy

pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout the repository from your Git repository URL using the 'master' branch
                git branch: 'master', url: 'https://github.com/sodhanareddy/DevOpsFinal.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile from the repository
                script {
                    def dockerImage = docker.build("devops:${env.BUILD_ID}", "-f Dockerfile .")
                    // Save the dockerImage variable as an environment variable for later use
                    env.IMAGE_NAME = "devops:${env.BUILD_ID}"
		    sh "echo ${env.BUILD_ID}"
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            environment {
                // Define your Docker Hub username and repository name
                DOCKER_HUB_USERNAME = 'sodhanareddy'
                DOCKER_HUB_REPOSITORY = 'devops'
                // Define your Docker Hub password
                DOCKER_HUB_PASSWORD = 'Bharath@1'
            }
            steps {
                // Tag the Docker image with Docker Hub repository name
                script {
                    sh "docker tag ${env.IMAGE_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:${env.BUILD_ID}"
                    sh "docker tag ${env.IMAGE_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:latest"
                }
                // Log in to Docker Hub
                sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"

                // Push the Docker image to Docker Hub
                sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:${env.BUILD_ID}"
                sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:latest"
            }
        }

        stage('Run Docker Container') {
            steps {
                // Run the Docker container from the built image with port 8000 mapped to the host
                script {
		    sh "docker ps -aq --filter \"name=my_web_app_container\" | xargs -r docker rm -f"	
                    sh "docker run -p 8000:80 -d --name my_web_app_container --rm ${env.IMAGE_NAME}"
                }
            }
        }
    }
}

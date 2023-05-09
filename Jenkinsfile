pipeline {
    agent any

    stages {
        stage('SCM Checkout') {
            steps {
                git 'https://github.com/rajani103/node-todo-cicd.git'
            }
        }
        stage('Build docker image') {
            steps {
                sh 'docker build -t dockerhub_username/image_name:tag .'
            }
        }
        stage('Push image to dockerhub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', passwordVariable: 'dockerhub_password', usernameVariable: 'dockerhub_username')]) {
                sh "docker login -u dockerhub_username -p ${dockerhub_password}"
                sh 'docker push dockerhub_username/image_name:tag'
                    
                }
            }
        }
        stage('Accept Host Key') {
            steps {
                sh "ssh-keyscan REMOTE_HOST >> ~/.ssh/known_hosts"
            }
        }
        
        stage('Deploy container') {
            steps {
              withCredentials([usernamePassword(credentialsId: 'sshID', passwordVariable: 'ssh_password', usernameVariable: 'ssh_login')]) {
                sh "sshpass -p '${ssh_password}' ssh ${ssh_login}@REMOTE_HOST 'docker pull dockerhub_username/image_name:tag'"
                sh "sshpass -p '${ssh_password}' ssh ${ssh_login}@REMOTE_HOST 'docker stop container_name || true'"
                sh "sshpass -p '${ssh_password}' ssh ${ssh_login}@REMOTE_HOST 'docker rm container_name || true'"
                sh "sshpass -p '${ssh_password}' ssh ${ssh_login}@REMOTE_HOST'docker run -d -p external_port:8000 --name container_name dockerhub_username/image_name:v1'"
                  
              }
            }
        }    
    }
}

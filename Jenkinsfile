pipeline {
    agent {
        docker {
            image 'docker:27-cli'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        APP_NAME = 'react-app'
        IMAGE_NAME = 'react-app:latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/harshalif/Jenkins_Tutorial'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                docker stop $APP_NAME || true
                docker rm $APP_NAME || true
                '''
            }
        }

        stage('Run New Container') {
            steps {
                sh 'docker run -d -p 80:80 --name $APP_NAME --restart=always $IMAGE_NAME'
            }
        }
    }

    post {
        success {
            echo '✅ React App Deployed Successfully'
        }
        failure {
            echo '❌ Deployment Failed. Check Build Logs!'
        }
    }
}

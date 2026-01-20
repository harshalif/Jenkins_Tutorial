pipeline {
    agent any

    environment {
        APP_NAME = "react-app"
        IMAGE_NAME = "react-app:latest"
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
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Stop Old Container') {
            steps {
                bat 'docker stop %APP_NAME% || exit 0'
                bat 'docker rm %APP_NAME% || exit 0'
            }
        }

        stage('Run New Container') {
            steps {
                bat 'docker run -d -p 80:80 --name %APP_NAME% --restart=always %IMAGE_NAME%'
            }
        }
    }

    post {
        success {
            echo "✅ React App Deployed Successfully"
        }
        failure {
            echo "❌ Deployment Failed. Check Build Logs!"
        }
    }
}

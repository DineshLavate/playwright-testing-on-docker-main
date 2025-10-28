pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-python-tests'   // Docker image name
        GIT_REPO = 'https://github.com/DineshLavate/playwright-testing-on-docker-main.git'  // Replace with your repo
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Cloning test framework from GitHub...'
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image for Playwright tests...'
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Run Tests in Docker') {
            steps {
                echo 'Running Playwright + Pytest tests inside container...'
                // Run tests and mount allure-results back to host
                sh '''
                    mkdir -p allure-results
                    docker run --rm \
                      -v $PWD/allure-results:/app/allure-results \
                      ${IMAGE_NAME}
                '''
            }
        }

        stage('Publish Allure Report') {
            steps {
                echo 'Generating and publishing Allure report...'
                allure includeProperties: false, jdk: '', results: [[path: 'allure-results']]
            }
        }
    }

    post {
        always {
            echo 'Cleaning up unused Docker resources...'
            sh 'docker system prune -af'
        }
        success {
            echo '✅ All tests passed successfully!'
        }
        failure {
            echo '❌ Some tests failed. Check Allure report for details.'
        }
    }
}

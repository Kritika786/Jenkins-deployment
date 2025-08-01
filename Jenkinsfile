pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['dev', 'staging', 'prod'], description: 'Environment to deploy to')
        string(name: 'VERSION', defaultValue: 'latest', description: 'Version tag or label')
    }

    environment {
        DEPLOY_SCRIPT = './deploy.sh'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/your-username/my-app.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'pytest test/'
            }
        }

        stage('Build Artifact') {
            steps {
                sh 'zip -r myapp-${params.VERSION}.zip *'
            }
        }

        stage('Deploy') {
            steps {
                sh "${DEPLOY_SCRIPT} ${params.ENV} ${params.VERSION}"
            }
        }
    }

    post {
        success {
            echo "✅ Deployed ${params.VERSION} to ${params.ENV}"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}


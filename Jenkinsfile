pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['dev', 'staging', 'prod', 'main', 'master'], description: 'Environment to deploy to')
        string(name: 'VERSION', defaultValue: 'latest', description: 'Version tag or label')
    }

    environment {
        DEPLOY_SCRIPT = './deploy.sh'
    }

    stages {
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
                sh "zip -r myapp-${env.VERSION}.zip ."
            }
        }

        stage('Deploy') {
    steps {
        sh """
            chmod +x ${DEPLOY_SCRIPT}
            ${DEPLOY_SCRIPT} ${ENV} ${VERSION}
        """
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

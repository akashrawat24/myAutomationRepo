pipeline {
    agent { label 'ecs' } // runs on slave
    environment {
        AWS_REGION = 'us-east-2'
        ECR_REPO = '055.dkr.ecr.us-east-2.amazonaws.com/jenkins-ecs-demo'
        IMAGE_TAG = "${GIT_COMMIT}"
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/akashrawat24/myAutomation.git', branch: 'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO:$IMAGE_TAG .'
            }
        }
        stage('Login to ECR') {
            steps {
                sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO'
            }
        }
        stage('Push to ECR') {
            steps {
                sh 'docker push $ECR_REPO:$IMAGE_TAG'
            }
        }
        stage('Deploy to ECS') {
            steps {
                sh """
                    aws ecs update-service \
                        --cluster jenkins-ecs-cluster \
                        --service jenkins-ecs-service \
                        --force-new-deployment \
                        --region $AWS_REGION
                """
            }
        }
    }
}

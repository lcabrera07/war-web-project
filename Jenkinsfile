pipeline {
    agent any
    tools {
        maven 'apache-maven-3.3.9'
        jdk 'jdk8'
    }
    environment {
        registry = 'lcabrera07/bsafe'
        registryCredential = 'dockerhub'
        ec2Slave = '52.87.186.54'
        app = ''
    }
    stages {
        stage("Environment") {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                    echo "WORKSPACE = ${WORKSPACE}"
                    echo "BUILD_DISPLAYNAME = ${BUILD_DISPLAYNAME}"
                    echo "BUILD_NUMBER = ${BUILD_NUMBER}"
                    echo "BUILD_ID = ${BUILD_ID}"
                '''
            }
        }
        stage("Compile") {
            steps {
                sh "mvn install"
            }
        }
        stage("Copy War") {
            steps {
                sh "cp ${WORKSPACE}/target/wwp-1.0.0.war ${WORKSPACE}"
            }
        }
        stage("Build Image") {
            steps {
                script {
                    app = docker.build(registry, "--build-arg warName=wwp-1.0.0.war .")
                }
            }
        }
        stage("Publish") {
            steps {
                script {
                    docker.withRegistry('', registryCredential ) {
                        app.push()
                    }
                }
            }
        }
        stage("Copy Permission File") {
            steps {
                sh "cp /home/luiscabrerangc/awspem.pem ${WORKSPACE}"
                sh "chmod 700 awspem.pem"
                sh "ls -l awspem.pem"
            }
        }
        stage("Deploy to Production") {
            steps {
                script {
                    sh "ssh -i awspem.pem ubuntu@${ec2Slave} sudo apt-get update -y; sudo apt install docker.io -y; sudo snap install docker -y"
                    sh "docker -H ssh://ubuntu@${ec2Slave}:22 run -d -p 8081:8080 ${registry}"
                }
            }
        }
    }
}

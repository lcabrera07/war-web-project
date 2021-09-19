pipeline {
    agent any
    tools {
        maven 'apache-maven-3.3.9'
        jdk 'jdk8'
    }
    environment {
        registry = 'cabrera07/bsafe'
        registryCredential = 'dockerhub'
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
        stage("Copy") {
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
        stage("Deploy") {
            steps {
                script {
                    docker.withRegistry('', registryCredential ) {
                        app.push()
                    }
                }
            }
        }
    }
}

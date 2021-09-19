pipeline {
    agent any
    tools {
        maven 'apache-maven-3.3.9'
        jdk 'jdk8'
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
        def app
        stage("Build Image") {
            app = docker.build("war", "--build-arg warName=wwp-1.0.0.war")
        }
        stage("Deploy") {
            steps {
                sh 'echo "hi"'
            }
        }
    }
}

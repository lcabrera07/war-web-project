pipeline {
    agent any
    tools {
        maven 'apache-maven-3.3.9'
        jdk 'jdk11'
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
        stage("Deploy") {
            steps {
                sh 'echo "hi"'
            }
        }
    }
}

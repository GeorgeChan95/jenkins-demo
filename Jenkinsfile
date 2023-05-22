pipeline {
    agent {
      label 'agent'
    }

    stages {
        stage('检测环境') {
            steps {
                echo '开始检测环境'
                sh '''java -version
                mvn -v
                git version'''
            }
        }
        stage('拉取代码') {
            steps {
                echo '开始拉取代码'
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '3607c53e-5d55-47a9-9193-be178d16244e', url: 'ssh://git@192.168.204.141:222/my-group/jenkins-demo.git']])
            }
        }
        stage('编译构建') {
            steps {
                echo '开始执行代码编译'
                sh 'mvn clean package -Dmaven.test.skip=true'
            }
        }
        stage('项目部署') {
            steps {
                echo '开始执行项目部署'
                sh 'cd target/ && java -jar jenkinsdemo.jar'
            }
        }
    }
}
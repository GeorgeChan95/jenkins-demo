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
                docker -v
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
        stage('删除运行中的容器') {
            steps {
                echo '开始执行删除运行中的容器'
                sh '''echo \'检查容器是否存在\'
                containerid=`docker ps -a | grep -w jenkinsdemo | awk \'{print $1}\'`
                if [ "$containerid" != "" ];then
                    echo \'容器存在，停止容器\'
                    docker stop $containerid
                    echo \'删除容器\'
                    docker rm $containerid
                fi'''
            }
        }
        stage('删除已存在的镜像') {
            steps {
                echo '开始执行删除已存在的镜像'
                sh '''echo \'检查镜像是否存在\'
                imageid=`docker images | grep jenkins | awk \'{print $3}\'`
                if [ "$imageid" != "" ]; then
                        echo \'删除镜像\'
                        docker rmi -f $imageid
                fi'''
            }
        }
        stage('镜像构建') {
            steps {
                echo '开始执行代码打包、镜像构建'
                sh 'mvn dockerfile:build dockerfile:push'
            }
        }
        stage('运行容器') {
            steps {
                echo '开始执行运行容器'
                sh 'docker run -itd --name=jenkinsdemo -p 8080:8080 192.168.204.142:5000/my-harbor/jenkinsdemo:1.0'
            }
        }
    }
}
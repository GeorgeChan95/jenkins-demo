pipeline {
    agent {
      label 'agent-202'
    }

    stages {
        stage('检测环境') {
            steps {
                echo '开始检测环境'
                sh '''java -version
                mvn -v
                docker -v
                docker -v
                git version'''
            }
        }
        stage('拉取代码') {
            steps {
                echo '开始拉取代码'
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'd63fb5a2-7e04-4dd3-8165-f05c1f89004c', url: 'ssh://git@192.168.6.201:222/test/jenkins-demo.git']])
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
                imageid=`docker images | grep jenkinsdemo | awk \'{print $3}\'`
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
                sh 'docker run -itd --name=jenkinsdemo -p 8080:8080 192.168.6.201:5000/ioms/jenkinsdemo:1.0'
            }
        }
    }
}
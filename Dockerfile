FROM openjdk:8-alpine3.9

# 作者信息
MAINTAINER george Docker springboot "george_95@126.com"

# 修改源
RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories \

# 安装需要的软件，解决时区问题
RUN apk --update add curl bash tzdata && \
rm -rf /var/cache/apk/*

#修改镜像为东八区时间
ENV TZ Asia/Shanghai
ARG JAR_FILE

RUN echo "打印jar包名称" && echo ${JAR_FILE} && echo "打印当前路径" && echo $(pwd) && echo "打印子文件夹" && echo $(ls)
COPY ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
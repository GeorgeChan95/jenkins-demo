FROM openjdk:8-alpine3.9

# 作者信息
MAINTAINER george Docker springboot "george_95@126.com"

# 修改源  https://blog.linuxnb.com/index.php/post/127.html
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && apk add --no-cache bash-doc \
    && apk add --no-cache bash-completion \
    && apk add --no-cache wget \
    && apk add --no-cache curl \
    && apk add --no-cache net-tools \
    && apk add --no-cache busybox-extras \
    && apk add --no-cache libc6-compat \
    && apk add --no-cache ca-certificates \
    && echo "hosts: files dns" > /etc/nsswitch.conf \
    && sed -i 's#/bin/ash#/bin/bash#g' /etc/passwd \
    && apk add --no-cache tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

#修改镜像为东八区时间
ENV TZ Asia/Shanghai
ARG JAR_FILE

COPY target/${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
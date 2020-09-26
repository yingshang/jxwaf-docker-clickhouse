FROM centos:7


RUN yum update -y 
RUN yum install -y wget  java
RUN cd /opt && wget https://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.6.0/kafka_2.13-2.6.0.tgz && tar xvf kafka_2.13-2.6.0.tgz 

COPY kafka.sh /opt/kafka.sh

ENTRYPOINT sh /opt/kafka.sh


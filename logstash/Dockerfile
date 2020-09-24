FROM centos:7

RUN yum update -y 
RUN yum install -y java wget 
RUN cd /opt && wget https://artifacts.elastic.co/downloads/logstash/logstash-7.8.1.tar.gz && tar zxvf logstash-7.8.1.tar.gz


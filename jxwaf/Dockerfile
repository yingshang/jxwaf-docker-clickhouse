FROM centos:7

RUN yum update -y && yum install -y git 
RUN cd /tmp && git clone https://github.com/jx-sec/jxwaf.git
RUN cd /tmp/jxwaf &&  sh install_waf.sh
COPY  jxwaf_config.json /opt/jxwaf/nginx/conf/jxwaf/jxwaf_config.json

ENTRYPOINT /opt/jxwaf/nginx/sbin/nginx && tail -f /opt/jxwaf/nginx/logs/access.log


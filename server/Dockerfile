FROM centos:7

ARG username
ARG password
ARG email
RUN yum update -y && yum install -y epel-release
RUN yum install -y python-devel python python-pip git  gcc make mysql mysql-devel  nginx
RUN cd /opt && git clone https://github.com/jx-sec/jxwaf-mini-server.git server
RUN cd /opt/server && pip install -r requirements.txt && pip install uwsgi 
COPY uwsgi2.ini /opt/server/
COPY nginx.conf /etc/nginx/
RUN cd /opt/server && python manage.py makemigrations && python manage.py migrate 
RUN cd /opt/server && echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('$username', '$email', '$password')" | python manage.py shell

#ENTRYPOINT  uwsgi /opt/server/uwsgi2.ini &&  nginx && tail -f /var/log/access.log

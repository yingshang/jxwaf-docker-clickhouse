FROM ubuntu:18.04
RUN apt update -y
RUN  apt install -y apt-transport-https ca-certificates dirmngr
RUN  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4
RUN echo "deb https://repo.clickhouse.tech/deb/stable/ main/" |  tee /etc/apt/sources.list.d/clickhouse.list
RUN  apt update -y
RUN  apt install -y clickhouse-server clickhouse-client
RUN  service clickhouse-server start

# jxwaf-docker
## 启动

```
mv env .env
docker-compose up -d
```


## 配置说明

这个docker-compose主要启动以下的服务。
```
jxwaf
jxwaf控制台
mysql（持久化存储jxwaf控制台信息）
clickhouse（持久化存储jxwaf日志）
kafka（生产和消费日志）
dvwa（攻击靶机）
logstash（转发日志）
```
里面一些IP地址我是写死的，因为jxwaf解析不了docker的hostname，所以干脆直接写死了。反正这个不影响使用。
8000端口是WEB控制台
80，443是jxwaf端口
9000是clickhouse的客户端端口
8123是clickhouse的HTTP端口
3306是mysql端口。

在WEB控制台配置远程端口的时候，需要填上logstash的IP地址（172.20.0.31）。
```
version: '2'
services:
  server:
    build:
      context: server
      dockerfile: Dockerfile
    image: server
    networks:
      extnetwork:
        ipv4_address: 172.20.0.100
    ports:
      - 8000:80
    environment:
      MYSQL_USER:
      MYSQL_PASSWORD:
      SUPER_USER:
      SUPER_PASSWORD:
      SUPER_EMAIL:
      USER_API_KEY:
      USER_NAME:
      USER_PASSWORD:
      USER_API_PASSWORD:

  db:
    image: mysql:5.7
    networks:
      extnetwork:
        ipv4_address: 172.20.0.200
    container_name: db
    volumes:
      - ./data/mysql:/var/lib/mysql
    restart: always
    ports:
      - 3306:3306
    environment:
      MYSQL_ROOT_PASSWORD: 
      MYSQL_DATABASE: jxwaf
      MYSQL_USER: 
      MYSQL_PASSWORD:
    user: root
    privileged: true


  jxwaf:
    build:
      context: jxwaf
      dockerfile: Dockerfile
    image: jxwaf
    ports:
      - 80:80
      - 443:443
    environment:
      USER_API_KEY:
      USER_API_PASSWORD:

    networks:
      extnetwork:
        ipv4_address: 172.20.0.41

  logstash:
    build:
      context: logstash
      dockerfile: Dockerfile
    image: logstash
    networks:
      extnetwork:
        ipv4_address: 172.20.0.31


  clickhouse:
    build:
      context: clickhouse
      dockerfile: Dockerfile
    image: clickhouse
    ports:
      - 9000:9000
      - 8123:8123
    volumes:
      - ./data/clickhouse:/var/lib/clickhouse
    user: root
    privileged: true

    networks:
      extnetwork:
        ipv4_address: 172.20.0.21


  kafka:
    build:
      context: kafka
      dockerfile: Dockerfile
    image: kafka
    networks:
      extnetwork:
        ipv4_address: 172.20.0.11


  dvwa:
    image: citizenstig/dvwa
    networks:
      extnetwork:
        ipv4_address: 172.20.0.220

networks:
  extnetwork:
    ipam:
      driver: bright
      config:
        - subnet: 172.20.0.0/16
          gateway: 172.20.0.1

```

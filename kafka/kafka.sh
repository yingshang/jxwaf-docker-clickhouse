cd /opt/kafka_2.13-2.6.0/bin
./zookeeper-server-start.sh  -daemon  ../config/zookeeper.properties
./kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 3 --topic jxwaf
sleep 10
./kafka-server-start.sh  ../config/server.properties

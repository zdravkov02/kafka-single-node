#!/bin/bash

echo "* Add any prerequisites ..."
apt-get update -y && apt-get install -y python3 python3-pip openjdk-17-jre

echo "* Add kafka-python ..."
pip3 install kafka-python

echo "* Download the recent package ..."
wget https://dlcdn.apache.org/kafka/3.3.1/kafka_2.13-3.3.1.tgz

echo "* Extract the archive and remove it ..."
tar xzvf kafka_2.13-3.3.1.tgz && rm -rf kafka_2.13-3.3.1.tgz && mv kafka_2.13-3.3.1 kafka

echo "* Start the zookeeper ..."
cd kafka && bin/zookeeper-server-start.sh -daemon config/zookeeper.properties

echo "* Start the kafka broker ..."
bin/kafka-server-start.sh -daemon config/server.properties

echo "* Start kafka exporter"
sudo docker run -d --rm -p 9308:9308 danielqsj/kafka-exporter --kafka.server=192.168.98.101:9092

echo "* Sleep 60s"
sleep 60s
echo '* Create the homework topic with 3 partitions and replication factor set to 1'
bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 3 --topic homework

echo '* Start the producer'
python3 /vagrant/shared/test-apps/producer.py &> /tmp/producer.log &

echo '* Start the consumer'
python3 /vagrant/shared/test-apps/consumer-subscribe.py &> /tmp/consumer.log &
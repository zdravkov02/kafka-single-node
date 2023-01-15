#!/bin/bash

echo "* Copy the main config file ..."
mkdir prometheus-config && cp /shared/prometheus.yml prometheus-config/prometheus.yml

echo "* Start the Prometheus container"
docker container run -d --name prometheus -p 9090:9090 --mount type=bind,source=/home/vagrant/prometheus-config/prometheus.yml,destination=/etc/prometheus/prometheus.yml prom/prometheus 

mkdir grafana-config && cp /shared/datasource.yml grafana-config/datasource.yml

echo "* Start the Grafana container"
docker container run -d --name grafana -p 3000:3000 grafana/grafana 

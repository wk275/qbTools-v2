# qbTools-v2 (v2.5.7) 
## Introduction
This repository installs a tooling environment for qbus and mqtt.
Following softwares are installed in docker containers.
- mosquitto (message broker)
- node-red (logic processing & creation of Home assistant entities)
- home-assistant (dashboard)
- influxDBv2 (database on 64bit OS architecture systems)  to store qbus and mqtt statistics
- grafana (charts)
- qbusmqtt (gateway between qbus and mqtt broker

The environment is tested on following systems:
- arm64 - raspberry pi 4B- 4GB memory - 64 bit OS - Debian GNU/Linux 11 (bullseye)
- arm64 - odroid C4 4-GB memory - 64 bit OS - Ubuntu 22.04.3 LTS (jammy)
- amd64 - X64 64 bit OS - Ubuntu 22.04.3 LTS (jammy)

#### Check if your OS is running in 64-bit mode
```
dpkg --print-architecture
```

## System setup
![image](https://github.com/wk275/qbTools-v2/assets/55239601/6e9f2563-7457-4377-afbe-8e602fb8d55c)


## Requirements
- install docker & docker compose
https://docs.docker.com/engine/install/

## qbTools-v2 installation

### Prerequisites
Preferred installation location is your user home directory. If not you'll need to change some commands below!

ssh 'your user'@'your ipaddress'

Install git if not already done 

```
sudo apt-get install git
````

### Install qbTools-v2

```
cd ~/
git clone https://github.com/wk275/qbTools-v2/
tar -xzf ./qbTools-v2/qbTools_2023-09-10_19-07-37-git.tar.gz
```

### Environment configuration

- configure the correct yaml files according to you OS architecure
- setup qbus serial number
- setup port prefix
- setup container suffix 

```
cd ~/qbTools-v2
./setenv.sh
```

### Start qbTools-v2 docker containers
```
cd ~/qbTools-v2
docker compose up -d
docker ps -a
```
I noticed that on some systems there is a dash instead of a space between docker and compose.
Seams that "docker-compose is V1 and "docker compose" is V2.
For more information on how to resolve this see

https://stackoverflow.com/questions/66514436/difference-between-docker-compose-and-docker-compose

If you start qbTools docker containers for the first time all software images will be downloaded and qbusmqtt will be build. 
This can take some time.
Subsequent starts will be a lot quicker.

All container names are suffixed by your container suffix 

Please check if they are stable.
```
docker ps -a
```

### Stop docker containers
```
cd ~/qbTools-v2
docker compose rm --stop --force
docker ps -a
```

### Container links are already configured.
All links between the software containers are already configured.
- nodered-qb is connected to mosquitto-qb and to influxdb-qb
- homeassistant-qb is connected to mosquitto-qb
- grafana-qb is connected to influxdb-qb
- qbusmqtt is configured to use mosquitto 

## Software logins
### mosquitto
install mqtt explorer software
http://mqtt-explorer.com/

start a 'mqtt explorer' session with following parameters

- host: your servers ip addres
- port: x1883
- username: qb-mos
- password: qbmos@10


### nodered
url: http://"your ip address":x1880

### homeassistant
- url: http://"your ip address":x8123
- username: qb-homeassistant
- password: qbhomeassistant@10

### influxdbV2
- url: http://"your ip address":x8086
- username: qb-influx
- password: qbinflux@10

### grafana
- url: http://"your ip address":x3000
- username: qb-grafana
- password: qbgrafana@10

## Cleanup and delete the qbTools environment
```
cd ~/qbTools-v2
docker compose rm --stop --force
docker system prune -a
## this will delete all docker images, networks and volumes. Not only the qbtool-v2 ones!
## Images, networks, etc will be restored after restarting your containers
cd ..
sudo rm -rf ./qbTools-v2
```

## Backup the qbTools-v2 environment
Simply copy the qbTools-v2 directory to a different name.
```
cd ~/
for container in `docker ps -a | awk -F' ' '{ print $NF }'|grep -v NAMES`; do
  docker pause $container
done

cp -pr ~/qbTools-v2 ~/qbTools-v2_backup

for container in `docker ps -a | awk -F' ' '{ print $NF }'|grep -v NAMES`; do
  docker unpause $container
done
```

## Running a 2nd qbTools environment
- stop your containers
- copy the qbTools-v2 directory 
- cd to that new directory
- execute setenv.sh to get a new port prefix and a new container name e.g. serial number: xxxxxx , port prefix: 5, container suffix: -copy
```
cd ~/
for container in `docker ps -a | awk -F' ' '{ print $NF }'|grep -v NAMES`; do
  docker pause $container
done
cp -pr ./qbTools-v2 ./qbTools-V2_copy
for container in `docker ps -a | awk -F' ' '{ print $NF }'|grep -v NAMES`; do
  docker unpause $container
done

cd ./qbTools-V2_copy
./setenv.sh
docker compose up -d
docker ps -a
```

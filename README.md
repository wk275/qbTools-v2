# qbTools-v2 (nodered codebase = 2.3.12) 
!! qbTools-v2 does not support a 32-bit OS anymore.

- Nodered StackHero module does not support InfluxV1 anymore. Removed OS 32-bit configuration and influxdb V1
- Setup nodered theme solarized light
- Setup Home assistant theme solarized light, favicons
- Update Qbus entity states when Home assistant is restarted

## Introduction
This repository installs a tooling environment for qbus and mqtt.
Following softwares are installed in docker containers.
- mosquitto (message broker)
- node-red (logic processing & creation of Home assistant entities)
- home-assistant (dashboard)
- influxDBv2 (database on 64bit OS architecture systems)  to store qbus and mqtt statistics
- grafana (charts)
- openhab (qbusmqtt requirement and dashboard)
- qbusmqtt (gateway between qbus and mqtt broker

The environment is tested on following system:
- raspberry pi 4B- 4GB memory - 64 bit OS - Debian GNU/Linux 11 (bullseye)

#### Check if your OS is running in 64-bit mode
```
dpkg --print-architecture
```

## System setup
![image](https://github.com/wk275/qbTools-v2/assets/55239601/a46bd943-dacf-4aab-bcc4-3537014e213d)


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
tar -xzf ./qbTools-v2/qbTools_2023-08-14_21-45-57-git.tar.gz
```

### Environment configuration

- change qbTools directory and file ownership to your user and group id.
- configure the correct yaml files according to you OS architecure
- setup openhab for your qbus controller

```
cd ~/qbTools-v2
chmod +x setenv.sh
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

All container names are suffixed by "-qb" 

7 docker containers should run. Please check if their status is stable.
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
- openhab is connected to the qbusmqtt and mqtt bridges
- qbusmqtt is configured to use mosquitto 

## Software logins
### mosquitto
install mqtt explorer software
http://mqtt-explorer.com/

start a 'mqtt explorer' session with following parameters

- host: your servers ip addres
- port: 11883
- username: qb-mos
- password: qbmos@10


### nodered
url: http://"your ip address":11880

### homeassistant
- url: http://"your ip address":18123
- username: qb-homeassistant
- password: qbhomeassistant@10

### influxdbV2
- url: http://"your ip address":18086
- username: qb-influx
- password: qbinflux@10

### grafana
- url: http://"your ip address":13000
- username: qb-grafana
- password: qbgrafana@10

### openhab
- url: http://"your ip address":18080
- username: qb-openhab
- password: qbopenhab@10

## Cleanup and delete the qbTools environment

```
cd ~/qbTools-v2
docker compose rm --stop --force
docker system prune -a
## this will delete all docker images, networks and volumes. Not only the qbtool-v2 ones! Images, networks, etc will be restored after restarting your containers
cd ..
sudo rm -rf ./qbTools-v2
```

## Backup the qbTools-v2 environment

Simply copy the qbTools-v2 directory to a different name.

```
sudo cp -pr ~/qbTools-v2 ~/qbTools-v2_backup
```

## Running a 2nd qbTools environment
- stop your containers
- copy the qbTools-v2 directory 
- cd to that new directory and start the new containers

!!!!! it is advised to run only 1 qbTools environment at the same time !!!!!

```
cd ~/qbTools-v2
docker compose rm --stop --force
sudo cp -pr ~/qbTools-v2 ~/qbTools-v2_copy
cd ~/qbTools-v2_copy
docker compose up -d
docker ps -a
```

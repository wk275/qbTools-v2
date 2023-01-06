# qbTools
This repository installs an integrated tooling environment for managing a QBUS or MQTT environment.
It creates docker containers for
- mosquitto (message broker)
- node-red (handles logic)
- home-assistant (dashboard)
- influxDBv1 (database for statistics to be used on sytems with a 32bit OS architecture)
- influxDBv2 (database statistics to be used on sytems with a 64bit OS architecture)
- grafana (charts)

The environment is tested and should work on a the systems below. Although there is no guanrantee :-)
- raspberry pi model 4B - 4GB memory - 64 bit OS
- raspberry pi model 4B - 4GB memory - 32 bit OS
- odroid C4 - 4GB memory - 64 bit OS

#### How to check if your system is running in 32 or 64-bit mode

```
dpkg --print-architecture
```

## System setup
![image](https://user-images.githubusercontent.com/55239601/211047730-63d0f843-c458-417c-804d-be9baaba541f.png)

## Requirements
- install qbusmqtt gateway (minimum installation of qbusmqtt and openhab is required)  
https://github.com/QbusKoen/QbusMqtt-installer

- install docker & docker compose
https://docs.docker.com/engine/install/

## Installation

### Install docker containers
Preferred installation is in your users home directory. If not you'll need to change some commands below!

ssh 'your user'@'your ipaddress'
```
cd ~/
git clone https://github.com/wk275/qbTools/
tar -xzf qbTools_2023-01-06_14-49-29-git.tar.gz
```

### Environment configuration
Change qbTools directory and files ownership to the current user and group.
configure the correct docker-compose.yaml file according to you OS architecure  
```
cd ~/qbTools
chmod +x setenv.sh
./setenv.sh
```

### Start docker containers
```
cd ~/qbTools
docker compose up -d
docker ps -a
```
All containers names are suffixed by "-qb" . 
5 docker containers should run. Please check if their status is stable.

### Stop docker containers
```
cd ~/qbTools
docker compose rm --stop --force
docker ps -a
```

### Container links are already defined
All links between the software containers are already configured.
- nodered-qb is connected to mosquitto-qb and to influxdb-qb
- homeassistant-qb is connected to mosquitto-qb and to influxdb-qb
- grafana-qb is connected to influxdb-qb

### Define external links
2 ways to hook up the qbTools environment to your environment. 
#### 1. Hookup qbusmqtt
Edit & change qbusmqtt service file
```
sudo vi /lib/systemd/system/qbusmqtt.service
```
and modify ExecStart parameters
```
mqttbroker "tcp://localhost:11883" -mqttuser qb-mos -mqttpassword qbmos@10
```
#### 2. Hookup your existing MQTT broker
Edit mosquitto-qb config file to sync QBUS topics with your existing MQTT broker
```
vi ~/qbTools/mosquitto/config/mosquitto.conf
```
Add and modify MQTT bride parameters
```
#bridge connection
log_type all
connection bridge-01
address <remote MQTT ip address and port e.g. 192.168.2.190:1883>
try_private false
cleansession true
remote_username <MQTT remote user name>
remote_password <MQTT remote password>
topic cloudapp/# both 0
```


## Software login
### mosquitto
install mqtt explorer software
http://mqtt-explorer.com/

start a 'mqtt explorer' session with following parameters

host: your servers ip addres
port: 11883
username: qb-mos
password: qbmos@10


### nodered
url: http://"your ip address":11880


### homeassistant
url: http://"your ip address":18123
username: qb-homeassistant
password: homeassistant@10


### influxdb
url: http://"your ip address":18086
username: qb-influx
password: qbinflux@10

### grafana
url: http://"your ip address":13000
username: qb-grafana
password: grafana@10



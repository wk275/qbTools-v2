# qbTools V1
This repository installs an integrated tooling environment on linux for QBUS or MQTT.
It creates docker containers for
- mosquitto (message broker)
- node-red (handles logic)
- home-assistant (dashboard)
- influxDBv1 (database on 32bit OS architecture systems)
- influxDBv2 (database on 64bit OS architecture systems)
- grafana (charts)

The environment is tested and should work on following systems:
- raspberry pi 4B- 4GB memory - 64 bit OS - Debian - Release: 11 - Codename: bullseye
- raspberry pi 4B - 4GB memory - 32 bit OS - Raspbian - Release:  11 - Codename: bullseye
- odroid C4 - 4GB memory - 64 bit OS - Ubuntu - Release: 20.04 - Codename: focal
- AMD 64 bit - Ubuntu - Release: 22.04 - Codename: jammy

#### How to check if your system is running in 32 or 64-bit mode

```
dpkg --print-architecture
```

## System setup
![image](https://user-images.githubusercontent.com/55239601/211190465-80a58146-2370-4d8b-b43c-d3ea5bd02be9.png)

## Requirements
- for QBUS installations, install qbusmqtt gateway (minimum installation of qbusmqtt and openhab is required)  
https://github.com/QbusKoen/QbusMqtt-installer

- install docker & docker compose
https://docs.docker.com/engine/install/

## qbTools installation

### Install docker containers
Preferred installation location is your user home directory. If not you'll need to change some commands below!

ssh 'your user'@'your ipaddress'

Install git if not already done 

```
sudo apt-get install git
````

Install qbTools

```
cd ~/
git clone https://github.com/wk275/qbTools/
tar -xzf ./qbTools/qbTools_2023-08-07_19-48-15-git.tar.gz 
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
I noticed that on some systems there is a dash instead of a space between docker and compose.
Seams that "docker-compose is V1 and "docker compose" is V2.
For more information and how to resolve this see

https://stackoverflow.com/questions/66514436/difference-between-docker-compose-and-docker-compose


If you start qbTools docker containers for the first time all software images will be downloaded. This can take some time.
Subsequent starts will be a lot quicker.

All container names are suffixed by "-qb" 

5 docker containers should run. Please check if their status is stable.
```
docker ps -a
```

### Stop docker containers
```
cd ~/qbTools
docker compose rm --stop --force
docker ps -a
```

### Container links are already activated.
All links between the software containers are already configured.
- nodered-qb is connected to mosquitto-qb and to influxdb-qb
- homeassistant-qb is connected to mosquitto-qb
- grafana-qb is connected to influxdb-qb

### Connect the qbTools environment to QbusMqtt. 
Edit & change qbusmqtt service file
```
sudo vi /lib/systemd/system/qbusmqtt.service
```
and modify ExecStart parameters
```
ExecStart= /usr/bin/qbus/./qbusMqttGw -serial="QBUSMQTTGW" -daemon true -logbuflevel -1 -logtostderr true -storagedir /opt/qbus -mqttbroker "tcp://localhost:11883" -mqttuser qb-mos -mqttpassword qbmos@10
```
Restart mqtt.service
```
sudo systemctl restart qbusmqtt.service
```

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

### influxdbV1 (on 32 bit OS server)
influxdb V1 does not have a webbrowser interface. Use the command line !

ssh 'your user'@'your ipaddress'

```
docker exec -ti influxdbV1-qb influx
```
```
precision rfc3339
use nodered
show measurements
select windgustsKmh,windspeedKmh from buienradar_sensor where time > now()-1h tz('Europe/Brussels');
```
```
quit
```
### influxdbV2 (on 64 bit OS server)
- url: http://"your ip address":18086
- username: qb-influx
- password: qbinflux@10

### grafana
- url: http://"your ip address":13000
- username: qb-grafana
- password: qbgrafana@10


## Cleanup and delete the qbTools environment

```
cd ~/qbTools
docker compose rm --stop --force
docker system prune -a
cd ..
sudo rm -rf ./qbTools
```

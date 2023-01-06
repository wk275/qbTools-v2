# qbTools
This repository installs an integrated tooling environment for managing a QBUS or MQTT environment.
It creates docker containers for
- mosquitto (message broker)
- node-red (handles logic)
- home-assistant (dashboard)
- influxDBv1 (database for statistics to be used on sytems with a 32bit OS architecture)
- influxDBv2 (database statistics to be used on sytems with a 64bit OS architecture)
- grafana (charts)
#### How to check if your system is running in 32 or 64-bit mode

```
dpkg --print-architecture
```

## System setup
![image](https://user-images.githubusercontent.com/55239601/211035633-5a07d739-ddfc-4ff8-983e-b8393c389e99.png)


## Requirements
- install qbusmqtt gateway (minimum installation of qbusmqtt and openhab is required) 
 ``` 
https://github.com/QbusKoen/QbusMqtt-installer
```

- install docker & docker compose
```
https://docs.docker.com/engine/install/
```
## Installation docker containers
### ports
To co-exist with installed software, I added 10.000 to the standard port numbers.
E.g  docker container mosquitto-qb uses port 11883 in stead of 1883

### container links are already defined
All links between the software containers are configured.
- nodered-qb is connected to mosquitto-qb and to influxdb-qb
- homeassistant-qb is connected to mosquitto-qb and to influxdb-qb
- grafana-qb is connected to influxdb-qb

### external links
2 ways to hook up the qbTools environment to your environment. 
#### 1. hookup qbusmqtt 
Edit & change qbusmqtt service file
```
/lib/systemd/system/qbusmqtt.service
```
and modify ExecStart parameter
```
mqttbroker "tcp://localhost:11883" -mqttuser qb-mos -mqttpassword qbmos@10
```

### Install docker containers
ssh user@ipaddress
git clone https://github.com/wk275/qbTools/
```

### Start all docker containers
```
cd ~/qbTools
chmod +x docker_up_all.sh
./docker_up_all.sh
```
### Stop all docker containers
```
cd ~/qbTools
chmod +x docker_rm_all.sh
./docker_rm_all.sh
```

## Software access
### mosquitto
start a windows 'mqtt explorer' session with following parameters
```
- Host: your servers ip addres
- Port: 11883
- Username: qb-mos
- password: qbmos@10
```



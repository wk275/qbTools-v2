# qbTools  !!! under construction DO NOT USE !!!

This repository installs tools for the QBUS environment
It creates docker containers for
- node-red (handles logic)
- home-assistant (dashboard)
- mosquitto (message broker)
- influxDBv2 (database for statistics to be used on 64bit OS systems)
- influxDBv1 (database for statistics to be used on 32bit OS systems)
- grafana (graphics)

![image](https://user-images.githubusercontent.com/55239601/209998587-25c881c1-5b57-41b7-9663-6eb05b8960b1.png)


## Requirements
- install qbusmqtt gateway (I only install openhab and qbusmqtt) 
``` 
https://github.com/QbusKoen/QbusMqtt-installer
```

- install docker & docker compose
```
https://docs.docker.com/engine/install/
```
### Create docker containers
`ssh <your user>@<your server address>`

```
cd
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

### docker container ports
To co-exist with already installed software, I added 10.000 to the standard port numbers.
E.g  the login for mosquitto-qbus uses port 11883 in stead of 1883

### software connections
To configure all softwares out of the box a generic ip address is needed.
In case you do not run a dns service, you have to edit the /etc/hosts file
and add a line with

'your servers ip address' local.lan

### mosquitto
#### login
start a windows 'mqtt explorer' session with following parameters
```
- Host: your servers ip addres
- Port: 11883
- Username: qb-mos
- password: qbmos@10
```



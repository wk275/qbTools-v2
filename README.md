# qbTools  !!! under construction DO NOT USE !!!

This repository installs tools for the QBUS environment
It creates docker containers for
- mosquitto (message broker)
- node-red (handles logic)
- home-assistant (dashboard)
- influxDBv1 (database for statistics to be used on sytems with a 32bit OS architecture)
- influxDBv2 (database statistics to be used on sytems with a 64bit OS architecture)
- grafana (graphics)

![image](https://user-images.githubusercontent.com/55239601/209998587-25c881c1-5b57-41b7-9663-6eb05b8960b1.png)


## Requirements
- install qbusmqtt gateway
 ``` 
https://github.com/QbusKoen/QbusMqtt-installer
```
The options I use are
```
2. existing mosquitto server
mqtt address local.lan
mqtt port 11883
yes openhab install
no nodered install
no samba install
mqtt user = qb-mos
mqtt passwd = qbmos@10
yes 64Bit install (if your OS has a 64bit architecture otherwise no
yes delete openhab temp files
```

- install docker & docker compose
```
https://docs.docker.com/engine/install/
```
## Installation docker containers
### ports
To co-exist with already installed software, I added 10.000 to the standard port numbers.
E.g  docker container mosquitto-qbus uses port 11883 in stead of 1883

### software connections
To configure all softwares out of the box I used a generic ip address 'local.lan'.
In case you do not run a dns service, you have to edit the /etc/hosts file
and add a line with

your servers ip addresss local.lan
E.g. 192.168.2.100 local.lan

### Install docker containers
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

## Software access
### mosquitto
start a windows 'mqtt explorer' session with following parameters
```
- Host: your servers ip addres
- Port: 11883
- Username: qb-mos
- password: qbmos@10
```



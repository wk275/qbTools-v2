# This repository is to be used on a 64 bit OS
The influxDBV2 is compiled for a 64 bit architecture and will not work in a 32-bit OS

To check is yout os is 64 bit
```
dpkg-architecture| grep HOST_ARCH_BITS
```

# qbTools  !!! under construction DO NOT USE !!!

This repository installs tools for the QBUS environment
It creates docker containers for
- node-red (handles logic)
- home-assistant (dashboard)
- mosquitto (message broker)
- influxDB (database for statistics)
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

### Start all docker qbus containers
```
cd ~/qbTools
chmod +x docker_up_all.sh
./docker_up_all.sh
```
### Stop all docker qbus containers
```
cd ~/qbTools
chmod +x docker_rm_all.sh
./docker_rm_all.sh
```

### login node-red
`http://<your server address>:11880`


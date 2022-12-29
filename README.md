# qbTools

This repository installs tools for the QBUS environment

It creates docker containers for
- node-red (handles logic)
- home-assistant (dashboard)
- mosquitto (message broker)
- influxDB (database for statistics)
- grafana (graphics)

![image](https://user-images.githubusercontent.com/55239601/209998587-25c881c1-5b57-41b7-9663-6eb05b8960b1.png)


## Prerequisites
- install qbusmqtt gateway
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
### login node-red
`http://<your server address>:1880`


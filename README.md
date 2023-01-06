# qbTools
This repository installs an integrated tooling environment for managing a QBUS or MQTT environment.
It creates docker containers for
- mosquitto (message broker)
- node-red (handles logic)
- home-assistant (dashboard)
- influxDBv1 (database for statistics to be used on sytems with a 32bit OS architecture)
- influxDBv2 (database statistics to be used on sytems with a 64bit OS architecture)
- grafana (charts)

![image](https://user-images.githubusercontent.com/55239601/211035633-5a07d739-ddfc-4ff8-983e-b8393c389e99.png)


## Requirements
- install qbusmqtt gateway
 ``` 
https://github.com/QbusKoen/QbusMqtt-installer

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
#### In case you do not run a dns service
##### edit /etc/hosts and add a line with
your servers ip addresss followed by local.lan
E.g. 192.168.2.100 local.lan

##### check if local.lan can be accessed
```
sudo apt-get install dnsutils
nslookup local.lan
```
The return shoud read your servers ip address.
If message ‘** server can't find local.lan: NXDOMAIN’ then you need to install dnsmasq which will dns publish your /etc/hosts entries and will also act as a local dns cache server
```
sudo get-apt install dnsmasq
sudo reboot
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



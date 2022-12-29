# qbus---nodered---homeassistant
Creates homeassistant entities for qbus via node-red subflows

## Prerequisites
- install qbusmqtt gateway
``` 
https://github.com/QbusKoen/QbusMqtt-installer
```

- install docker & docker compose

```
https://docs.docker.com/engine/install/
```
### Create node-red docker container
`ssh <your user>@<your address>`

```
mkdir -p ~/docker/node-red-qbus
cd ~/docker/node-red-qbus
cat >> docker-compose.yaml << EOF
version: "3.7"

services:
  node-red:
    image: nodered/node-red:latest
    environment:
      - TZ=Europe/Brussels
    container_name: node-red
    restart: unless-stopped
    user: "1000"
    ports:
      - "1880:1880"
    volumes:
      - "./data:/data"
      - "/var/run/docker.sock:/var/run/docker.sock"
      - "/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket"
    networks:
      - iot
    logging:
      options:
        max-size: 5m
        max-file: "3"
networks:
  iot:
    name: IOT_Net
    driver: bridge

EOF
docker compose up -d
docker ps -a
```
### login node-red
`http://<your address>:1880`

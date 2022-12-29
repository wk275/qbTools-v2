#!/bin/bash
#set -x
for item in `docker ps -a |awk 'NF>1{print $NF}'|grep qbus`
do
        echo "-------------------------------------"
        cd ~/qbTools/docker/$item
        docker compose rm --stop --force
done

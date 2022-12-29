#!/bin/bash
for item in `ls ~/qbTools/docker|grep qbus`
do
        echo "-------------------------------------"
        cd ~/qbTools/docker/$item
        docker compose up -d
done

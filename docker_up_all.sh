#!/bin/bash
for item in `ls ~/qbTools/docker`
do
        echo "-------------------------------------"
        cd ~/qbTools/docker/$item
        docker compose up -d
done

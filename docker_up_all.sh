#!/bin/bash
for item in `ls ~/qbTools|grep "qbus"`
do
        echo "-------------------------------------"
        cd ~/qbTools/$item
        docker compose up -d
done

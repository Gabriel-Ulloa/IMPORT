#!/bin/bash

WEEK="/home/import/Deployment/week"
DAYS=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

rm -rf /home/import/Deployment/sensor_catches/*

for DAY in "${DAYS[@]}"; do
    PATH_TO="$WEEK/$DAY"

    if [ -d "$PATH_TO" ]; then
        echo "Deleting $PATH_TO..."
        rm -rf "$PATH_TO"/*
    else
        echo "$PATH_TO not found, skipping..."
    fi
done



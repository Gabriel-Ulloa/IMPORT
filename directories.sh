#!/bin/bash
#
mkdir /home/import/sensor_catches
mkdir /home/import/combinator
mkdir /home/import/export/

week(){

    semana="week"

    dias=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

    mkdir "/home/import/$semana"

    for dia in "${dias[@]}"; do
        mkdir -p "/home/import/$semana/$dia"
    done

}

week
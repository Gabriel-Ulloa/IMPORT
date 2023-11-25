#!/bin/bash
#
catches="/home/import/Deployment/sensor_catches"
combinator="/home/import/Deployment/combinator"
export="/home/import/Deployment/export"

AIPS="All_IPs.txt"
AHASHES="All_hashes.txt"

clean(){
    cd .. && rm -rf IMPORTER/
}

if [ ! -d "/home/import/SecurityOnion/" ]; then
    echo "This script only works on SecurityOnion."
    clean
    exit 1
fi

# Check if the Deployment folder exists
if [ -d "/home/import/Deployment/" ]; then
    echo "This script has already been executed previously."
    clean
    exit 1
fi

    # Check if the rcron file exists
if [ ! -f "/home/import/rcron" ]; then
    echo "The file /home/import/rcron does not exist."
    echo "Make sure you have performed the correct deployment."
    echo "Exiting the script."
    clean
    exit 1
fi

mkdir -p "$catches" "$combinator" "$export"
touch "$combinator/$AIPS" "$combinator/$AHASHES"


week(){

    semana="week"

    dias=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

    mkdir "/home/import/Deployment/$semana"

    for dia in "${dias[@]}"; do
        mkdir -p "/home/import/Deployment/$semana/$dia"
    done

}

week

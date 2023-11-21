#!/bin/bash
#
myWHOAMI=$(whoami)
if [ "$myWHOAMI" != "root" ]
  then
    sudo ./$0
    exit
fi

week(){
semana="week"

dias=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

mkdir "/home/import/$semana"

for dia in "${dias[@]}"; do
    mkdir -p "/home/import/$semana/$dia"
done

}

main(){
  mkdir /home/import/sensor_catches
  week
  #cat /usr/local/bin/rcron | tee -a /etc/crontab
}

main

mv "dionaea" "cowrie" "adbhoney" "variables" "decompressor" /usr/local/bin/

yum install -y tcpdump wireshark sqlite
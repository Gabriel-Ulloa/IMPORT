#!/bin/bash
#
mkdir /home/import/sensor_catches

week(){
  
semana="week"

dias=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

mkdir "/home/import/$semana"

for dia in "${dias[@]}"; do
    mkdir -p "/home/import/$semana/$dia"
done

}

week

myWHOAMI=$(whoami)
  if [ "$myWHOAMI" != "root" ]
    then
      sudo ./$0
      exit
  fi

mv "dionaea" "cowrie" "adbhoney" "decompressor" /usr/local/bin/
cat /home/import/rcron | tee -a /etc/crontab
echo "Done!"
sleep 2
clear
exit
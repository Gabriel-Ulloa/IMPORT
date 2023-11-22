#!/bin/bash
#
root(){
  myWHOAMI=$(whoami)
  if [ "$myWHOAMI" != "root" ]
    then
      sudo ./$0
      exit
  fi
}
week(){
semana="week"

dias=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

mkdir "/home/import/$semana"

for dia in "${dias[@]}"; do
    mkdir -p "/home/import/$semana/$dia"
done

}

main(){
  echo "Making directories.."
  mkdir /home/import/sensor_catches
  week
  root
  mv "dionaea" "cowrie" "adbhoney" "variables" "decompressor" /usr/local/bin/
  cat /home/import/rcron | tee -a /etc/crontab
}

main



#yum install -y tcpdump wireshark sqlite
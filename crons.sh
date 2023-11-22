#!/bin/bash
#
myWHOAMI=$(whoami)
  if [ "$myWHOAMI" != "root" ]
    then
      sudo ./$0
      exit
  fi
echo "Settings crons..."
mv "dionaea" "cowrie" "adbhoney" "decompressor" /usr/local/bin/
cat /home/import/rcron | tee -a /etc/crontab
echo "Done!"
sleep 2
#clear
exit
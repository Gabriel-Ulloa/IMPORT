#!/bin/bash
#
if [ "$(whoami)" != "root" ]; then
    echo "Este script debe ejecutarse con permisos de root."
    exit 1
fi

echo "Settings crons..."
mv "dionaea" "cowrie" "adbhoney" "decompressor" /usr/local/bin/
cat /home/import/rcron | tee -a /etc/crontab
echo "Done!"
sleep 2
#clear
exit
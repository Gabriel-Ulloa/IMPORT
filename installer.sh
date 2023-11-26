#!/bin/bash
#
# Check if the script is executed as root
if [ "$(whoami)" != "root" ]; then
    echo "This script must be executed with root permissions."
    exit 1
fi

mv "dionaea.sh" "cowrie.sh" "adbhoney.sh" "decompressor.sh" "vt" /usr/local/bin/
mv VxAPI/ /home/import/Deployment/
cat /home/import/.rcron | tee -a /etc/crontab
rm -rf /home/import/.rcron



#. ./rclone.sh

#myAPI
#main_rc

#rm -rf /home/import/IMPORTER

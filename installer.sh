#!/bin/bash
#
# Check if the script is executed as root
if [ "$(whoami)" != "root" ]; then
    echo "This script must be executed with root permissions."
    exit 1
fi


. ./settings.sh
. ./api.sh
. ./rclone.sh

myAPI
settings
#main_rc

#rm -rf /home/import/IMPORTER

#!/bin/bash
#
# Check if the script is executed as root
if [ "$(whoami)" != "root" ]; then
    echo "This script must be executed with root permissions."
    exit 1
fi


settings(){

    deploy="/home/import/Deployment/"
    scripts=("dionaea.sh" "cowrie.sh" "adbhoney.sh" "decompressor.sh" "vt")
    bin="/usr/local/bin/"
    rcron="/home/import/.rcron"
    vX="VxAPI/"
    cront="/etc/crontab"

    mv "$scripts" "$bin"
    mv "$vX" "$deploy"
    cat "$rcron" | tee -a "$cront"
    rm -rf "$rcron"
}


#cd /home/import/IMPORTER
settings



. ./rclone.sh

#myAPI
#main_rc

#rm -rf /home/import/IMPORTER

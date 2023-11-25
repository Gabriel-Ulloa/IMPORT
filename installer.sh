#!/bin/bash
#
# Check if the script is executed as root
if [ "$(whoami)" != "root" ]; then
    echo "This script must be executed with root permissions."
    exit 1
fi

. ./settings.sh

settings


wget https://github.com/VirusTotal/vt-cli/releases/download/0.14.0/Linux64.zip &&unzip Linux64.zip && rm Linux64.zip
sudo mv





settings
main_rc

rm -rf /home/import/IMPORTER

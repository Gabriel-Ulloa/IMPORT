#!/bin/bash
#
# Check if the script is executed as root
if [ "$(whoami)" != "root" ]; then
    echo "This script must be executed with root permissions."
    exit 1
fi

. ./rclone.sh

settings(){
    
    yum install zip -y
    mv "dionaea.sh" "cowrie.sh" "adbhoney.sh" "decompressor.sh" "vt-cli.sh" "filter.sh" "vt" "upload.sh" /usr/local/bin/
    mv VxAPI/ /home/import/Deployment/
    mv "config.py" "VxAPI.sh" /home/import/Deployment/VxAPI/ 
    cat /home/import/.rcron | tee -a /etc/crontab
    rm -rf /home/import/.rcron

}

hybrid_API(){
    
    FILE_CONFIG="/home/import/Deployment/VxAPI/config.py"
    
    sleep 1
    clear
    echo "::::Hybrid Analysis Configuration::::"
    read -p "API Key: " api_key
    read -p "API Secret: " api_secret

    # Reemplazar 'aqui' por los valores ingresados en el archivo config.py
    sed -i "s/'api_key': 'here'/'api_key': '$api_key'/" $FILE_CONFIG
    sed -i "s/'api_secret': 'here'/'api_secret': '$api_secret'/" $FILE_CONFIG

    echo "VxAPI Update"

}

virus_API(){
    
    clear
    /usr/local/bin/vt init

}

main(){

    settings
    hybrid_API
    virus_API
    main_rc

}

main

#rm -rf /home/import/IMPORTER

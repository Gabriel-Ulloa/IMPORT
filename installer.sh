#!/bin/bash
#
# Check if the script is executed as root
if [ "$(whoami)" != "root" ]; then
    echo "This script must be executed with root permissions."
    exit 1
fi

. ./rclone.sh

settings(){

    mv "dionaea.sh" "cowrie.sh" "adbhoney.sh" "decompressor.sh" "vt" "upload.sh" /usr/local/bin/
    mv VxAPI/ /home/import/Deployment/
    mv "config.py" /home/import/Deployment/VxAPI/ 
    cat /home/import/.rcron | tee -a /etc/crontab
    rm -rf /home/import/.rcron

}


hybrid_API(){
    
    FILE_CONFIG="/home/import/Deployment/VxAPI/config.py"

    # Pedir al usuario que ingrese la api_key y la api_secret
    echo "::::Hybrid Analysis Configuration::::"
    read -p "API Key: " api_key
    read -p "API Secret: " api_secret

    # Reemplazar 'aqui' por los valores ingresados en el archivo config.py
    sed -i "s/'api_key': 'here'/'api_key': '$api_key'/" $FILE_CONFIG
    sed -i "s/'api_secret': 'here'/'api_secret': '$api_secret'/" $FILE_CONFIG

    echo "VxAPI Update"

}

virus_API(){

    vt_toml="/root/.vt.toml"

    function vt_init(){
        /usr/local/bin/vt init
    }
    #
    while true
        do
            if [ -f "$vt_toml" ]; then
            echo "OK"; sleep 2
            break         
            else
            echo "Enter a valid API key"; sleep 2; clear; vt_init
            fi
        done

}


main(){

    settings
    hybrid_API
    virus_API
    main_rc

}

main

#rm -rf /home/import/IMPORTER

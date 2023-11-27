#!/bin/bash
#
rcinstall(){

    sudo -v ; curl https://rclone.org/install.sh | sudo bash
    clear
    banner_text="Configuring Cloud"

    echo "**********************************************"
    echo "*                                            *"
    echo "*          $banner_text                 *"
    echo "*                                            *"
    echo "**********************************************"

    rclone config

}

namex(){
    
    rconf="/root/.config/rclone/rclone.conf"
    rcname="/usr/local/bin/rcname"

    grep '^\[' "$rconf" | sed 's/[][]//g' > "$rcname"
}

rconf(){
    
    clear
    banner_text="Cloud Folder for Saving Captures"

    echo "**********************************************"
    echo "*                                            *"
    echo "*     $banner_text       *"
    echo "*                                            *"
    echo "**********************************************"
        
    read -p "New folder name: " dir_name

    rcname="$(cat /usr/local/bin/rcname)"

    rclone mkdir "${rcname}:${dir_name}"

    echo "${dir_name}" > /usr/local/bin/dircloud

}
    
main_rc(){
    
    rcinstall
    namex
    rconf
    echo "Done!"

}


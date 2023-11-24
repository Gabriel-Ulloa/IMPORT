#!/bin/bash
#
rcinstall(){

    sudo -v ; curl https://rclone.org/install.sh | sudo bash
    rclone config

}

namex(){
    
    rconf="/root/.config/rclone/rclone.conf"
    rcname="/usr/local/bin/rcname"

    grep '^\[' "$rconf" | sed 's/[][]//g' > "$rcname"
}

rconf(){
    
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

upload(){
    
    compressed="/home/import/export/"
    rcname="$(cat /usr/local/bin/rcname)"
    dircloud="$(cat /usr/local/bin/dircloud)"

    rclone copy "$compressed" "${rcname}:${dircloud}"

}
    
main(){
    
    rcinstall
    namex
    rconf
    upload
    echo "Done!"

}

main
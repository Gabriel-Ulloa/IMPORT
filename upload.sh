#!/bin/bash
#
upload(){
    
    compressed="/home/import/Deployment/export/"
    rcname="$(cat /usr/local/bin/rcname)"
    dircloud="$(cat /usr/local/bin/dircloud)"
    echo "uploading..."
    rclone copy "$compressed" "${rcname}:${dircloud}"

}

upload
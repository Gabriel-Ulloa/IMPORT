#!/bin/bash
#
upload(){
    
    compressed="/home/import/export/"
    rcname="$(cat /usr/local/bin/rcname)"
    dircloud="$(cat /usr/local/bin/dircloud)"

    rclone copy "$compressed" "${rcname}:${dircloud}"

}

upload
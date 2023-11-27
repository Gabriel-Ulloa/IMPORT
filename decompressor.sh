#!/bin/bash
. ./dionaea.sh
. ./cowrie.sh
. ./adbhoney.sh
. ./filter.sh
. ./vt-cli.sh
. ./upload.sh


decompressing(){

    AIPS="All_IPs.txt"
    AHASHES="All_hashes.txt"

    catches="/home/import/Deployment/sensor_catches/$(date +%A)_catches.tar.gz"
    day="/home/import/Deployment/week/$(date +%A)/"
    combinator="/home/import/Deployment/combinator"

    echo "decompressing catches..."
    tar -xzf "$catches" -C "$day"
    sleep 3
    touch "$combinator/$AIPS" "$combinator/$AHASHES"

}

uniq_data(){

    AIPS="All_IPs.txt"
    AHASHES="All_hashes.txt"
    combinator="/home/import/Deployment/combinator"
    CAPTURE="/home/import/Deployment/CAPTURE/"
    U_HASH="uniq_hashes.txt"
    U_IP="uniq_IPs.txt"
    O_PCAP="/home/import/Deployment/week/$(date +%A)/CATCHES/$(date +%A).pcap"
    N_PCAP="/home/import/Deployment/CAPTURE/capture.pcap"

    cat $combinator/$AHASHES |sort |uniq > $CAPTURE/$U_HASH
    cat $combinator/$AIPS |sort |uniq > $CAPTURE/$U_IP

    cp $O_PCAP $N_PCAP

}

function h_analysis(){

    su - import  -c /home/import/Deployment/VxAPI/VxAPI.sh

}

function zipper(){

    binaries="/home/import/Deployment/combinator/ALL_BINARIES"
    protected="/home/import/Deployment/CAPTURE/binaries.zip"
    pass="infected"

    zip -r -P "$pass" "$protected" "$binaries"

}

main(){

    #date_folder
    decompressing
    dionaea 
    cowrie 
    adbhoney
    uniq_data
    filter_IP
    virus_total
    h_analysis
    zipper

    #upload
    echo "OK"
    sleep 5
    

}

main

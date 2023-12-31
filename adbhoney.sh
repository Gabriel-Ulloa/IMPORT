#!/bin/bash

function adbhoney(){
    
    ADB_LOG="/home/import/Deployment/week/$(date +%A)/CATCHES/adbhoney/log/adbhoney.log"
    PCAP="/home/import/Deployment/week/$(date +%A)/CATCHES/$(date +%A).pcap"
    HASHES="hashes_adbhoney.txt"
    IPS_FOUND="IPs.txt"
    temp="/home/import/Deployment/week/$(date +%A)/CATCHES/adbhoney/FILTER"
    h_temp=$(mktemp)
    ip_temp=$(mktemp)
    ALL_IPs="$temp/All_IPs_adbhoney.txt"
    combinator="/home/import/Deployment/combinator"
    DOWNLOADS="/home/import/Deployment/week/$(date +%A)/CATCHES/adbhoney/downloads/*"
    MALWARE="/home/import/Deployment/combinator/ALL_BINARIES"
    LOGS="/home/import/Deployment/CAPTURE/ALL_LOGS"
    AIPS="All_IPs.txt"
    AHASHES="All_hashes.txt"

    mkdir -p "$temp"
    grep -i ".file_download" "$ADB_LOG" |grep -oe "[shasum]\+.[:_ ]\+.[0-z]\+" |cut -c 11-74 | sort | uniq > "$temp/$HASHES"
    cat "$temp/$HASHES" >> "$combinator/$AHASHES"
    cp $ADB_LOG $LOGS
    cp $DOWNLOADS $MALWARE

    filtro(){

        IP_FILE="$temp/$(cat $h_temp)/$IPS_FOUND"
        #OUTPUT_PCAP="$temp/$hash/filtered.pcap"
        
        FILTER=""
        while IFS= read -r IP; do
            if [ -z "$FILTER" ]; then
                FILTER="host $IP"
            else
                FILTER="$FILTER or host $IP"
            fi
        done < "$IP_FILE"

        #tcpdump -r "$PCAP" -w "$OUTPUT_PCAP" "$FILTER"

    }

     unifyig(){
        cat "$ip_temp" |sort |uniq > "$ALL_IPs"
        cat "$ALL_IPs" >> "$combinator/$AIPS" 
    }

    if [ ! -f "$temp/$HASHES" ]; then
    echo "Hash file does not exist."
    exit 1
    fi

    while IFS= read -r hash; do
        
        if [ -d "$temp/$hash" ]; then
            echo "$hash folder already exists."
        else
            mkdir -p "$temp/$hash"
            cd "$temp/$hash"
            echo "$hash" > "$h_temp"
            grep -i ".session.connect" $ADB_LOG |grep -oE '\b[0-9]{1,3}(\.[0-9]{1,3}){3}\b' |grep -v "172.18.0.2" |cut -d "'" -f 3 | sort | uniq > "$IPS_FOUND"
            cat "$IPS_FOUND" >> "$ip_temp"
            filtro
            echo "$hash folder created."
        fi

    done < "$temp/$HASHES"

    unifyig

}

adbhoney

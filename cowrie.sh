#!/bin/bash

function cowrie(){
    
    COWRIE_JSON="/home/import/Deployment/week/$(date +%A)/CATCHES/cowrie/log/cowrie.json"
    FILE_DOWNLOAD=".file_download"
    SHA_REGEX="[shasum]\+.[:]\+.[0-z]\+"
    IP_REGEX="[:-z]\+.[:]\+.[0-9]\+.[.]\+.[0-9]\+.[0-9]\+.[0-9]\+"
    HIP_REGEX="[0-9]\+.[0-9]\+.[0-9]\+.[0-9]\+"
    TIME_REGEX="[a-z]\+.[:]\+.[0-9]\+.[-]\+.[0-9]\+.[0-Z]\+"
    temp="/home/import/Deployment/week/$(date +%A)/CATCHES/cowrie/FILTER"
    HASHES="hashes_cowrie.txt"
    file_hashes="$temp/$HASHES"
    h_temp=$(mktemp)
    ip_temp=$(mktemp)
    IPS_FOUND="IPs.txt"
    ALL_IPs="$temp/All_IPs_cowrie.txt"
    PCAP="/home/import/Deployment/week/$(date +%A)/CATCHES/$(date +%A).pcap"
    combinator="/home/import/Deployment/combinator"
    DOWNLOADS="/home/import/Deployment/week/$(date +%A)/CATCHES/cowrie/downloads/*"
    MALWARE="/home/import/Deployment/CAPTURE/ALL_BINARIES/"
    LOGS="/home/import/Deployment/CAPTURE/ALL_LOGS"
    AIPS="All_IPs.txt"
    AHASHES="All_hashes.txt"

    
    mkdir -p "$temp"
    grep -i "$FILE_DOWNLOAD" "$COWRIE_JSON" |grep -oe $SHA_REGEX |cut -c 10-74 |sort | uniq > "$temp/$HASHES"
    cat "$temp/$HASHES" >> "$combinator/$AHASHES"
    cp $COWRIE_JSON $LOGS
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

    if [ ! -f "$file_hashes" ]; then
    echo "El archivo de hashes no existe."
    exit 1
    fi

    while IFS= read -r hash; do
        
        if [ -d "$temp/$hash" ]; then
            echo "La carpeta $hash ya existe."
        else
            mkdir -p "$temp/$hash"
            cd "$temp/$hash"
            echo "$hash" > "$h_temp"
            grep "$hash" "$COWRIE_JSON" |grep -oe $IP_REGEX |grep -oe $HIP_REGEX |sort | uniq > "$IPS_FOUND"
            cat "$IPS_FOUND" >> "$ip_temp"
            filtro
            echo "Carpeta $hash creada."
        fi

    done < "$file_hashes"

    unifyig

}

cowrie

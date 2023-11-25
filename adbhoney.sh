#!/bin/bash

function adbhoney(){
    
    ADB_LOG="/home/import/week/$(date +%A)/CATCHES/adbhoney/log/adbhoney.log"
    PCAP="/home/import/week/$(date +%A)/CATCHES/$(date +%A).pcap"
    HASHES="hashes_adbhoney.txt"
    IPS_FOUND="IPs.txt"
    temp="/home/import/week/$(date +%A)/CATCHES/adbhoney/FILTER"
    h_temp=$(mktemp)
    ip_temp=$(mktemp)
    ALL_IPs="$temp/All_IPs_adbhoney.txt"
    combinator="/home/import/combinator"
    AIPS="All_IPs.txt"
    AHASHES="All_hashes.txt"

    mkdir -p "$temp"
    grep -i ".file_download" "$ADB_LOG" |grep -oe "[shasum]\+.[:_ ]\+.[0-z]\+" |cut -c 11-74 | sort | uniq > "$temp/$HASHES"
    cat "$temp/$HASHES" >> "$combinator/$AHASHES"

    filtro(){

        IP_FILE="$temp/$(cat $h_temp)/$IPS_FOUND"
        OUTPUT_PCAP="$temp/$hash/filtered.pcap"
        
        FILTER=""
        while IFS= read -r IP; do
            if [ -z "$FILTER" ]; then
                FILTER="host $IP"
            else
                FILTER="$FILTER or host $IP"
            fi
        done < "$IP_FILE"

        tcpdump -r "$PCAP" -w "$OUTPUT_PCAP" "$FILTER"

    }

     unifyig(){
        cat "$ip_temp" |sort |uniq > "$ALL_IPs"
        cat "$ALL_IPs" >> "$combinator/$AIPS" 
    }

    if [ ! -f "$temp/$HASHES" ]; then
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
            grep -i ".session.connect" $ADB_LOG |grep -oe "[src_ip]\+.[:_ ]\+.[0-9]\+.[.]\+.[0-9]\+.[0-9]\+.[0-9]\+" |grep -v "172.18.0.2" |cut -d "'" -f 3 | sort | uniq > "$IPS_FOUND"
            cat "$IPS_FOUND" >> "$ip_temp"
            filtro
            echo "Carpeta $hash creada."
        fi

    done < "$temp/$HASHES"

    unifyig

}


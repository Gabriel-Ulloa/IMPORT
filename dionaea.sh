#!/bin/bash
#
function dionaea(){
    #
    DIONAEA_JSON="/home/import/Deployment/week/$(date +%A)/CATCHES/dionaea/log/dionaea.json"
    DIONAEA_SQLITE="/home/import/Deployment/week/$(date +%A)/CATCHES/dionaea/log/dionaea.sqlite"
    DOWNLOADS="downloads.csv"
    CONNECTIONS="connections.csv"
    BINARIES="/home/import/Deployment/week/$(date +%A)/CATCHES/dionaea/binaries/*"
    temp="/home/import/Deployment/week/$(date +%A)/CATCHES/dionaea/FILTER"
    PCAP="/home/import/Deployment/week/$(date +%A)/CATCHES/$(date +%A).pcap"
    HASHES="hashes_dionaea.txt"
    file_hashes="$temp/$HASHES"
    CONNECTION_LOCAL="connection.txt"
    IPS_FOUND="IPs.txt"
    h_temp=$(mktemp)
    ip_temp=$(mktemp)
    ALL_IPs="$temp/All_IPs_dionaea.txt"
    combinator="/home/import/Deployment/combinator"
    MALWARE="/home/import/Deployment/combinator/ALL_BINARIES"
    LOGS="/home/import/Deployment/CAPTURE/ALL_LOGS"
    AIPS="All_IPs.txt"
    AHASHES="All_hashes.txt"


    address_finder(){
        
        while read -r next_line; do
            next_line=$((next_line + 1))
            awk -v next_line="$next_line" 'NR == next_line' $temp/$CONNECTIONS |cut -d',' -f10 
        done < $CONNECTION_LOCAL |sort |uniq >$IPS_FOUND

    }

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
        cat $IP_FILE |sort | uniq >> $ip_temp

    }

    unifyig(){
        cat $ip_temp |sort |uniq > $ALL_IPs
        cat $ALL_IPs >> "$combinator/$AIPS"
    }

    main(){

    mkdir -p $temp
    sqlite3 -header -csv $DIONAEA_SQLITE "SELECT * FROM downloads" > $temp/$DOWNLOADS
    sqlite3 -header -csv $DIONAEA_SQLITE "SELECT * FROM connections" > $temp/$CONNECTIONS
    cut -d ',' -f 4 $temp/$DOWNLOADS |sed '1d' |sort | uniq > $temp/$HASHES
    cat $temp/$HASHES >> $combinator/$AHASHES
    cp $DIONAEA_JSON $DIONAEA_SQLITE $LOGS
    cp $BINARIES $MALWARE


    if [ ! -f "$file_hashes" ]; then
    echo "El archivo de hashes no existe."
    exit 1
    fi

    while IFS= read -r hash; do
        
        if [ -d "$temp/$hash" ]; then
            echo "La carpeta $hash ya existe."
        else
            mkdir -p "$temp/$hash"
            cd $temp/$hash
            echo "$hash" >$h_temp
            grep $hash $temp/$DOWNLOADS |cut -d ',' -f 2 > $CONNECTION_LOCAL
            address_finder
            filtro
            echo "Carpeta $hash creada."
        fi

    done < "$file_hashes"

    unifyig

    }
    
main
  

}

dionaea


#!/bin/bash
#
function virus_total(){
    file="/home/import/Deployment/CAPTURE/uniq_hashes.txt"
    VT_HASHES="/home/import/Deployment/CAPTURE/VT_HASHES"

    counter=0
    while IFS= read -r hash; do
        echo "Consulting..." && /usr/local/bin/vt file $hash > $VT_HASHES/VT_$(echo $hash).yaml && sleep .5
        counter=$((counter + 1))
        
        if ((counter % 200 == 0)); then
            echo "Waiting 1 minute..."
            sleep 60
        fi
    done < "$file"
}

virus_total
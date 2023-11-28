#!/bin/bash
#
function virus_total(){
    file="/home/import/Deployment/CAPTURE/uniq_hashes.txt"
    VT_HASHES="/home/import/Deployment/CAPTURE/VT_HASHES"

    counter=0
    while IFS= read -r hash; do
        echo "consultando..." && /usr/local/bin/vt file $hash > $VT_HASHES/VT_$(echo $hash).yaml && sleep .5
        counter=$((counter + 1))
        #Verificar si se han revisado doscientas líneas
        if ((counter % 200 == 0)); then
            echo "Esperando 1 minuto..."
            sleep 60
        fi
    done < "$file"
}

virus_total
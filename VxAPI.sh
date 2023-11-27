function hybrid_analysis(){
    file="/home/import/Deployment/CAPTURE/uniq_hashes.txt"
    VX_HASHES="/home/import/Deployment/CAPTURE/VX_HASHES"
    vxapi="/home/import/Deployment/VxAPI/vxapi.py"

    counter=0
    while IFS= read -r hash; do
        echo "consultando..." && python $vxapi search_hash $hash > $VX_HASHES/VX_$(echo $hash).yaml && sleep .5
        counter=$((counter + 1))
        #Verificar si se han revisado doscientas líneas
        if ((counter % 200 == 0)); then
            echo "Esperando 1 minuto..."
            sleep 60
        fi
    done < "$file"
}

#python vxapi.py search_hash

#UNIQ_HASHES.txt
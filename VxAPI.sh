function hybrid_analysis(){
    file="/home/import/Deployment/CAPTURE/uniq_hashes.txt"
    VX_HASHES="/home/import/Deployment/CAPTURE/VX_HASHES"
    vxapi="/home/import/Deployment/VxAPI/vxapi.py"

    counter=0
    while IFS= read -r hash; do
        echo "Consulting..." && python $vxapi search_hash $hash > $VX_HASHES/VX_$(echo $hash).yaml && sleep .5
        counter=$((counter + 1))
        
        if ((counter % 200 == 0)); then
            echo "Waiting 1 minute..."
            sleep 60
        fi
    done < "$file"
}

hybrid_analysis
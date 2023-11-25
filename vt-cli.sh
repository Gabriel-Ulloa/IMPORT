
wget https://github.com/VirusTotal/vt-cli/releases/download/0.14.0/Linux64.zip &&unzip Linux64.zip && rm Linux64.zip

/root/.vt.toml  



function virus_total(){
    file="hashes.txt" 
    counter=0
    while IFS= read -r hash; do
        echo "consultando..." && /home/tsec/SCRIPT/vt file $hash > virustotal/$(echo $hash)_"$(date +"%Y-%m-%d_%H:%M:%S")".yaml && sleep .5
        counter=$((counter + 1))
        #Verificar si se han revisado doscientas líneas
        if ((counter % 200 == 0)); then
            echo "Esperando 1 minuto..."
            sleep 60
        fi
    done < "$file"
}
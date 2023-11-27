#!/bin/bash
filter_IP(){

    IPS_FILE="/home/import/Deployment/CAPTURE/uniq_IPs.txt"
    N_PCAP="/home/import/Deployment/CAPTURE/capture.pcap"
    FILTERED="/home/import/Deployment/CAPTURE/FILTERED_PCAPS/"
    

    # Verifica si los archivos existen
    if [ ! -f "$IPS_FILE" ] || [ ! -f "$N_PCAP" ]; then
        echo "The IP file or the original .pcap file does not exist."
        exit 1
    fi

    # Leer cada IP del archivo y filtrar el tráfico correspondiente
    while IFS= read -r ip; do
        echo "Filtering traffic for the IP: $ip"
        tcpdump -r "$N_PCAP" "ip host $ip" -w "$FILTERED/${ip}.pcap"
    done < "$IPS_FILE"

    echo "Filtering completed"

}

#!/bin/bash

# Ruta al archivo con la lista de IPs
ARCHIVO_IPS="/ruta/al/archivo/ips.txt"

# Ruta al archivo pcap original
ARCHIVO_PCAP_ORIGINAL="/ruta/al/archivo/original.pcap"

# Verifica si los archivos existen
if [ ! -f "$ARCHIVO_IPS" ] || [ ! -f "$ARCHIVO_PCAP_ORIGINAL" ]; then
    echo "El archivo de IPs o el archivo .pcap original no existen."
    exit 1
fi

# Leer cada IP del archivo y filtrar el tráfico correspondiente
while IFS= read -r ip; do
    echo "Filtrando tráfico para la IP: $ip"
    tcpdump -r "$ARCHIVO_PCAP_ORIGINAL" "ip host $ip" -w "${ip}.pcap"
done < "$ARCHIVO_IPS"

echo "Filtrado completado."

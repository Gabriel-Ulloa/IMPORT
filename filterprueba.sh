#!/bin/bash

# Ruta al archivo con las IPs
IP_FILE="IPs.txt"

# Ruta al archivo pcap original
PCAP_FILE="Friday.pcap"

# Ruta al archivo pcap filtrado
OUTPUT_PCAP="filtered.pcap"

# Construir la expresión para tcpdump
FILTER=""
while IFS= read -r IP; do
    if [ -z "$FILTER" ]; then
        FILTER="host $IP"
    else
        FILTER="$FILTER or host $IP"
    fi
done < "$IP_FILE"

# Filtrar el archivo pcap original usando tcpdump y guardar el resultado en un nuevo archivo
tcpdump -r "$PCAP_FILE" -w "$OUTPUT_PCAP" "$FILTER"

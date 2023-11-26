#!/bin/bash

# Define la ruta base y los días de la semana
RUTA_BASE="/home/import/Deployment/week"
DIAS=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

# Bucle para recorrer cada día de la semana
for DIA in "${DIAS[@]}"; do
    RUTA_CARPETA="$RUTA_BASE/$DIA"

    # Verifica si la carpeta existe
    if [ -d "$RUTA_CARPETA" ]; then
        echo "Borrando contenido de $RUTA_CARPETA..."
        rm -rf "$RUTA_CARPETA"/*
    else
        echo "La carpeta $RUTA_CARPETA no existe, saltando..."
    fi
done

echo "Proceso completado."
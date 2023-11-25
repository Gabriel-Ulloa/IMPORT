#!/bin/bash
#
# Ejecutar directories.sh y almacenar el código de salida
bash directories.sh
exit_status=$?

# Verificar si directories.sh se ejecutó con éxito
if [ $exit_status -eq 0 ]; then
    echo "directories.sh executed successfully, proceeding with installer.sh."
    sudo bash installer.sh
else
    echo "directories.sh failed to execute, exiting."
    exit $exit_status
fi
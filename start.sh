#!/bin/bash
#
bash directories.sh
exit_status=$?

if [ $exit_status -eq 0 ]; then
    echo "directories.sh executed successfully."
    sudo bash installer.sh
else
    echo "directories.sh failed to execute, exiting."
    exit $exit_status
fi
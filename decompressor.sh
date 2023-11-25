#!/bin/bash
. ./dionaea.sh
. ./cowrie.sh
. ./adbhoney.sh
. ./upload.sh


echo "decompressing catches..."
tar -xzf /home/import/sensor_catches/$(date +%A)_catches.tar.gz -C /home/import/week/$(date +%A)/
sleep 10


main(){

    dionaea 
    cowrie 
    adbhoney
    #upload
    echo "OK"
    sleep 5
    

}

main

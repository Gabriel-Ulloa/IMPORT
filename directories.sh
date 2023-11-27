#!/bin/bash
#
clean(){
    cd .. && rm -rf IMPORTER/
}

if [ ! -d "/home/import/SecurityOnion/" ]; then
    echo "------>This script only works on SecurityOnion<-------"
    clean
    exit 1
fi

# Check if the Deployment folder exists
if [ -d "/home/import/Deployment/" ]; then
    echo "------>This script has already been executed previously<------"
    clean
    exit 1
fi

    # Check if the rcron file exists
if [ ! -f "/home/import/.rcron" ]; then
    echo "The file rcron does not exist."
    echo "------>Make sure you have performed the correct deployment<------"
    echo "Exiting the script."
    clean
    exit 1
fi

my_folders(){

    mkdir -p "/home/import/Deployment/CAPTURE/FILTERED_PCAPS" \
             "/home/import/Deployment/CAPTURE/ALL_BINARIES" \
             "/home/import/Deployment/CAPTURE/VT_HASHES" \
             "/home/import/Deployment/CAPTURE/VX_HASHES" \
             "/home/import/Deployment/CAPTURE/ALL_LOGS" \
             "/home/import/Deployment/sensor_catches" \
             "/home/import/Deployment/combinator" \
             "/home/import/Deployment/export"

}

week(){

    semana="week"

    dias=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

    mkdir "/home/import/Deployment/$semana"

    for dia in "${dias[@]}"; do
        mkdir -p "/home/import/Deployment/$semana/$dia"
    done

}

myAPI(){

    myVT="https://github.com/VirusTotal/vt-cli/releases/download/0.14.0/Linux64.zip"
    myVx="https://github.com/PayloadSecurity/VxAPI.git"
    pip_py="https://bootstrap.pypa.io/get-pip.py"
    
    wget "$myVT" && unzip Linux64.zip 
    git clone "$myVx"
    curl $pip_py -o "get-pip.py"
    python3 get-pip.py
    pip3 install colorama

}

main(){

    my_folders
    week
    myAPI

}

main


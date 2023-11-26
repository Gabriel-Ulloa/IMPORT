#!/bin/bash
#
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


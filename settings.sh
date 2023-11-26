settings(){

    deploy="/home/import/Deployment/"
    scripts=""dionaea.sh" "cowrie.sh" "adbhoney.sh" "decompressor.sh" "vt""
    bin="/usr/local/bin/"
    rcron="/home/import/rcron"
    vX="VxAPI/"
    cront="/etc/crontab"

    mv "$scripts" "$bin"
    mv "$vX" "$deploy"
    cat "$rcron" | tee -a "$cront"
    rm -rf "$rcron"
}

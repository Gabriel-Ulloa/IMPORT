settings(){

    echo "Setting up crons..."
    mv "dionaea.sh" "cowrie.sh" "adbhoney.sh" "decompressor.sh" /usr/local/bin/
    cat /home/import/rcron | tee -a /etc/crontab
    rm -rf /home/import/rcron
}
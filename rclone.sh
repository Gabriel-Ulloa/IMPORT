#Sincronizando Nube
echo "Instalando rclone"
sudo -v ; curl https://rclone.org/install.sh | sudo bash
toilet -f ivrit "rclone"
rclone config
#
#
#https://cloudsecuritylab.dev/remote.php/dav/files/lab/

rclone copy /home/tsec/CHECKS nextcloud:PCAPS && sleep 60 
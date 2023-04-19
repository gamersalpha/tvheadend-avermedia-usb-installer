$#!/bin/bash

# Vérification du système d'exploitation
OS=$(lsb_release -d | awk '{print $2 " " $3}')
if [ "$OS" != "Ubuntu 22.04" ] && [ "$OS" != "Ubuntu 22.04.1" ] && [ "$OS" != "Ubuntu 22.04.2" ]; then
  echo "Ce script est conçu pour être exécuté uniquement sur Ubuntu 22.04. Il n'a pas été testé sur d'autres systèmes d'exploitation."
  exit 1
fi

# Vérification des prérequis
if [[ $EUID -ne 0 ]]; then
  echo "Ce script doit être exécuté avec les privilèges root."
  exit 1
fi

if ! command -v unzip &> /dev/null; then
  echo "Le paquet 'unzip' doit être installé. Veuillez l'installer en exécutant 'sudo apt-get install unzip'."
  exit 1
fi

# Installation du pilote pour la clé USB Avermedia
echo "Téléchargement du pilote pour la clé USB Avermedia..."
wget http://www.ite.com.tw/uploads/firmware/v3.6.0.0/dvb-usb-it9135.zip

echo "Décompression du fichier du pilote..."
unzip dvb-usb-it9135.zip
rm dvb-usb-it9135.zip

echo "Installation du pilote pour la clé USB Avermedia..."
dd if=dvb-usb-it9135.fw ibs=1 skip=64 count=8128 of=dvb-usb-it9135-01.fw
dd if=dvb-usb-it9135.fw ibs=1 skip=12866 count=5817 of=dvb-usb-it9135-02.fw
rm dvb-usb-it9135.fw
sudo mv dvb-usb-it9135* /lib/firmware/

echo "Pilote pour la clé USB Avermedia installé avec succès."

# Installation de TVHeadend
echo "Téléchargement et installation de TVHeadend..."
curl -1sLf 'https://dl.cloudsmith.io/public/tvheadend/tvheadend/setup.deb.sh' | sudo -E bash
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tvheadend

echo "TVHeadend installé avec succès."

# Configuration de TVHeadend
echo "Configuration de TVHeadend..."
sudo systemctl stop tvheadend
sudo rm -f /home/hts/.hts/tvheadend/passwd
echo "admin_tvheadend:$(openssl passwd -crypt password)" | sudo tee -a /home/hts/.hts/tvheadend/passwd >/dev/null
sudo systemctl start tvheadend

# Indications finales
IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "Vous pouvez accéder à TVHeadend en ouvrant votre navigateur web et en visitant : https://$IP_ADDRESS:9981"
echo "Identifiant : admin"




#!/bin/bash

# Vérification si l'utilisateur est root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté avec des privilèges root."
    exit 1
fi

# Installation de Docker
echo "Installation de Docker..."

apt update
apt install apt-transport-https ca-certificates curl software-properties-common -y

# Ajout de la clé GPG de Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajout du dépôt Docker
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mise à jour des dépôts et installation de Docker
apt update
apt install docker-ce docker-ce-cli containerd.io -y

# Installation de Docker Compose
echo "Installation de Docker Compose..."
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Attribution des permissions d'exécution
chmod +x /usr/local/bin/docker-compose

# Vérification de l'installation de Docker Compose
docker-compose --version

echo "Installation terminée avec succès !"

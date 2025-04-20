FROM almalinux:9

# Installer Ansible et sshpass
RUN dnf update -y && \
    dnf install -y python3-pip sudo openssh-clients sshpass && \
    pip3 install ansible

# Créer un dossier temporaire pour Ansible
RUN mkdir -p /tmp/.ansible/tmp && chmod 777 /tmp/.ansible/tmp

# Dossier de travail
WORKDIR /ansible

# Commande par défaut : ne rien faire (ce sera docker-compose qui donnera la commande ansible)
CMD [ "sleep", "infinity" ]

FROM almalinux:9

# Installer les dépendances
RUN dnf update -y && \
    dnf install -y python3-pip sudo

# Installer Ansible
RUN pip3 install ansible

# Créer un répertoire pour les configurations d'Ansible
WORKDIR /ansible

# Lancer Ansible en mode interactif
CMD [ "ansible", "--version" ]

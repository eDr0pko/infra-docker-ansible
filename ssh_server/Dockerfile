FROM debian:12

# Installer SSH serveur
RUN apt-get update && apt-get install -y openssh-server sudo

# Créer un utilisateur non-root
RUN useradd -m -s /bin/bash user
# Définir le mot de passe de l'utilisateur "user"
RUN echo "user:user" | chpasswd
# Ajouter l'utilisateur au groupe sudo
RUN adduser user sudo

RUN mkdir /var/run/sshd
EXPOSE 22

#Dossier temporaire pour Ansible
RUN mkdir -p /tmp/.ansible/tmp && chmod 777 /tmp/.ansible/tmp


# Démarrer SSHD
CMD ["/usr/sbin/sshd", "-D"]

FROM debian:12

# Installer SSH serveur + sudo + python3
RUN apt-get update && apt-get install -y openssh-server sudo python3

# Créer un utilisateur non-root
RUN useradd -m -s /bin/bash user
RUN echo "user:user" | chpasswd
RUN adduser user sudo

RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir /var/run/sshd
EXPOSE 22

# Dossier temporaire pour Ansible
RUN mkdir -p /tmp/.ansible/tmp && chmod 777 /tmp/.ansible/tmp

# Démarrer SSHD
CMD ["/usr/sbin/sshd", "-D"]

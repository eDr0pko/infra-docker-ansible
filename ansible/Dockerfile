FROM almalinux:9

# Installer Ansible
RUN dnf update -y && \
    dnf install -y ansible && \
    dnf clean all

# Définir le répertoire de travail
WORKDIR /ansible

CMD ["ansible", "--version"]
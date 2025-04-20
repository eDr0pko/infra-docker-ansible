# infra-docker-ansible

> **Projet d'infrastructure avec Docker, SSH Server et Ansible Controller.**

Ce projet crée deux conteneurs Docker :
- Un serveur SSH basé sur Debian 12.
- Un contrôleur Ansible basé sur AlmaLinux 9 pour automatiser des tâches sur le serveur SSH.

Ils sont connectés sur un réseau privé Docker (reseau_ssh).

---

## 📂 Structure du projet

```
infra-docker-ansible/
├── ansible/
│   ├── Dockerfile
│   ├── inventory.ini
│   └── ansible.cfg
├── ssh_server/
│   └── Dockerfile
│── docker-compose.yml
└── install_docker.sh
```

- `ssh_server/Dockerfile` : configure un serveur SSH sous Debian 12.
- `ansible/Dockerfile` : installe Ansible sur AlmaLinux 9.
- `ansible/inventory.ini` : fichier d'inventaire Ansible pour le serveur cible.
- `ansible/ansible.cfg` : configuration d'Ansible.
- `docker-compose.yml` : orchestre l'infrastructure.
- `install_docker.sh` : installe Docker et docker-compose.

---

## 🚀 Lancer le projet

1. **Cloner le repository**

```bash
git clone https://github.com/eDr0pko/infra-docker-ansible.git
cd infra-docker-ansible
```

2. **Build et start les conteneurs**

```bash
docker-compose up --build -d
```

3. **Vérification des conteneurs**

```bash
docker ps
```

4. **Vérification de la communication Ansible vers SSH Server**

Consulter les logs du conteneur Ansible :

```bash
docker logs ansible_controller
```

Le résultat attendu est :

```
ssh-server | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

---

## ⚙️ Détails techniques

- **SSH Server**
  - Image : `debian:12`
  - Installation :
    - OpenSSH Server
    - sudo
    - python3
  - Utilisateur `user` / mot de passe `user`
  - Port SSH exposé sur `localhost:2222`

- **Ansible Controller**
  - Image : `almalinux:9`
  - Installation :
    - Ansible via pip
    - sshpass pour la gestion du mot de passe SSH
  - Exécute automatiquement un ping Ansible vers `ssh-server`.

- **Docker Compose**
  - Réseau privé `reseau_ssh` pour la communication entre conteneurs.
  - Dépendances configurées (`depends_on`).

---

## 🛠️ Commandes utiles

- **Redémarrer l'infrastructure proprement**

```bash
docker-compose down
docker-compose up --build -d
```

- **Accéder à un conteneur en bash**

```bash
docker exec -it ssh_server bash
docker exec -it ansible_controller bash
```

- **Afficher les logs**

```bash
docker logs ansible_controller
```

---
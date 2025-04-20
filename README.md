# infra-docker-ansible

> **Projet d'infrastructure avec Docker, SSH Server, Ansible Controller et Nginx.**

Ce projet crée deux conteneurs Docker :
- Un serveur SSH basé sur Debian 12.
- Un contrôleur Ansible basé sur AlmaLinux 9 pour automatiser des tâches sur le serveur SSH, notamment le déploiement de Nginx.

Ils sont connectés sur un réseau privé Docker (reseau_ssh).

---

## 📂 Structure du projet

```
infra-docker-ansible/
├── ansible/
│   ├── roles/
│   │   └── nginx/
│   │       ├── handlers/
│   │       │   └── main.yml
│   │       └── tasks/
│   │           └── main.yml
│   ├── Dockerfile
│   ├── inventory.ini
│   ├── playbook.yml
│   └── ansible.cfg
├── ssh_server/
│   └── Dockerfile
├── docker-compose.yml
└── install_docker.sh

```

- `ssh_server/Dockerfile` : Configure un serveur SSH sous Debian 12.
- `ansible/Dockerfile` : Installe Ansible sur AlmaLinux 9.
- `ansible/roles/` : Gère les rôles Ansible, ici un seul rôle `nginx` pour installer et configurer Nginx.
  - `ansible/roles/nginx/handlers/main.yml` : Définit les gestionnaires de tâches Ansible pour redémarrer Nginx si nécessaire.
  - `ansible/roles/nginx/tasks/main.yml` : Liste des tâches pour installer et configurer Nginx sur le serveur cible.
- `ansible/inventory.ini` : Fichier d'inventaire Ansible pour spécifier les hôtes et groupes cibles (ici, le serveur SSH).
- `ansible/ansible.cfg` : Fichier de configuration d'Ansible, incluant les paramètres de connexion et les options de vérification des clés SSH.
- `docker-compose.yml` : Orchestration des conteneurs Docker pour le serveur SSH et le contrôleur Ansible, incluant les configurations réseau et les ports.
- `install_docker.sh` : Script pour installer Docker et Docker Compose sur la machine hôte.


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

- **Nginx (via Ansible)**
  - Installation :
    - Rôle Ansible pour installer Nginx sur le serveur SSH.
    - Le rôle configure et démarre le service Nginx.
    - Le service est ensuite activé pour démarrer automatiquement au démarrage du conteneur.
  - Configuration :
    - Fichier de configuration par défaut `/etc/nginx/nginx.conf`.
    - Port HTTP exposé sur `localhost:8080` (par défaut).
  - Vérification de l'installation via `curl` pour tester la réponse HTTP.

- **Docker Compose**
  - Réseau privé `reseau_ssh` pour la communication entre conteneurs.
  - Dépendances configurées (`depends_on`).


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

## 🧪 Environnement de test

Toutes les étapes et configurations ont été testées dans un environnement virtuel sous VMware avec une machine virtuelle Debian 12.

## 📂 Lien GitHub

Vous pouvez retrouver le code source de ce projet sur [GitHub](https://github.com/eDr0pko/infra-docker-ansible).

# Projekt: Kompleksowe rozwiązanie serwer-klient w środowisku Linux

## Opis

Projekt akademicki przedstawiający kompletne rozwiązanie infrastruktury IT opartej na systemach Linux przy użyciu Vagrant i Ansible.

## Wymagania

- VirtualBox
- Vagrant
- Ansible
- 200 GB wolnego miejsca na dysku

## Struktura projektu

```
sys-ops-vagrant-ansible/
├── Vagrantfile              # Definicja maszyn wirtualnych
├── ansible/                 # Konfiguracja Ansible
│   ├── inventory.yml        # Inwentarz hostów
│   ├── site.yml            # Główny playbook
│   └── roles/              # Role Ansible
├── deploy.sh               # Skrypt wdrożeniowy
├── verify.sh              # Skrypt weryfikacyjny
└── cleanup.sh             # Skrypt czyszczący
```

## Instalacja

### 1. Przygotowanie środowiska

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install virtualbox vagrant ansible git

# Windows (z Chocolatey)
choco install virtualbox vagrant git
```

### 2. Klonowanie projektu

```bash
git clone <repo-url>
cd sys-ops-vagrant-ansible
```

### 3. Wdrożenie

```bash
./deploy.sh
```

## Komponenty systemu

### Serwery

- **srv-main** (192.168.56.10) - Serwer główny

  - FreeIPA - zarządzanie tożsamością
  - DHCP Server
  - Samba - udostępnianie plików
  - Apache + PHP
  - GitLab CE
  - OpenVPN

- **srv-backup** (192.168.56.11) - Serwer backupu
  - Bacula Director
  - Bacula Storage
  - MySQL

### Klienci

- **client1** (192.168.56.101) - Ubuntu Desktop
- **client2** (192.168.56.102) - Ubuntu Desktop

## Dane dostępowe

### FreeIPA

- URL: https://192.168.56.10
- Login: admin
- Hasło: AdminPassword123!

### GitLab

- URL: http://192.168.56.10:8080
- Login: root
- Hasło: (ustaw przy pierwszym logowaniu)

### Użytkownicy testowi

- user1 / User1Pass123!
- user2 / User2Pass123!

## Zarządzanie

### SSH do maszyn

```bash
vagrant ssh srv-main
vagrant ssh srv-backup
vagrant ssh client1
vagrant ssh client2
```

### Restart usług

```bash
cd ansible
ansible-playbook site.yml --tags restart
```

### Weryfikacja

```bash
./verify.sh
```

### Czyszczenie środowiska

```bash
./cleanup.sh
```

## Rozwiązywanie problemów

TODO

### Problem z Ansible

```bash
ansible all -m ping -i ansible/inventory.yml
```

## Autor

Przemysław Gilewski

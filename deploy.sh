#!/bin/bash
# Skrypt wdrożeniowy środowiska Linux Server-Client

set -e

echo "=== Wdrażanie środowiska Linux Server-Client ==="

# Sprawdzenie wymagań
command -v vagrant >/dev/null 2>&1 || { echo "Vagrant nie jest zainstalowany!"; exit 1; }
command -v ansible >/dev/null 2>&1 || { echo "Ansible nie jest zainstalowany!"; exit 1; }
command -v vboxmanage >/dev/null 2>&1 || { echo "VirtualBox nie jest zainstalowany!"; exit 1; }

# Uruchomienie maszyn wirtualnych
echo "1. Uruchamianie maszyn wirtualnych..."
vagrant up --no-provision

# Czekanie na uruchomienie
echo "2. Oczekiwanie na uruchomienie maszyn..."
sleep 30

# Testowanie połączenia
echo "3. Testowanie połączenia z maszynami..."
cd ansible
ansible all -m ping -i inventory.yml

# Uruchomienie playbook
echo "4. Konfiguracja środowiska..."
ansible-playbook site.yml -i inventory.yml

echo "=== Wdrożenie zakończone pomyślnie! ==="
echo ""
echo "Dane dostępowe:"
echo "FreeIPA: https://192.168.56.10"
echo "  Login: admin"
echo "  Hasło: AdminPassword123!"
echo ""
echo "GitLab: http://192.168.56.10:8080"
echo "  Login: root"
echo "  Hasło: (ustaw przy pierwszym logowaniu)"
echo ""
echo "SSH do serwerów:"
echo "  vagrant ssh srv-main"
echo "  vagrant ssh srv-backup"
echo "  vagrant ssh client1"
echo "  vagrant ssh client2"

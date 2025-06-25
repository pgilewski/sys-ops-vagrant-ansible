#!/bin/bash

echo "🚀 Uruchamianie projektu Vagrant + Ansible..."

# Sprawdzenie czy VirtualBox i Vagrant są zainstalowane
if ! command -v vagrant &> /dev/null; then
    echo "❌ Vagrant nie jest zainstalowany. Zainstaluj go poprzez: brew install --cask vagrant"
    exit 1
fi

if ! command -v VBoxManage &> /dev/null; then
    echo "❌ VirtualBox nie jest zainstalowany. Zainstaluj go poprzez: brew install --cask virtualbox"
    exit 1
fi

if ! command -v ansible &> /dev/null; then
    echo "❌ Ansible nie jest zainstalowany. Zainstaluj go poprzez: brew install ansible"
    exit 1
fi

echo "✅ Wszystkie wymagane narzędzia są zainstalowane"

# Czyszczenie poprzednich VM jeśli istnieją
echo "🧹 Czyszczenie poprzednich VM..."
vagrant destroy -f 2>/dev/null || true

# Uruchomienie VM po kolei z lepszą kontrolą błędów
echo "🏗️  Uruchamianie VM srv-main..."
vagrant up srv-main --provider virtualbox

if [ $? -ne 0 ]; then
    echo "❌ Błąd podczas uruchamiania srv-main"
    exit 1
fi

echo "🏗️  Uruchamianie VM srv-backup..."
vagrant up srv-backup --provider virtualbox

if [ $? -ne 0 ]; then
    echo "❌ Błąd podczas uruchamiania srv-backup"
    exit 1
fi

echo "🏗️  Uruchamianie VM client1..."
vagrant up client1 --provider virtualbox

if [ $? -ne 0 ]; then
    echo "❌ Błąd podczas uruchamiania client1"
    exit 1
fi

echo "🏗️  Uruchamianie VM client2 (z provisioningiem Ansible)..."
vagrant up client2 --provider virtualbox

if [ $? -ne 0 ]; then
    echo "❌ Błąd podczas uruchamiania client2 lub provisioningu Ansible"
    echo "🔧 Próba ponownego uruchomienia provisioningu..."
    vagrant provision
fi

echo "✅ Projekt został uruchomiony!"
echo "📋 Status VM:"
vagrant status

echo ""
echo "🔗 Dostępne usługi:"
echo "   - FreeIPA: https://192.168.56.10"
echo "   - GitLab: http://192.168.56.10:8080"
echo "   - Apache: http://192.168.56.10"
echo "   - srv-main: ssh vagrant@192.168.56.10"
echo "   - srv-backup: ssh vagrant@192.168.56.11"
echo "   - client1: ssh vagrant@192.168.56.101"
echo "   - client2: ssh vagrant@192.168.56.102"

echo ""
echo "⏰ GitLab może potrzebować 2-3 minut aby się w pełni uruchomić."
echo "   Jeśli widzisz '502 error', poczekaj chwilę - strona automatycznie się odświeży." 
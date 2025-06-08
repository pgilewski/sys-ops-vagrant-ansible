#!/bin/bash
# Skrypt czyszczący środowisko

echo "=== Czyszczenie środowiska ==="

read -p "Czy na pewno chcesz usunąć wszystkie maszyny wirtualne? (t/n): " -n 1 -r
echo

if [[ $REPLY =~ ^[Tt]$ ]]; then
    echo "Zatrzymywanie maszyn..."
    vagrant halt -f
    
    echo "Usuwanie maszyn..."
    vagrant destroy -f
    
    echo "Czyszczenie cache..."
    rm -rf .vagrant/
    
    echo "=== Środowisko wyczyszczone ==="
else
    echo "Anulowano."
fi

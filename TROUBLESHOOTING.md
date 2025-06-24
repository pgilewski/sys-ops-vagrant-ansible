# Troubleshooting Guide

## Problemy i rozwiązania

### 1. Błąd "Vagrant gathered an unknown Ansible version"

**Rozwiązanie:** Dodano `ansible.compatibility_mode = "2.0"` w Vagrantfile.

### 2. SSH Connection Timeouts

**Przyczyna:** VM nie są w pełni uruchomione przed provisioningiem
**Rozwiązanie:**

- Dodano `wait_for_connection` w playbook
- Provisioning uruchamiany tylko po ostatnim VM
- Używaj skryptu `./fix_and_deploy.sh` dla lepszej kontroli

### 3. "No package matching 'freeipa-server' is available"

**Przyczyna:** Ubuntu 22.04 nie ma FreeIPA w domyślnych repozytoriach
**Rozwiązanie:** Dodano repozytorium FreeIPA PPA

### 4. Ogólne problemy z VM

```bash
# Restart całego środowiska
vagrant destroy -f
vagrant up

# Tylko provisioning
vagrant provision

# Sprawdzenie statusu
vagrant status

# SSH do konkretnego VM
vagrant ssh srv-main
```

### 5. Problemy z VirtualBox na macOS

```bash
# Sprawdzenie czy VirtualBox działa
VBoxManage list vms

# Restart VirtualBox service
sudo /Library/Application\ Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh restart
```

### 6. Problemy z siecią

```bash
# Sprawdzenie interfejsów sieciowych na hoście
ifconfig | grep vboxnet

# Reset sieci VirtualBox
VBoxManage hostonlyif remove vboxnet0
```

## Użyteczne komendy

```bash
# Uruchomienie tylko jednego VM
vagrant up srv-main

# Restart konkretnego VM
vagrant reload srv-main

# Sprawdzenie logów
vagrant ssh srv-main -c "sudo journalctl -f"

# Test połączenia Ansible
ansible all -m ping -i ansible/inventory.yml
```

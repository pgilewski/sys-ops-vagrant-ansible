# 🚀 Instrukcja uruchomienia projektu

## Wymagania (macOS)

```bash
# Instalacja narzędzi
brew install --cask virtualbox
brew install --cask vagrant
brew install ansible
```

## Szybkie uruchomienie

```bash
# Uruchomienie całego projektu
./deploy.sh
```

## Ręczne uruchomienie

```bash
# 1. Uruchomienie VM
vagrant up

# 2. Jeśli provisioning Ansible nie uruchomił się automatycznie
vagrant provision
```

## 🔗 Dostępne usługi

Po uruchomieniu dostępne będą:

- **GitLab**: http://192.168.56.10:8080
- **Apache**: http://192.168.56.10
- **SSH do serwerów**:
  - srv-main: `ssh vagrant@192.168.56.10`
  - srv-backup: `ssh vagrant@192.168.56.11`
  - client1: `ssh vagrant@192.168.56.101`
  - client2: `ssh vagrant@192.168.56.102`

## ⏰ Czas uruchomienia

- **VM**: ~5-10 minut
- **GitLab**: dodatkowe 2-3 minuty po provisioning

Jeśli GitLab pokazuje "502 error", poczekaj - strona automatycznie się odświeży gdy będzie gotowa.

## 🛠️ Troubleshooting

Jeśli wystąpią problemy, sprawdź `TROUBLESHOOTING.md`

```bash
# Restart całego środowiska
vagrant destroy -f
./fix_and_deploy.sh

# Sprawdzenie statusu
vagrant status

# Logi GitLab
vagrant ssh srv-main -c "sudo gitlab-ctl status"
```

## 📋 Architektura

- **srv-main**: FreeIPA, DHCP, Samba, Apache, GitLab, OpenVPN
- **srv-backup**: Bacula (backup)
- **client1, client2**: Klienci testowi

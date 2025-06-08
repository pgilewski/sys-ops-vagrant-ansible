#!/bin/bash
# Skrypt weryfikacyjny środowiska

echo "=== Weryfikacja środowiska ==="

# Test FreeIPA
echo -n "FreeIPA: "
curl -k https://192.168.56.10 &>/dev/null && echo "OK" || echo "BŁĄD"

# Test DHCP
echo -n "DHCP: "
vagrant ssh srv-main -c "sudo systemctl is-active isc-dhcp-server" 2>/dev/null

# Test Samba
echo -n "Samba: "
smbclient -L //192.168.56.10 -N &>/dev/null && echo "OK" || echo "BŁĄD"

# Test Apache
echo -n "Apache: "
curl http://192.168.56.10 &>/dev/null && echo "OK" || echo "BŁĄD"

# Test GitLab
echo -n "GitLab: "
curl http://192.168.56.10:8080 &>/dev/null && echo "OK" || echo "BŁĄD"

# Test Bacula
echo -n "Bacula Director: "
vagrant ssh srv-backup -c "sudo systemctl is-active bacula-director" 2>/dev/null

# Test OpenVPN
echo -n "OpenVPN: "
vagrant ssh srv-main -c "sudo systemctl is-active openvpn@server" 2>/dev/null

echo "=== Koniec weryfikacji ==="

#!/bin/bash
# Skrypt weryfikacyjny środowiska

echo "=== Weryfikacja środowiska ==="

# Test DHCP
echo -n "DHCP: "
vagrant ssh srv-main -c "sudo systemctl is-active isc-dhcp-server" 2>/dev/null

# Test Apache
echo -n "Apache: "
curl http://192.168.56.10 &>/dev/null && echo "OK" || echo "BŁĄD"

# Test GitLab
echo -n "GitLab: "
curl http://192.168.56.10:8080 &>/dev/null && echo "OK" || echo "BŁĄD"

# Test Bacula
echo -n "Bacula Director: "
vagrant ssh srv-backup -c "sudo systemctl is-active bacula-dir" 2>/dev/null

echo -n "Bacula Storage: "
vagrant ssh srv-backup -c "sudo systemctl is-active bacula-sd" 2>/dev/null

echo -n "Bacula File Daemon: "
vagrant ssh srv-backup -c "sudo systemctl is-active bacula-fd" 2>/dev/null

# Test Bacula-Web
echo -n "Bacula-Web: "
status_code=$(curl -s -o /dev/null -w '%{http_code}' http://192.168.56.11/bacula-web/)
if [ "$status_code" = "200" ]; then
    echo "OK"
else
    echo "BŁĄD"
fi

# Test OpenVPN
echo -n "OpenVPN: "
vagrant ssh srv-main -c "sudo systemctl is-active openvpn@server" 2>/dev/null

echo "=== Koniec weryfikacji ==="

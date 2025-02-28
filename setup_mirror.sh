#!/bin/bash
# setup_mirror.sh - Einrichtung des apt-mirror für Ubuntu und Debian

# Sicherstellen, dass das Skript als Root ausgeführt wird
if [[ $EUID -ne 0 ]]; then
   echo "Dieses Skript muss als root ausgeführt werden."
   exit 1
fi

echo "Aktualisiere Paketlisten und installiere apt-mirror..."
apt-get update && apt-get install -y apt-mirror

# Backup der bestehenden Konfiguration (falls vorhanden)
if [ -f /etc/apt/mirror.list ]; then
    cp /etc/apt/mirror.list /etc/apt/mirror.list.backup
    echo "Alte /etc/apt/mirror.list wurde als /etc/apt/mirror.list.backup gesichert."
fi

echo "Schreibe neue Konfiguration nach /etc/apt/mirror.list..."
cat > /etc/apt/mirror.list <<'EOF'
set base_path    /var/spool/apt-mirror
set mirror_path  $base_path/mirror
set skel_path    $base_path/skel
set var_path     $base_path/var
set cleanscript  $base_path/clean.sh
set defaultarch  amd64
set nthreads     20
set _tilde       0

### Ubuntu Mirror (Beispiel: Ubuntu 20.04 LTS - focal)
deb http://archive.ubuntu.com/ubuntu focal main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu focal-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu focal-security main restricted universe multiverse

### Debian Mirror (Beispiel: Debian stable)
deb http://deb.debian.org/debian stable main contrib non-free
deb http://deb.debian.org/debian stable-updates main contrib non-free
deb http://security.debian.org/ stable/updates main contrib non-free

EOF

echo "Konfiguration erstellt."

echo "Erstelle notwendige Verzeichnisstrukturen..."
mkdir -p /var/spool/apt-mirror/{mirror,skel,var}

echo "Starte den initialen Mirror-Lauf..."
apt-mirror

echo "Setup abgeschlossen. Die gemirrten Repositories findest Du unter /var/spool/apt-mirror/mirror."

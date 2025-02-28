#!/bin/bash
# update_mirror.sh - Aktualisiert die Spiegel-Repositories

# Dieses Skript führt apt-mirror aus, um die Repositories zu aktualisieren.
# Es kann per Cron oder manuell ausgeführt werden.

if [[ $EUID -ne 0 ]]; then
   echo "Bitte führe dieses Skript als root aus."
   exit 1
fi

echo "Starte Update des Mirrorservers..."
apt-mirror
echo "Update abgeschlossen."

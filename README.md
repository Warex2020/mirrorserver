# Mirror Server Setup für Ubuntu & Debian

Dieses Repository enthält ein Set von Shell-Skripten, um einen lokalen Mirror-Server für Ubuntu und Debian aufzusetzen. Ziel ist es, einen funktionsfähigen Mirror bereitzustellen, der auch im Offline-Betrieb genutzt werden kann.

## Inhalt

- **setup_mirror.sh**  
  Installiert und konfiguriert `apt-mirror`, legt die nötigen Verzeichnisstrukturen an und startet den initialen Mirror-Lauf.

- **update_mirror.sh**  
  Führt `apt-mirror` aus, um die Spiegel-Repositories zu aktualisieren. Dieses Skript kann manuell oder über einen Cron-Job aufgerufen werden.

- **setup_webserver.sh**  
  Installiert Apache und richtet einen VirtualHost ein, um den Mirror-Server über HTTP bereitzustellen.

- **setup_crontab.sh**  
  Prüft, ob bereits ein Crontab-Eintrag für `update_mirror.sh` existiert und fügt diesen hinzu, falls nicht. Standardmäßig wird das Update-Skript täglich um 2:30 Uhr ausgeführt.

## Voraussetzungen

- **Betriebssystem:**  
  Empfohlen wird ein Linux-Server (z. B. Ubuntu Server LTS oder Debian).

- **Berechtigungen:**  
  Alle Skripte sollten mit Root-Rechten (oder via `sudo`) ausgeführt werden.

- **Internetverbindung:**  
  Für den initialen Mirror-Lauf und regelmäßige Updates sollte eine temporäre Internetverbindung bestehen – im Offline-Betrieb erfolgt die Synchronisation in definierten Wartungsfenstern.

## Installation

1. **Repository klonen**

   ```bash
   git clone https://github.com/DEIN_USERNAME/DEIN_REPOSITORY.git
   cd DEIN_REPOSITORY

2.
chmod +x setup_mirror.sh update_mirror.sh setup_webserver.sh setup_crontab.sh

3.
sudo ./setup_mirror.sh

4.
sudo ./setup_webserver.sh

5.
sudo ./setup_crontab.sh

6.
sudo ./update_mirror.sh

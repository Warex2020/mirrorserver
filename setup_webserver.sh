#!/bin/bash
# setup_webserver.sh - Installation und Konfiguration von Apache zum Bereitstellen des Mirrors

if [[ $EUID -ne 0 ]]; then
   echo "Dieses Skript muss als root ausgeführt werden."
   exit 1
fi

echo "Installiere Apache..."
apt-get update && apt-get install -y apache2

echo "Erstelle Apache-VirtualHost Konfiguration..."
cat > /etc/apache2/sites-available/apt-mirror.conf <<'EOF'
<VirtualHost *:80>
    ServerName mirror.deinedomain.tld
    DocumentRoot /var/spool/apt-mirror/mirror

    <Directory /var/spool/apt-mirror/mirror>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/apt-mirror_error.log
    CustomLog ${APACHE_LOG_DIR}/apt-mirror_access.log combined
</VirtualHost>
EOF

echo "Aktiviere die neue Site und starte Apache neu..."
a2ensite apt-mirror.conf
systemctl reload apache2

echo "Apache ist konfiguriert. Der Mirror ist nun erreichbar unter http://mirror.deinedomain.tld"

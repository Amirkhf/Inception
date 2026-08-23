#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
	# genere le dossier mysql qui contient les tables systemes
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

	# lance le serveur en arriere plan le temps de creer la database
	mariadbd --user=mysql --datadir=/var/lib/mysql &

	# attendre que le serveur soit bien demarre
	sleep 3

	# execute les requetes sql pour configurer la base et les utilisateurs
	mariadb -u root << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

	# eteint proprement le serveur temporaire avec le mdp root
	mariadb-admin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
	sleep 2
fi

# demarre le moteur de base de donnees et le laisse tourner en continue au premier plan
exec mariadbd --user=mysql --datadir=/var/lib/mysql --console

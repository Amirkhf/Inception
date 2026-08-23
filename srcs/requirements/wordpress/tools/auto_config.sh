#!/bin/sh

# attendre que mariadb soit pret a recevoir des connexions
until mariadb -h mariadb -u "${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;" > /dev/null 2>&1; do
    echo "En attente de MariaDB..."
    sleep 3
done

# telecharger et installer wordpress si pas encore present
if [ ! -f "/var/www/html/wp-config.php" ]; then
php -d memory_limit=512M /usr/local/bin/wp core download --allow-root --path=/var/www/html
    wp config create --allow-root \
        --path=/var/www/html \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb:3306"

    wp core install --allow-root \
        --path=/var/www/html \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    wp user create --allow-root \
        --path=/var/www/html \
        "${WP_USER}" "${WP_EMAIL}" \
        --user_pass="${WP_PASSWORD}" \
        --role=author
fi

# demarrer php-fpm en premier plan
exec /usr/sbin/php-fpm83 -F

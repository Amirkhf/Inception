FROM alpine:3.23.5

RUN apk update && apk upgrade && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-curl \
    php83-dom \
    php83-exif \
    php83-fileinfo \
    php83-mbstring \
    php83-openssl \
    php83-xml \
    php83-zip \
    php83-phar \
    php83-tokenizer \
    php83-ctype \
    mariadb-client \
    curl \
    tar

# Creer un lien symbolique pour que la commande "php" pointe vers php83
RUN ln -sf /usr/bin/php83 /usr/bin/php

RUN echo "memory_limit = 512M" >> /etc/php83/php.ini

# Installer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configurer PHP-FPM pour ecouter sur le port 9000
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf && \
    sed -i 's/listen = \/run\/php\/php8.3-fpm.sock/listen = 9000/g' /etc/php83/php-fpm.d/www.conf 2>/dev/null || true

RUN mkdir -p /var/www/html

COPY tools/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

EXPOSE 9000

WORKDIR /var/www/html

CMD ["/usr/local/bin/auto_config.sh"]

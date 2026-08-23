FROM alpine:3.23.5

RUN apk update && apk upgrade && apk add --no-cache \
    nginx \
    openssl

RUN mkdir -p /etc/nginx/ssl /var/www/html

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=amkhelif.42.fr"

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

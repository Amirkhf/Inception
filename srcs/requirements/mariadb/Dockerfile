FROM alpine:3.24.1

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY conf/mariadbserver.cnf etc/my.cnf.d/mariadb-server.cnf

COPY tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306
CMD ["mariadb.sh"]

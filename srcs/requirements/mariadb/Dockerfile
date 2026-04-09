FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/my.cnf /etc/mysql/my.cnf

CMD ["mysqld"]
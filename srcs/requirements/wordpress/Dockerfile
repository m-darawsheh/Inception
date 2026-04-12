FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/setup_wp.sh /setup_wp.sh

RUN chmod +x /setup_wp.sh

EXPOSE 9000

CMD ["/setup_wp.sh"]
FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-zip \
    curl \
    mariadb-client \
    less \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -L -o /usr/local/bin/wp https://github.com/wp-cli/wp-cli/releases/download/v2.8.1/wp-cli-2.8.1.phar \
    && chmod +x /usr/local/bin/wp

# Create web directory
RUN mkdir -p /var/www/html

# Copy PHP-FPM config
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copy setup script
COPY ./tools/setup_wp.sh /setup_wp.sh
RUN chmod +x /setup_wp.sh

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/setup_wp.sh"]
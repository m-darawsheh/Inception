#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe &
MARIADB_PID=$!

echo "Waiting for MariaDB to start..."
while ! mysqladmin ping -h localhost -u root --silent 2>/dev/null; do
    sleep 1
done

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Creating database and users..."
    
    mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    echo "Database initialization complete"
else
    echo "Database already exists, skipping initialization"
fi

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

wait $MARIADB_PID 2>/dev/null || true

exec mysqld_safe
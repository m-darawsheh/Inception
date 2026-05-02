# USER DOCUMENTATION

## Overview of services

The stack provides the following services (names may vary by compose file):
- Nginx: HTTP server and reverse proxy
- PHP / WordPress: application server and CMS
- MariaDB: relational database for WordPress

## Start and stop the project

- Start the stack:

```bash
make
# or
cd srcs && docker compose up -d --build
```

- Stop and remove containers and volumes:

```bash
cd srcs && docker compose down -v
```

Check the `Makefile` and `srcs/docker-compose.yml` for project-specific commands.

## Accessing the website and administration panel

- Website: open a browser and navigate to the host/port exposed by Nginx (commonly http://localhost or http://localhost:8080). Verify `srcs/docker-compose.yml` for the exact port mapping.
- WordPress admin panel: typically at `/wp-admin` (e.g., http://localhost/wp-admin).

## Locate and manage credentials

- Development credentials and configuration values are typically defined in environment files, `srcs/requirements/*/conf`, or in initialization scripts under `srcs/requirements/*/tools`.
- For production use, do not store secrets in the repository. Use Docker secrets, an external secrets manager, or environment variables defined outside of version control.

## Verify services are running correctly

- Check containers:

```bash
cd srcs && docker compose ps
```

- View logs:

```bash
cd srcs && docker compose logs -f nginx wordpress mariadb
```

- Quick health checks:
  - Visit the web root in a browser and confirm the homepage loads.
  - Connect to the database container and list databases to confirm persistence.

## Troubleshooting

- If a service fails to start, inspect its logs (`docker compose logs <service>`). Check that required environment variables or secret files are present and correct. Rebuild images with `docker compose up --build` if configuration changed.

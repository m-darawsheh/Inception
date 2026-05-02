# DEVELOPER DOCUMENTATION

## Prerequisites

- Install Docker Engine and Docker Compose (or use Docker Desktop)
- Install `make` and a POSIX shell
- Recommended: Git to clone the repository

## Setup from scratch

1. Clone the repository:

```bash
git clone <repo_url>
cd Inception
```

2. Review configuration files under `srcs/requirements/*/conf` and any sample environment files. Create a local `.env` (not committed) with required values if needed (DB passwords, host settings).

Example `.env` entries (do NOT commit this file):

```
DB_ROOT_PASSWORD=replace_me
DB_USER=wp_user
DB_PASSWORD=replace_me
```

## Build and launch using Makefile and Docker Compose

- Build and start all services:

```bash
make
cd srcs && docker compose up -d --build
```

- Rebuild a single service:

```bash
cd srcs && docker compose build <service>
cd srcs && docker compose up -d <service>
```

## Managing containers and volumes

- List containers and statuses:

```bash
cd srcs && docker compose ps
```

- View logs:

```bash
cd srcs && docker compose logs -f
```

- Stop and remove containers and volumes:

```bash
cd srcs && docker compose down -v
```

- Remove unused volumes:

```bash
docker volume prune
```

## Data storage and persistence

- Persistent data is defined by volumes in `srcs/docker-compose.yml` (for example `mariadb` data and WordPress uploads). Check `volumes:` section in the compose file to see actual volume names and any bind mounts used for development.
- Database initialization scripts are in `srcs/requirements/mariadb/tools/` and should be used to populate initial data if needed.

## Notes on secrets and development workflow

- For local development, environment variables stored in a local `.env` are acceptable, but never commit sensitive values.
- For production, prefer Docker secrets or a managed secret store.

## Useful commands summary

- Start: `make` or `cd srcs && docker compose up -d --build`
- Stop: `cd srcs && docker compose down -v`
- Logs: `cd srcs && docker compose logs -f`
- Inspect: `cd srcs && docker compose ps`

# *This project has been created as part of the 42 curriculum by mdarawsh.*

# Inception

## Description

Inception is a multi-container Docker project providing a small web stack (Nginx, MariaDB, PHP/WordPress) configured for learning and deployment exercises in the 42 curriculum. The goal is to build, deploy, and document a reproducible development stack using Docker Compose and simple automation scripts.

## Instructions

- **Build & Run:** From the repository root run the provided Makefile targets. Typical commands:

```bash
make           # builds and starts the stack (project-specific Makefile targets)
cd srcs && docker compose up -d --build
```

- **Stop & Clean:**

```bash
cd srcs && docker compose down -v
```

Check the `Makefile` at the repository root and `srcs/docker-compose.yml` for exact targets and service names.

## Project description (Docker usage and design choices)

This project uses Docker to containerize services so they run in isolated, reproducible environments. The repository includes Dockerfiles and service configuration under `srcs/requirements/` for the main services (mariadb, nginx, wordpress).

- Main design choices:
  - Service separation: each service runs in its own container (Nginx, PHP/WordPress, MariaDB).
  - Configuration-as-code: service config files live in `srcs/requirements/*/conf` and initialization scripts are in `tools/`.
  - Persistence: databases and persistent application data are stored using Docker volumes (see `srcs/docker-compose.yml`).

### Comparisons

- Virtual Machines vs Docker
  - VMs provide full OS virtualization and stronger isolation at the cost of higher resource usage and slower start times.
  - Docker shares the host kernel and provides lightweight, fast-starting containers ideal for microservices and development workflows.

- Secrets vs Environment Variables
  - Environment variables are simple and convenient for configuration but can leak in process lists, logs, or images if not handled carefully.
  - Docker secrets (or external secret managers) provide safer secret handling for sensitive values in production. Use secrets for DB root passwords and API keys in production; env vars are acceptable for local development when documented and kept out of version control.

- Docker Network vs Host Network
  - Docker bridge/network isolates containers and allows service name resolution between containers. This is preferred for portability and security.
  - Host networking exposes container ports directly on the host network namespace. Use only when you need low network latency or specific network access and understand the security trade-offs.

- Docker Volumes vs Bind Mounts
  - Docker volumes are managed by Docker and are preferable for database storage and persistent data because they are easier to back up and migrate.
  - Bind mounts map host directories into containers and are useful for local development (e.g., editing code on the host and seeing changes in a container).

## Resources

- Official docs and references:
  - Docker: https://docs.docker.com/
  - Docker Compose: https://docs.docker.com/compose/
  - Nginx: https://nginx.org/en/docs/
  - MariaDB: https://mariadb.com/kb/en/
  - WordPress: https://wordpress.org/support/

- How AI was used
  - AI assistance was used to draft and structure the repository documentation (README, USER_DOC, DEV_DOC), and to produce suggested content and explanations for Docker design choices. All configuration and code changes should be reviewed by a developer before production use.

## Additional notes

See USER_DOC.md and DEV_DOC.md at the repository root for detailed user and developer instructions.

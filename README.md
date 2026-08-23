*This project has been created as part of the 42 curriculum by amkhelif.*

## Description
Inception aims to teach how to design and deploy a complete web infrastructure using Docker.
The subject requires setting up three distinct services: a container for NGINX, a container for WordPress, and a container for MariaDB. The goal is to learn how to create our own Dockerfiles, build custom images, deploy containers from these images, and make these containers communicate with each other through an internal virtual network.

**Mandatory Technical Comparisons:**
*   **Virtual Machines vs Docker:** VMs emulate complete hardware and run a full OS, making them heavy. Docker containers share the host's OS kernel and only isolate processes, making them lightweight and fast.
*   **Secrets vs Environment Variables:** Environment variables easily inject configuration data at runtime. Docker secrets provide a more secure mechanism for handling sensitive data (like passwords), since they are mounted as files in memory and never appear in `docker inspect`, image layers, or process listings. This project uses a `.env` file to inject credentials as environment variables, which is the minimum required by the subject.
*   **Docker Network vs Host Network:** Using a virtual bridge network allows our containers to communicate securely and privately via an internal DNS (each service is reachable by its service name, e.g. `mariadb`, `wordpress`). The Host Network binds containers directly to the host's network stack, removing this isolation — it is explicitly forbidden by the subject.
*   **Docker Volumes vs Bind Mounts:** A bind mount points directly to an arbitrary path on the host and is managed outside of Docker. A named volume is created and managed by the Docker daemon itself, tracked with `docker volume ls`, and can still be configured to physically store its data at a specific path on the host using the `local` driver with `driver_opts` (`type: none`, `o: bind`, `device: <path>`). This project uses **named volumes** (`mariadb_data` and `wordpress_data`) configured this way, so that Docker manages the volume lifecycle while the data is guaranteed to persist at `/home/amkhelif/data` on the host, as required by the subject.

## Instructions
1. Create a `.env` file in the `srcs/` directory containing the environment variables and passwords (ignored by git).
2. Run `make` at the root of the repository to build and start the infrastructure.
3. Access the website securely at `https://amkhelif.42.fr`.
4. To stop the infrastructure, run `make down`. To completely clean containers and volumes, run `make fclean`.

## Resources
*   Docker and Docker Compose official documentation.
*   Alpine Linux, NGINX, MariaDB, and WordPress official documentation.
*   AI Usage AI tools were used to help structure this documentation, explain Docker networking concepts.

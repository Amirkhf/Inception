*This project has been created as part of the 42 curriculum by amkhelif.*

## Description
Inception aims to teach how to design and deploy a complete web infrastructure using Docker. 
The subject requires setting up three distinct services: a container for NGINX, a container for WordPress, and a container for MariaDB[cite: 1]. The goal is to learn how to create our own Dockerfiles, build custom images, deploy containers from these images, and make these containers communicate with each other through an internal virtual network[cite: 1].

**Mandatory Technical Comparisons:**
*   **Virtual Machines vs Docker:** VMs emulate complete hardware and run a full OS, making them heavy. Docker containers share the host's OS kernel and only isolate processes, making them lightweight and fast[cite: 1].
*   **Secrets vs Environment Variables:** Environment variables easily inject configuration data. Docker secrets provide a more secure mechanism for handling sensitive data (like passwords) without exposing them in logs or source code[cite: 1].
*   **Docker Network vs Host Network:** Using a virtual bridge network allows our containers to communicate securely in private via an internal DNS. The Host Network binds containers directly to the host's network, which is less secure and forbidden here[cite: 1].
*   **Docker Volumes vs Bind Mounts:** Volumes are managed entirely by Docker. This project uses bind mounts to specific paths (`/home/amkhelif/data`) to store web files and databases directly on the host machine, ensuring data persistence[cite: 1].

## Instructions
1. Create a `.env` file in the `srcs/` directory containing the environment variables and passwords (ignored by git).
2. Run `make` at the root of the repository to build and start the infrastructure.
3. Access the website securely at `https://amkhelif.42.fr`.
4. To stop the infrastructure, run `make down`. To completely clean containers and volumes, run `make fclean`.

## Resources
*   Docker and Docker Compose official documentation.
*   Alpine Linux, NGINX, MariaDB, and WordPress official documentation.
*   **AI Usage:** AI tools were used to help structure this documentation, explain Docker networking concepts, and debug shell script syntax[cite: 1]. All configurations and scripts have been fully reviewed, tested, and understood by the author[cite: 1].

Basically:
- Based on client-server architecture
- Provides a complete application environment
- Includes the client, the host, and the registry components
## Docker process overview
1. Using either the Docker CLI or REST APIs, the Docker client sends instructions or commands to the Docker host server
2. The Docker host server, referred to as the host, includes the Docker daemon known as dockerd 
3. The daemon listens for Docker API requests or commands such as `docker run` and processes those commands
4. The daemon builds, runs, and distributes containers to the registry
## Docker host
The Docker host also includes and mangaes:
- Images
- Containers
- Namespaces
- Networks
- Storage
- Plugins and add-ons
## Docker communications
- The Docker client can communicate with both local and remote hosts
- The Docker client and host daemon can run:
	- On the same system
	- On different systems
- Docker daemons can also communicate with other daemons to manage Docker services

## Registry
- Stores and distributes images
- Acess is public or private
	- Public such as Docker Hub - everyone can access
	- Private - implemented for security
- Registry locations are either hosted or self-hosted

## Registry access

![[Pasted image 20240318110101.png]]


## Docker architecture

![[Pasted image 20240318110239.png]]


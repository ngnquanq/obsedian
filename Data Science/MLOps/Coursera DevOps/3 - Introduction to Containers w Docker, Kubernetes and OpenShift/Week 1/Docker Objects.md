## Docker objects 
Including:
- Dockerfile
- Image
- Container
- Network
- Storage
- Other objects, Plugins, Add-ons

### Dockerfile:
- A Dockerfile is a text file that contains intructions needed to create an image. 
- The Dockerfile is created using any editor from the console or terminal
- A few instructions that Docker provides:
	- `FROM`
		- Defines base image: The os or something, the programmming language
	- `RUN`
		- Executes arbitrary commands
	- `CMD`
		- Defines default command for container execution

### Docker image:
- Read-only template with instructions for creating Docker container
- Built using instruction from a Dockerfile; a new read-only image layer is created for each instruction 
- A writeable layer is added when an image is run as a container
- Layers can be shared between images, which saves disk space and network bandwith

![[Pasted image 20240318103713.png]]

### Container image naming

`hostname/repository:tag`

Whereas:
- `hostname`: identifies the image registry
- `repository`: a group of related container images
- `tag`: provides information about a specific version or variant of an image

Considering this example:
`docker.io/ubuntu:18.04`
- `docker.io`: the Docker Hub registry
- `ubuntu`: indicate an ubuntu image
- `18.04`: the install ubuntu version

### Docker containers
A Docker container:
- Is a runnable instance of an image
- Can be created, stopped, started or deleted using the Docker API or CLI
- Can connect to multiple networks, attach storage, or create a new image based on its current state
- Is well isolated from other containers and its host machine

### Docker networks, storage and plugins

![[Pasted image 20240318104655.png]]


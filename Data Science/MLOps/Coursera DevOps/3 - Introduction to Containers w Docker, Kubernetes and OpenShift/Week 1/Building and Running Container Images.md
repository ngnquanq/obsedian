
## Docker container creation process

Steps to create and run containers:
1. Create a Dockerfile
2. Use the Dockerfile to create a container image
3. Use the container image to create a running container

## Dockerfile example
Use a Dockerfile to create a running container:
- This sample Dockerfile has the commands `FROM` and `CMD`. 
- `FROM` defines the base image
- `CMD` prints the words "Hello World!" on the terminal

![[Pasted image 20240318101702.png]]

## Docker build command

Create a container image using the build command: 
```cmd
docker build -t my-app:v1 .
```
build: command
-t: tag
my-app: repository
v1: version
. : current dicrectory

And this is the output: 

![[Pasted image 20240318101844.png]]

## Docker image verification
To verify the creation of the image, run the docker images command:

```linux
docker images
```

And the output is: 

![[Pasted image 20240318102022.png]]
## Docker run command

Create the container using the `run` command:

```linux
docker run my-app:v1
```

To verify the details of the container created, run the:
```linux
docker ps -a 
```

## Docker commands

![[Pasted image 20240318102256.png]]


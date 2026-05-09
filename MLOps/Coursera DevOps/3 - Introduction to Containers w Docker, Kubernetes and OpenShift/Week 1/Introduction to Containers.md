## Digital transformation and containers

Containers solve the problem of making software portable so that applications can run on multiple platform. 

## A container - defined
- A container is a standard unit of software that encapsulates everything that programmers need to build, ship and run applications

![[Pasted image 20240318094653.png]]

## Why use containers
These are the challenges of with traditional application:

![[Pasted image 20240318094846.png]]

## Container characteristics

- The container engine virtualizes the operating system.
- A container is light-weight, fast, isolated, portable and secure.
- Require less memory. 
- Binaries, libraries (artifacts) within container enable apps to run
- One machine can host multiple containers

![[Pasted image 20240318095049.png]]

## Containers offer easy portability

![[Pasted image 20240318095232.png]]

##  Container benefits
Containers enable organizations to:
- Quickly create applications using automation. 
- Lower deployment time and costs
- Utilize resource (CPU and memory)
- Port across different environments.
- Support next-gen app (microservices)

## Container challenges
- Security impacted if operating system affected
- Difficult to manage thousands of containers
- Complex to migrate legacy projects to container technology
- Difficult to right-size containers for specific scenarios

## Container vendors
- **Docker**: Robust and most popular container platform today
- **Podman**: Daemon-less architecture providing more security than Docker containers
- **LXC:** Preferred for data-intensive apps and ops
- **Vagrant**: Offers highest levels of isolation on the running physical machine
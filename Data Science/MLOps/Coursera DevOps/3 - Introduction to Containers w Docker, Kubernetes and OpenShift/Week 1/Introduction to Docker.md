## The Docker process

The Docker process isolate apps from infrastructure.

![[Pasted image 20240318100802.png]]

## Docker's underlying technology
- Written in Go programming language
- Uses Linux kernel's features to deliver functionality
- Uses the namespaces technology to provide an isolated workspace called "container"
- Creates a set of namespaces for every container and each aspect runs in a separate namespace with access limited to that namespace

## Docker add-ons
- Docker methodology inspried additional innovations:
	- Tools
	- Development methodologies
	- Techonologies

## Docker benefits
- Consistent and isolated environments
- Fast deployment
- Repeatability and automation
- Supports Agile and CI/CD DevOps practiecs
- Versioning for easy testing, rollbacks, and redeployments
- Collaboration, modularity and scaling
- Easy portability and flexibility

## Challenging use cases
Docker is not a good fit for applications:
- Requiring high performance or security
- Based on Monolith architecture
- Using rich GUI features
- Performing standard Desktops or limited function


> "Continuus Delivery is a software developement discipline where you build software in such a way the software can be released onto production at any time"
> *- Martin Fowler*

## Release to production at any time
- The master branch should always be ready to deploy
- You need a way to know if something will "break the build"
- Deliver every change to a production-like environment

## CI/CD pipeline
Automated gates that create a pipeline of checks:
- Unit testing
- Code quality checks
- Integration testing
- Security testing
- Vulnerability scanning
- Package signing
## A CI/CD pipeline needs
- **A code repository**: To host and manage all of your source code
- **A build server**: To build the application for the source code (i.e Travis CI, GitHub Actions)
- **An integration/orchestrator** To automate the build and run the quality and other tests (i.e IBM CI)
- **An artifact repository**: To store binaries, the artifacts of the application (i.e python wheels, ruby jem,...)
- **Automatic configuration and deployment**

![[Pasted image 20240316192307.png]]

## Five key principles
- Build quality in
- Work in small batches
- Computers perform repetitive tasks, people solve problems
- Relentlessly pursue continuous improvement
- Everyone is responsible

## CI/CD + Continuous deployment

![[Pasted image 20240316192542.png]]

## How DevOps manages risk
- Deployment is king
- Deployment is decoupled from activation 
- Deployment is not "one size fits all"
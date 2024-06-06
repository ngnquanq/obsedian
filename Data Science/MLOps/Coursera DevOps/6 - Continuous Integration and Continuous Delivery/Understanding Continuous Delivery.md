## What is Continuous Delivery (CD)?
### Differentiating CI from CD
- it's 2 distinct things
- CI is continuously integrating code back to main/master/trunk branch before it's taking too far, therefore hard to keep track. 
- CD is deploying that integrated code somewhere. You can simultaneously deploy for each integration, you may not wanna do that. With that being said, these CI and CD are two different things. 
### What is continuous delivery
Continuous Delivery is a series of practices designed to ensure that code can be swiftly and safely deployed to production by delivering every change to a production-like environment. 
Notice that all of this is **automated**
### Goals of continuous delivery
By Martin Fowler, "Continuous Delivery is a software development discipline where you build software in such a way that the **software can be released to production at any time**"
- Main or Master branch must always be deployable.
- Require checks to ensure no bad code gets into main branch and breaks your product.
- Continuous Integration runs tests on every pull request. 
- Ensures things work before merging back to main branch 
### Benefits of Continuous Delivery
- Automate software transportation through SDLC (software development life cycle) stages
- Reduce deployment time by the **automation process**
- Reduce costs
- Scale based on project size
- Deploy code automatically into each stage of SDLC

## Continuous Delivery key principles
### Build in quality
- Ensure quality built in at every step
- Continually review your code 
- Ensure everything looks good along the pipeline 
### Work in small batches 
- Make your user stories small 
- Continuously integrate changes 
### People solve problems 
- People shouldn't need to perform repetitive task
- With TDD, you could manually pull and test code
- Let computers do this: 
	- Quicker and better
	- Example: GitHub Actions 
### Pursue continuous improvement
- Continuous Delivery enables continuous improvement 
- Know where you are and when things are broken 
### Everyone is responsible
If a build breaks: 
- Dont ask, "Whose fault is it?"
- Do this instead, "Why did this fail?" and "What can we do to stop this from occurring again?"
- How did the system fail the people?
## Continuous Delivery Practices 
### Best practices
- Make every change releasable
- Embrace trunk-based development
- Deliver through an automated pipeline
### More best practices
- Automate as many processes as possible
- Eliminate downtime 
- Release at the granularity of test
### CI/CD pipeline requirements
- A code repository to host and manage all source code
- A build server: want that env to perform clean build from the same start everytimes
- An integration server/orchestrator: handle build automation 
- A storage repository: stored all binary and artifacts 
### Deployment or Delivery
- Continuous Deployment can be part of a Continuous Delivery pipeline.
- Continuous Delivery describes the automated movement of code through the SDLC. 
- Continuous Deployment is taking that code and deploying it to production.
- The need for Continuous Deployment depends on business needs.

## Tools of Continuous Delivery (CD)
### Overview of CD tools:
- **Jenkins** - popular, supports many plugins, but not ideal for CD
- **Spinnaker** - dedicated cloud-agnostic CD tools, native support for load balancers and scaing clusters, but is not a build tool
- **Concourse** - mainly a CI tool with containers in mind, but can run in VMs too
- **GitLab** - implements CI and CD, easy to automate, also an SCM tool, supports major cloud platforms 
- **Travis CI** - CI tool that had CD capabilities, but isn't feature-rich
- **Tekton** - can build, test, and deploy to Kubernetes, offers modularity 
- **Go CD** - easy pipeline setup, native Docker and Kubernetes support, build pipelines with YAML, JSON or GUI
- **Argo CD** - well-designed UI, easy to use, integrates with various CI tools
### What to look for
- Feature richness
- Compatibility 
- Ease of use/setup
- Maintenance effort 
### Tasks in a CD pipeline 
- Security scanning
- Vulnerability scanning 
- Secret scanning
- Static Application Security Testing (SAST)
- Dynamic Application Security Testing (DAST)
- Deployment
### Argo CD overview
- Declarative Continuous Delivery tool
- Follows GitOps 
- Implemented as Kubernetes controller
### Tektok overview
- A flexible, open source framework 
- Standardized tooling and processes 
- Made for reuseability 

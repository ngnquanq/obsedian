# Overview
|Term|Definition|Where the term is introduced|
|---|---|---|
|**Ansible**|An open-source IaC tool that automates various IT tasks such as, configuration management, application deployment, and cloud provisioning.|Infrastructure as Code (IaC) Video|
|**Build systems**|Software tools that automate the process of compiling the source code and generate executable programs or other deliverables.|Platform and Tools Video|
|**Circle CI**|A CI/CD platform that enables the implementation of DevOps practices and supports Continuous Delivery.|Platform and Tools Video|
|**Configuration Management Systems (CMSs)**|Software tools or frameworks that enable organizations to manage and control the configuration of their systems and infrastructure in a consistent and efficient manner.|Infrastructure as Code (IaC) Video|
|**Continuous Delivery**|A software development practice that focuses on automating the release and deployment of integrated code.|What Is CI/CD? Video|
|**Continuous Integration**|A software development practice that involves regular integration of code changes from multiple developers into the master repository.|What Is CI/CD? Video|
|**Declarative Approach**|An approach that focuses on describing the desired outcome or state without specifying the step-by-step procedure of that outcome.|Infrastructure as Code (IaC) Video|
|**DevOps**|Developer Operations is a methodology that combines software development and IT operations to improve collaboration, efficiency, and code quality.|Infrastructure as Code (IaC) Video|
|**DevOps Pipeline**|A series of automated processes and tools that facilitate the development, testing, deployment, and monitoring of software applications within the context of DevOps practices.|What Is CI/CD? Video|
|**GitHub and Bitbucket**|Both are web-based platforms used for version control and collaboration in software development projects.|Platform and Tools Video|
|**Imperative Approach**|An approach in IaC where the dependencies and execution order need to be specified by the user. Tools like Chef and Ansible follow the imperative approach.|Infrastructure as Code (IaC) Video|
|**Infrastructure as Code**|An approach in which infrastructure configuration and management are automated using code.|Infrastructure as Code (IaC) Video|
|**Jenkins**|A popular CI/CD software installed on a server to facilitate centralized build processes.|Platform and Tools Video|
|**Pull requests**|Is a practice for reviewing and discussing code changes before merging them into the main branch.|What Is CI/CD? Video|
|**Repositories**|Platforms or systems that store and manage the versioned artifacts, such as binaries, libraries, or packages, produced during the software development process. Examples include Nexus and JFrog Artifactory.|Platform and Tools Video|
|**Ruby**|A programming language known for its simplicity.|Infrastructure as Code (IaC) Video|
|**Sandboxes**|Sandboxes are isolated environments that allow users to safely test and experiment with software, applications, or code without affecting the production or main system.|What Is CI/CD? Video|
|**Source code management**|A software tool or system that facilitates the management and tracking of changes made to source code files.|Platform and Tools Video|
|**Testing branches**|Separate branches created specifically for testing purposes.|What Is CI/CD? Video|
|**Travis CI**|A hosted continuous integration service used to build and test software projects hosted on GitHub, Bitbucket, GitLab, Perforce, Apache Subversion and Assembla.|Platform and Tools Video|
|**YAML**|YAML stands for Yet Another Markup Language is a simple and expressive way to represent data structures and configurations in a plain-text format that is easy for both humans and machines to read and write.|Infrastructure as Code (IaC) Video|
# Cousre introduction
Goals:
- Create automate pipeline 
- Workflow + teachnique for SE as IBM 
- Deploy at the speed of need 
- CI/CD Pipeline automation 

All about mean lead time (release frequency)

CI:
- Process continuously integrate change into the main branch:
	- Social coding
	- Git workflows
	- CI tools
	- Github actions 
CD:
- CD Tools
- Tekton pipelines 
- Kubernetes 

DevOps and GitOps with OpenShift 

# What is CI/CD?
## Diffrences
- CI/CD is not one process. But rather two distinct processes.
- CI is continuously integrating code back to main/master/trunk branch. Therefor the branch should not be diverge too far before perform merge changes back into the main branch 
- CD is deploying that integrated code somewhere

## Define CI
- Automation process that allows developers to integrate their work into a repository
- Helps to enable collaborative development across teams
- Helps to identify integrations bugs sooner
- Teams can work in small chunks and regularly integrate new code into the main branch 
## Define CD
- Continuous Delivery comes after Continuous Integration
- Prepares the code for release 
- Automates the steps that are needed to deploy a build 
## Define CI/CD
![[Pasted image 20240428000359.png]] 

## DevOps pipeline
![[Pasted image 20240428000456.png]]

## Benefits
- Faster reaction times to changes 
- Reduced code integration risk 
- Higher code quality
- Code in version control works 
- Less deployment time 

# Platform and Tools 
## Pipeline can use many tools
![[Pasted image 20240428104512.png]]
## Pipeline tools
![[Pasted image 20240428104553.png]]
## Overview of common CI/CD tools
![[Pasted image 20240428104727.png]]


# Infrastucture as Code (IaC)
## What is Infrastructure as Code? 
- Describes your infrastructure in textual format for easy system configuration
- Textual code that you hand to an IaC tool to provision your infrastructure elements
- Often written in .yaml file 
## Why use IaC 
- Reduces manual system and software configurations
- CMSs made this possible 
- IaC makes it easy to rapidly provision the same platform repeatedly
## Declarative vs. imperative approach 

![[Pasted image 20240429104404.png]]
## Inventory files and IaC tools 
![[Pasted image 20240429104547.png]]
## Benefits of IaC 
- Faster time to production
- Faster, more efficient development 
- Protection agaisnt staff churn 
- Lower costs and improved use of developer's time 
## Top IaC tools
- Terraform 
- Ansible 
- Chef 
- Puppet
- SaltStack
# Summary & Highlights: Introduction to CI/CD

Congratulations! You have completed this module. At this point in the course, you know that:

- Continuous Integration (CI) and Continuous Delivery (CD) are two separate and distinct processes that occur sequentially.
    
    - CI is an automation process that developers continuously use to integrate code into the main branch.
        
    - CD automatically deploys this integrated code similar to a staging, testing, or preproduction server.
        
- CI consists of the Plan, Code, Build, and Test phases.
    
- CD consists of the Release, Deploy, and Operate phases.
    
    - It’s acceptable for different teams within an organization to use different tools for CI/CD. What’s important is that the processes are automated.
        
- You can choose the CI/CD tool that works best for you.
    
    - Infrastructure as Code (IaC) tools can dramatically speed up the provisioning and managing of your development environment’s infrastructure.
        
- You can choose from a wide array of IaC tools.
# Reading
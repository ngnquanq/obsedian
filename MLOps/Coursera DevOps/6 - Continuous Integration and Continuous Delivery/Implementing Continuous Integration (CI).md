# Overview
| Term                             | Definition                                                                                                                                 | Where the term is introduced                             |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------- |
| **Automated CI tools**           | Software tools that streamline the development and testing process.                                                                        | Tools of Continuous Integration (CI) Video               |
| **Code Integration Risk**        | The potential for errors or issues when merging new code changes into an existing codebase.                                                | Benefits of Continuous Integration (CI) Video            |
| **Code Quality**                 | The measure of how well-written, reliable, and maintainable code is.                                                                       | Benefits of Continuous Integration (CI) Video            |
| **Code Review**                  | A process in which developers examine and evaluate code changes made by their peers.                                                       | Benefits of Continuous Integration (CI) Video            |
| **Fork**                         | In social coding, forking is creating a personal copy of a repository.                                                                     | Social Coding Video                                      |
| **Master Branch**                | The main branch of a version control repository, representing the stable and production-ready state of the codebase.                       | Git Feature Branch Workflow: Making a Pull Request Video |
| **Open Source**                  | A software development approach where the source code is made publicly available, allowing anyone to view, use, modify, and distribute it. | Tools of Continuous Integration (CI) Video               |
| **Short-lived branches**         | Feature branches in Continuous Integration that are meant for developing small features.                                                   | Git Feature Branch Workflow: Making a Pull Request Video |
| **Social coding**                | The practice of making source code repositories public and encouraging developers to contribute, collaborate, and share code with others.  | Social Coding Video                                      |
| **Source Code Repository**       | A centralized location where developers store and manage the source code of a software project.                                            | Social Coding Video                                      |
| **Traditional Development**      | A software development approach characterized by a linear and sequential process flow.                                                     | Git Feature Branch Workflow: Making a Pull Request Video |
| **Version Control**              | The management and tracking of changes made to files, particularly source code, over time.                                                 | Social Coding Video                                      |
| **Version Control System (VCS)** | Software tools used to manage and track changes to source code, also known as SCM tools.                                                   | Social Coding Video                                      |
| **Webhooks**                     | Methods of communication between applications or services that allow real-time data delivery and event notifications.                      | Social Coding Video                                      |
| **Workflow**                     | A sequence of automated tasks or actions performed by CI tools in response to specific events, such as pull requests or file changes.      | Introduction to GitHub Actions Video                     |
# Introduction to GitHub Actions 
![[Pasted image 20240430104333.png]]
## Marketplace
![[Pasted image 20240430104423.png]]

## GitHub Actions setup 
![[Pasted image 20240430104508.png]]

## Basic concepts 
- Workflow is the basic concept in GitHub Actions
- Workflow is a series of automated procedures
- Every repository can have any number of workflows, which mean you can have a workflow for CI, a workflow for CD, as long as it in workflow folder
- Following components of a workflow: 
![[Pasted image 20240430105247.png]]

# Deeper Dive into GitHub Actions
## Initial setup
![[Pasted image 20240430182446.png]]
## Workflow composition
![[Pasted image 20240430182615.png]]
### Event
Something that activates the execution of a workflow
![[Pasted image 20240430182658.png]]

Examples
![[Pasted image 20240430191231.png]]

### Jobs 
![[Pasted image 20240430191347.png]]

## Runners
![[Pasted image 20240430201929.png]]

For examples
![[Pasted image 20240430202027.png]]

## Services
![[Pasted image 20240430202114.png]]

### Steps 
A step is a task comprising one or more shell commands or actions          
![[Pasted image 20240430203407.png]]

### Actions 
![[Pasted image 20240430203444.png]]

### Actions Marketplace 
For example
![[Pasted image 20240430203942.png]]

# Summary & Highlights: Implementing Continuous Integration (CI)

Congratulations! You have completed this lesson. At this point in the course, you know:

- GitHub Actions is a CI/CD tool available on every GitHub repository. 
    
- GitHub Actions provides starter code to get your workflow up and running quickly. 
    
- You configure GitHub Actions by creating a .github/workflows folder and placing workflow YAML files in it. 
    
- A workflow is a series of automated procedures that GitHub Actions will execute. 
    
- Workflow components include events, jobs, runners, steps, and actions. 
    
- The GitHub Actions Marketplace provides a variety of prebuilt actions that you can use in your workflows.
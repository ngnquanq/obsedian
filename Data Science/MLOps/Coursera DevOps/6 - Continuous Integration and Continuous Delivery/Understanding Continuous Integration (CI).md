# What is Continuous Integration (CI)
- CI is an automation process 
- Allows developers to integrate their work 
- Ensures that the software continues to work properly after being pushed
- Enables collaborative development across teams
- Helps identify integration bugs
## Traditional development 
![[Pasted image 20240429113325.png]]

## Main CI features
- Short-lived branches
	- A playground for developers to create and test new features
	- Meant to be deleted after being merged
	- Benefits:
		- Reduces drift
		- Reduces parallel changes 
- Frequent pull requests
	- Created for a specific feature
	- Merged by maintainers/owners
	- Small pieces of a bigger puzzle 
	- Benefits:
		- Frequent feedback from increased collaboration
		- Faster reaction to changes 
		- Reduced management risk 
- Automated CI
	- Uses webhooks to trigger monitor events 
	- Ensures your code is doing what you want
	- Streamlines development
	- Tools:
		- GitHub actions
		- CircleCI
		- Jenkins CI
		- TravisCI

# Benefits of CI
## Faster code-change reaction time
1. You make a change to your code
2. Code gets tested
3. Change gets built 
4. Deliver solution quickly to customer's hand
## Reduced code integration risk
- Integrating smaller and smaller things
- No need to integrate100000 lines of code into your code-base
- Only need to integrate 10-50 lines of code
## Higher quality of code
1. Pull request = Code review opportunity
2. When someone makes a pull request, go and look at the code 
3. Pull request review:
	1. Looks good to me 
	2. Why are u changing this
## Code in version control works
1. How are you going to do CD?
	1. You're going to deploy from Git
2. How do you know that the code in Git works?
	1. Well, u ran CI tests
3. So it's important to know that everything in the Git master branch works 

# Social Coding 
## Source code management
- SCM tracks source code versions during development 
- Programmers use SCM tooks for this purpose
- These tools also known as VCS (Version control system)
- Can be Centralized or Distributed
## Centralized vs. distributed SCM 
- A centralized SCM stores code repo and version history centrally
- Dev check out pieces of code to work on and commit changes back to central repo 
- With dsitributed SCM, each developer has local clone of code repo and version history
- Developers can performm local builds 
## What is social coding
![[Pasted image 20240429122324.png]]
## Social coding steps in practice 
![[Pasted image 20240429122358.png]]
## Social coding principles
![[Pasted image 20240429122431.png]]

# Git Feature Branch Workflow: Working in Branches
## What is Git
- A distributed source code management(SCM)
- Code can be stored locally or kept in a remote repository
- Every developer has a full copy 
- Works locally w/o any server
- Works remotely w/ GitHub, GitLab, and BitBucket 
## Why Git for DevOps
- Has become the industry standard for version control
- Facilitates the DevOps methodology that is impactful to software development
- Open source software has blossomed because GitHub hosts open source projects for free
## Git workflow  
![[Pasted image 20240429165540.png]]

## Git Feature Branch workflow
![[Pasted image 20240429231741.png]]

## Example: Create feature branch
![[Pasted image 20240429231824.png]]
3 main point:
- Always start with the latest code from master
- Always create a new branch to work on
- Set up a remote branch and track it

![[Pasted image 20240429231955.png]]

# Git feature branch workflow: Making a Pull Request 
## Pull request workflow 
![[Pasted image 20240429232427.png]]

## Before a pull request 
![[Pasted image 20240429232511.png]]

## After a pull request
![[Pasted image 20240429232554.png]]

# Tools of CI
## Jenkins
![[Pasted image 20240430095134.png]]
## How Jenkins works 
![[Pasted image 20240430095311.png]]

## Jenkinsfile 
This Jenkinsfile help you run unit test on a python project 
![[Pasted image 20240430102308.png]]

## Circle CI
![[Pasted image 20240430102400.png]]
## How CircleCI works 
![[Pasted image 20240430102822.png]]
## circle.yaml
![[Pasted image 20240430102910.png]]

## Travis CI
 ![[Pasted image 20240430103010.png]]

## How Travis CI works 
![[Pasted image 20240430103110.png]]
## .travis.yml
![[Pasted image 20240430103152.png]]

## GitHub Actions
![[Pasted image 20240430103223.png]]

# Summary & Highlights: Understanding Continuous Integration (CI)

Congratulations! You have completed this lesson. At this point in the course, you know: 

- CI is an automation process that helps developers continuously integrate code by using short-lived branches. 
    
- CI involves frequent pull requests that are easy to review and encourage collaboration. 
    
- CI automatically runs code through predefined tests, streamlining development. 
    
- With CI/CD, you get the following: 
    
    - Faster reaction times to changes 
        
    - Reduced code integration risk 
        
    - Higher code quality 
        
- Confirmation that the code in version control works. 
    
- Social coding leads to high-quality code and increased collaboration, saving time, effort, and money. 
    
- Git enables DevOps and has many commands that provide essential functionality. 
    
- Developers use Git’s Feature Branch Workflow to develop clean, concise, high-quality code. 
    
- The Git Feature Branch Workflow involves five steps: 
    
    - Clone a repository to your local system and create a branch to work on your issue. 
        
    - Commit changes to that branch. 
        
    - Push your changes to the remote branch. 
        
    - Issue a pull request to have your work reviewed. 
        
    - Merge your code to the main branch and close the issue. 
        
- Standard CI tools include Jenkins, CircleCI, TravisCI, and GitHub Actions, and each has advantages and disadvantages. 
    
- You can write your CI pipelines as code for your CI tool to run. 
    
- Many CI tools are offered as services that you can easily run and scale on the cloud.
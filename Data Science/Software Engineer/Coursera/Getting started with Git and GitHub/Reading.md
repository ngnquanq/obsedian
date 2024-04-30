
# Reading: Git Commands

In this reading, you will summarize and describe additional Git commands that you may use while working on your projects. You will also look at the syntax for each command.

Git is a widely used version control system that offers numerous benefits to developers and teams working on software development projects.

Let's look at some useful Git commands and understand them:

1. **git add**
    
    - _Description_: It adds changes to the staging area. This command stages the changes made to the files and prepares them for the next commit.
        
    - _Syntax_:
        
        - **git add <filename.txt>** (to add a specific file)
        - **git add .** (to add all the files that are new or changed in the current directory)
        - **git add -A** (to add all changes in the entire working tree, from the root of the repository, regardless of where you are in the directory structure)
2. **git reset**
    
    - _Description_: It resets changes in the working directory. When used with –hard HEAD, this command discards all changes made to the working directory and staging area and resets the repository to the last commit (HEAD).
        
    - _Syntax_:
        
        - **git reset**
        - **git reset –hard HEAD**
3. **git branch**
    
    - _Description_: It lists, creates, or deletes branches in a repository. To delete the branch, first check out the branch using **git checkout** and then run the command to delete the branch locally.
        
    - _Syntax_:
        
        - **git branch** (to list branches)
        - **git branch <new-branch> (to create a new branch)
        - **git branch -d <branch-name>** (to delete a branch)

1. **git checkout main**
    
    - _Description_: It switches to the "main" branch. This will switch your current branch to "main."
        
    - _Syntax_: **git checkout main**
        
2. **git clone**
    
    - _Description_: It copies a repository from a remote source to your local machine. This will create a copy of the repository in your current working directory.
        
    - _Syntax_: **git clone <repository URL>**
        
3. **git pull**
    
    - _Description_: It fetches changes from a remote repository and merges them into your local branch. First, switch to the branch that you want to merge changes into by running the **git checkout** command. Then, run the **git pull** command, which will fetch the changes from the main branch of the origin remote repository and merge them into your current branch.
        
    - _Syntax_: **git pull origin main**
        
4. **git push**
    
    - _Description_: It uploads local repository content to a remote repository. Make sure you are on the branch that you want to push by running the **git checkout** command first, then push the branch to the remote repository.
        
    - _Syntax_: **git push origin <branch-name>**
        
5. **git version**
    
    - _Description_: It displays the current Git version installed on your system.
        
    - _Syntax_: **git version**
        
6. **git diff**
    
    - _Description_: It shows changes between commits, commit and working tree, etc. It also compares the branches.
        
    - _Syntax_:
        
        - **git diff** (shows the difference between the working directory and the last commit)
        - **git diff HEAD~1 HEAD** (shows the difference between the last and second-last commits)
        - **git diff <branch-1> <branch-2>** (compares the specified branches)
7. **git revert**
    
    - _Description_: It reverts a commit by applying a new commit. This will create a new commit that undoes the changes made by the last commit.
        
    - _Syntax_: **git revert HEAD**
        
8. **git config –global user.email <Your GitHub Email>**
    
    - _Description_: It sets a global email configuration for Git. This needs to be executed before doing a commit to authenticate the user's email ID.
        
    - _Syntax_: **git config –global user.email <Your GitHub Email>**
        
9. **git config –global user.name <Your GitHub Username>**
    
    - _Description_: It sets a global username configuration for Git. This needs to be executed before doing a commit to authenticate users' username.
        
    - _Syntax_: **git config –global user.name <Your GitHub Username>**
        
10. **git remote**
    
    - _Description_: It lists the names of all remote repositories associated with your local repository.
        
    - _Syntax_: **git remote**
        
11. **git remote -v**
    
    - _Description_: It lists all remote repositories that your local Git repository is connected to, along with the URLs associated with those remote repositories.
        
    - _Syntax_: **git remote -v**
        
12. **git remote add origin <URL>**
    
    - _Description_: It adds a remote repository named "origin" with the specified URL.
        
    - _Syntax_: **git remote add origin <URL>**
        
13. **git remote rename**
    
    - _Description_: The git remote rename command is followed by the name of the remote repository (origin) you want to rename and the new name (upstream) you want to give it. This will rename the "origin" remote repository to "upstream."
        
    - _Syntax_: **git remote rename origin upstream**
        
14. **git remote rm <name>**
    
    - _Description_: It removes a remote repository with the specified name.
        
    - _Syntax_: **git remote** _rm origin_
        
15. **git format-patch**
    
    - _Description_: It generates patches for email submission. These patches can be used for submitting changes via email or for sharing them with others.
        
    - _Syntax_: **git format-patch HEAD~3** (creates patches for the last three commits)
        
16. **git request-pull**
    
    - _Description_: It generates a summary of pending changes for an email request. It helps communicate the changes made in a branch or fork to the upstream repository maintainer.
        
    - _Syntax_: **git request-pull origin/main <myfork or branch_name>**
        
17. **git send-email**
    
    - _Description_: It sends a collection of patches as emails. It allows you to send multiple patch files to recipients via email. Please make sure to set the email address and name using the **git config** command so that the email client knows the sender's information when sending the emails.
        
    - _Syntax_: **git send-email *.patch**
        
18. **git am**
    
    - _Description_: It applies patches to the repository. It takes a patch file as input and applies the changes specified in the patch file to the repository.
        
    - _Syntax_: **git am <patchfile.patch>**
        
19. **git daemon**
    
    - _Description_: It exposes repositories via the Git:// protocol. The Git protocol is a lightweight protocol designed for efficient communication between Git clients and servers.
        
    - _Syntax_: **git daemon –base-path=/path/to/repositories**
        
20. **git instaweb**
    
    - _Description_: It instantly launches a web server to browse repositories. It provides a simplified way to view repository contents through a web interface without the need for configuring a full web server.
        
    - _Syntax_: **git instaweb –httpd=webrick**
21. **git rerere**
    
    - _Description_: It reuses recorded resolution of previously resolved merge conflicts. Please note that rerere.enabled configuration option needs to be set to "true" (**git config –global rerere.enabled true**) for git rerere to work. Additionally, note that git rerere only applies to conflicts that have been resolved using the same branch and commit.
        
    - _Syntax_: **git rerere**

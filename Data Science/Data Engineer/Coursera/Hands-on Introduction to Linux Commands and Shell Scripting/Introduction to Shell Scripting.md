# Shell Scripting Basics
## Definition
- List of cmd can be interpreted
- Commands can be entered interactively
- Scripting languages are interpreted at runtime
- Slower to run but faster to develop
## Usecase
- Widely used to automate processes
- Including:
	- ETL jobs
	- File backups and archiving
	- System administration tasks 
- Used for nearly any computational task 

## Shell scripts and the 'shebang'
- Shell scripts is an executable text file with an *interpreter directive* aka 'shebang' directive:

```cmd
#!interpreter [optional-arg]
```

- *interpreter* - path to an executable program
- *optional-arg* - single argument string 

## Example
1. Shell script directives:
```cmd 
#!/bin/sh
#!/bin/bash
```
1. Python script directive
```cmd
#!bin/bash/env python3
```
Create the shell script:
```cmd
touch hello_world.sh
echo '#!/bin/bash' >> hello_world.sh
echo 'echo hello world'>> hello_world.sh
```
Make it executable
```cmd
chmode +x hello_world.sh
```
Run your bash script
```cmd
./hello_world.sh
```

# A brief introduction to shell variables
https://www.coursera.org/learn/hands-on-introduction-to-linux-commands-and-shell-scripting/ungradedWidget/VxCx5/reading-a-brief-introduction-to-shell-variables

# Filters, Pipes, Variables 
## Pipes and filters
Filters are shell commands, which: 
- Take input from standard input
- Send output to standard output
- Transform input data into output data 
- Examples: `wc, cat, more, head, etc`
- Filters can be chained together 

About pipe, denote as follow: "`|`" - a vertical bar (pipe command) for chaining filter commands:
`command1 | command2`
The output of command 1 is input of command 2
And therefore, the "Pipe" stands for "pipeline"

## Shell variables
- The scope of shell variables is limited to shell (which mean it work for only the shell it was call out)
- `set` -  list all shell variables
## Defining shell variables
```cmd
var_name=value
```
Notice that there should be no spces arrount '='

`unset var_name`
The unset allows you to delete var_name

## Environment variables 
- Extended scope 
`export var_name`
Export something made it an environment variables 

- `env` - list all environment variables 

# Reading: Examples of Pipes
https://www.coursera.org/learn/hands-on-introduction-to-linux-commands-and-shell-scripting/ungradedWidget/RaPeL/reading-examples-of-pipes

# Useful features of the bash shell

## Metacharacters
![[Pasted image 20240426001016.png]]

## Quoting
![[Pasted image 20240426001120.png]]

## I/O redirection 
![[Pasted image 20240426001316.png]]

## I/O redirection examples
![[Pasted image 20240426001409.png]]

## Command Substitution 
![[Pasted image 20240426001446.png]]

## Command line arguments
![[Pasted image 20240426001522.png]]

## Batch versus concurrent modes 
![[Pasted image 20240426001559.png]]

# Reading: Examples of Bash Shell Features
https://www.coursera.org/learn/hands-on-introduction-to-linux-commands-and-shell-scripting/ungradedWidget/f5hVj/reading-examples-of-bash-shell-features

# Reading: Introduction to Advanced Bash Scripting
https://www.coursera.org/learn/hands-on-introduction-to-linux-commands-and-shell-scripting/ungradedWidget/QfnFG/reading-introduction-to-advanced-bash-scripting

# Scheduling jobs using Cron 
## Job scheduling 
- Schedule jobs to run automatically at certain times 
- i.e 
	- Load script at midnight and every night
	- Backup script to run every Sunday at 2AM
- Allows you to automate such tasks 

## Cron, Crond, and Crontob? 
- Cron is a service that runs jobs
- Cron interprets 'crontab files'
- Crontab contains jobs and schedule data
- Crontab enables to edit a Crontab file 

## Scheduling Cron jobs with Crontab
![[Pasted image 20240426081654.png]]

Running crontab with the "l" option returns a list of all cron jobs and their schedules

# Summary and Highlights
Congratulations! You have completed this module. At this point, you know that: 

- A shell script is a program that begins with a ‘shebang’ directive and is used to run commands and programs. Scripting languages are interpreted rather than compiled.
    
- Filters are shell commands. The pipe operator `|` allows you to chain filter commands. 
    
- Shell variables can be assigned values with `=` and listed using `set.` Environment variables are shell variables with extended scope, and you can list them with `env.`
    
- Metacharacters are special characters that have meaning to the shell.
    
- Quoting specifies whether the shell should interpret special characters as metacharacters or 'escape' them.
    
- Input/Output, or I/O redirection, refers to a set of features used for redirecting.
    
- You can use command substitution to replace a command with its output.
    
- Command line arguments provide a way to pass arguments to a shell script.
    
- In concurrent mode, multiple commands can run simultaneously.
    
- You can schedule cron jobs to run periodically at selected times. `m h dom mon dow command` is the cron job syntax.
    
- You can edit cron jobs by running `crontab -e,` and `crontab -l` lists all cron jobs in the cron table.

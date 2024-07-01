## What is an OS
A software to manage, communicate with hardware
## What is Unix
- Family of OS 
## What is Linux
- Family of Unix-like OSs
	- Usually specific distribution
- Originally developed as an effort to create a free, open-source Unix OS
## Linux Feature
- Free and open source
- Multi-user
- Multitasking 
- secure 
- Portable 
## Use cases today
Android, Supercomputer, data centers and cloud services, PCs


# Linux Distributions

## Definition
- A specific flavor of Linux OS
- Also known as Distro
- Linux Kernel is the core component
- Now there exists hundred of distros for different tasks
## Linux distro differencecs 
- System utilities
- Graphical user interface (GUI)
- Shell commands
- Support types:
	- Long-term support (LST) versus rolling release
	- Community vs enterprise
## Linux distros: Debian 
- Stable, reliable, fully open source
- Support many computer hardware
- Larges commnuity-run distro
## Linux distros: Ubuntu
- Debian-based
- Developedand managaed by Canonical
- Editions:
	- Ubuntu Desktop
	- Ubuntu Server
	- Ubunu Core
## Linux distros: Red Hat Linux 
- Stable, reliable, fully open source
- Manged by Red Hat
- RHEL 
## Linux distros: Fedora
- Same as above 
- Sponsored by Red hat
## Linux distros: SUSE Entprise
- 2 editions
	- Server (SLES)
	- Desktop(SLED)
- Supports many architectures
- SUSE package hub 
## Linux distros: Arch Linux
- Do-it-yourself approach
- Highly configurable
- Requires strong understanding of Linux and system tools 
- Leading-edge software

# Overview of Linux Architecture 
## Five layers of Linux 
![[Pasted image 20240425162646.png]]

## Linux filesystem 
![[Pasted image 20240425162929.png]]

`/bin`: binary file contain code machine read and run the program command
`/user`:  contain user program 
`/home`: contain user file 
`/boot`: contain user boot file 
`/media`: contain temporary media file 

There are more, but the above are keys 
![[Pasted image 20240425163130.png]]

# Linux Terminal Overview 
## Overview of Linux Shell
![[Pasted image 20240425163411.png]]
## Overview of Linux Terminal 

![[Pasted image 20240425163436.png]]

## Communicating with Linux system 
![[Pasted image 20240425163458.png]]

## Paths in the Linux filesystem
![[Pasted image 20240425163604.png]]

# Creating and Editing Text Files 

## Popular text editors
- Command-line text editors:
	- GNU nano:
		- Undo + redo
		- Search and replace
		- Syntax highlighting
		- Iddenting group of lines
		- Line number
		- Line-by-line scrolling
		- Multiple buffers
	- vim: traditional and very powerful command-line editor
		- to start vim, type vim
		- to specify a file to edit, type: `vim <filename>
		- ![[Pasted image 20240425164920.png]]
	- vi
- GUI-based text editors
	- gedit: general-purpose editor, easy to use with a clean, simple GUI
- Command-line or GUI
	- emacs

# Installing Software and Updates 
## Packages and packages managers
![[Pasted image 20240425165108.png]]
## Deb and RPM packages
![[Pasted image 20240425165140.png]]

![[Pasted image 20240425165212.png]]

## Package managers
![[Pasted image 20240425165233.png]]

## Updating deb-based Linux 

![[Pasted image 20240425165716.png]]

![[Pasted image 20240425165728.png]]

![[Pasted image 20240425165745.png]]

![[Pasted image 20240425165802.png]]

## Updating RPM-based Linux 
![[Pasted image 20240425170603.png]]
![[Pasted image 20240425170620.png]]
![[Pasted image 20240425170629.png]]

## Installing new software
![[Pasted image 20240425170644.png]]

# Summary & Highlights

Congratulations! You have completed this module. At this point, you know that:

- In the 1980s, GNU was developed at MIT. GNU stands for “GNU’s not Unix” and was made as a free, open source set of the existing Unix system tools. And in 1991, Linus Torvalds developed a free, open source version of the Unix kernel called Linux.
    
- Linux is widely used today in mobile devices, desktops, supercomputers, data centers, and cloud servers.
    
- Linux distributions (also known as distros) differ by their UIs, shell applications, and how the OS is supported and built.
    
- The design of a distro is catered toward its specific audience and/or use case. Popular Linux distributions include Red Hat Enterprise Linux (RHEL), Debian, Ubuntu, Suse (SLES, SLED, OpenSuse), Fedora, Mint, and Arch.
    
- The Linux system consists of five key layers: the UI, application, OS, kernel, and hardware. The user interface enables users to interact with applications. Applications enable users to perform tasks within the system. The operating system runs on top of the kernel and is vital for system health and stability, and the kernel is the lowest-level software that enables applications to interact with hardware. Hardware includes all the physical or electronic components of your PC.
    
- The Linux filesystem is a tree-like structure consisting of all directories and files on the system.
    
- A Linux shell is an OS-level application that you can use to enter commands. You use a terminal to send commands to the shell, and you can use the `cd` command to navigate around your Linux filesystem.
    
- You can use a variety of command-line or GUI-based text editors such as GNU nano, vim, vi, and gedit.
    
- .deb and .rpm are distinct file types used by package mangers in Linux operating systems.
    
- You can use GUI-based and command-line package managers to update and install software on Linux systems.

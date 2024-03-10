## Computer system operation

**Notice: Some basic knowledge of the structure of Computer System is required to understand how OS work**

A modern general-purpose computer system consists of one or more <mark style="background: #FFF3A3A6;">CPUs</mark> and a number of device controllers connected through a common bus that provides access to shared memory

![[Pasted image 20240310205404.png]]

A CPU (central processing unit) is a small chip that carrying all the computation and calculation (modern computer sys have one or more CPUs).

All of the components are connected by their controllers. And after that, all are **connected via a bus** (the horizontal line in the diagram), then that bus is connected to a memory.

We have a **memory controllor** that make sure that others controllers can tap into the shared memory that they need so that they can perform or work smoothly w/o problems.

**Whenever something has to be executed, it has to be loaded into main memory (limited resource) which is depend on RAM**

## Important terms

Here are some important terms:

![[Pasted image 20240310210417.png]]

- **Bootstrap program**: First program that get executed when powered up the computer.  
- **Kernel**: Main of the OS, Heart of the OS.
- **Interrupt:** Same for human, pure natural language, nothing mockering lol.
- **System call**: Unlike the interrupt caused by hardware, if a software is the one who make the call, then it's called System call.

## When CPU got an interrupted.

![[Pasted image 20240310211126.png]]

**Service Routine**: Something where the interrupt actually wants to do is written. 

# Storage Structure

![[Pasted image 20240310212847.png]]

The bigger the rectangular, the slower it take to access it. 

We **mainly focus on Main Memory**, it's where RAM located. Anything you loaded into your computer, loaded into main memory (small but fast). When we **have bigger RAM, have a faster computer.** With faster RAM, **you increase the speed at which memory transfers information to other components**.
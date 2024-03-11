![[Pasted image 20240311162230.png]]

Notice: 
- If a program is executed in user mode, then that program dont have the straight access to the memory. Therefore if a program is accessed via the kernel mode, then it's said to be executed in a privileged mode. 
- The problem is also appear from there, if some how, the program executed in kernal mode crash, the whole system would crash as well. The same thing does not appear when the program is used in the user mode. 
- Therefore user mode is a safer option. And likely, very much of the os use this user mode for executing the program. When the program in the User Mode need the resource, it perform a switch to the Kernel Mode, called "context switch", and after the program has been executed, the program is switched back to the User Mode, this process is also known as "context switch".

For example with copying task from one file to another

![[Pasted image 20240311162522.png]]


Everything will need a system call (typically).

So there're typically thousand of system calls happen in one second while we wanna execute some program.
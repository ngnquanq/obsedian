# Modern multi-processor, multi-core system
1 physical core = 1 logical core.
But with chips with multi threading, 1 physical core can have multiple logical core. 
1 logical core = 1 process (task)
## Example
In a house (a process), there is one person (a thread) doing one task synchronously (i.e cooking). 

It is like taking the ingredient ready and then do the next step.

A downside is that why must wait while we can do things else in the meantime?

Asynchronous appear to counter this, in the waiting time, let do something else ! 

![[28 - Introduction to Threads]]

**What is I/O task?**
It is task that do not require computation. 
Some example with I/O tasks is:
- Sending API
- Setting connection to somewhere, i.e Oracle DB
But how it works? Thanks to something called **context switching**
![[17 - Context Switch]]


**Why I bring in async I/O?**
It is very **beneficial to use async I/O for process with multiple I/O tasks**. 
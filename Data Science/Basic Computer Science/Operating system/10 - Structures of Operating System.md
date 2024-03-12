
# A simple structure

![[Pasted image 20240311170905.png]]

This is the structure followed by MS-DOS (old af).

Notice that this is not a layer structure, but it allow every components to have a direct access to the ROM BIOS device drivers (base hardware). Which make the system vulnerable to errant and malicious programs **causing the entire system to crash when the user program fails**.  

# The monolithic structure 

This structured is followed by the earlier UNIX os (which is a limited structure)

![[Pasted image 20240311171429.png]]

Notice how **everything was packed into one level (kernal)**. Make the implementation and maintainance very difficult and debug is also very hard.  

# The layered structure

Unlike the monolithic structure, here we have broken down the functionalities into different layers and separated them. Therefore it's more easier to debug and maintain them. Another big advantage is that the hardware is also protected by the layers above. 

![[Pasted image 20240311171728.png]]

Although it still have some disadvantage. E.g: 
- Difficulty in designning this layered structure. 
- Maybe not very efficient compared to other structure.

# Microkernels

![[Pasted image 20240311172216.png]]

Basic idea is that we remove all the non essential components from the kernal and then reimplement them as system and user level program.

And because every program got executed in the user mode, therefore the problem of having a system crash when executed in the kernal mode is not likely to happen (hope so).

The disadvantage is that it may suffer from performance decrease when having increase of system function overhead.

# Modules


![[Pasted image 20240311172759.png]]

Till this far, this might be the best approach in structuring OS, in which it involve using OOP techniques to create a module kernel. 

To be more specific, this approach take the best of two above structure (layer and microkernal).  Being more specific, With this structure, we dont have to access layer by layer like the layer structure, the module just have to access to other modules via the core kernel module. Also, unlike microkernel, each of the module is loaded when used, therefore not suffer from overhead 
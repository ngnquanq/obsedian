Types of computer systems based on number of general purpose processors:

![[Pasted image 20240311091641.png]]

# Single processor systems:

![[Pasted image 20240311091938.png]]

# Multiprocessor systems:

![[Pasted image 20240311092620.png]]

**Throughput** is what we can use to measure the performance of our system, for example is the amount of data that can be transferred from one location to another

Because different processors sharing the resources, i.e the resource for 1 single processor is 3 (with the unit but ignore it for now), then in other to do a specific task with 3 single processor, we'll take 9. In contrast, using a multiprocessor system, i.e 3 processors in a system, we'll only take 3. That's why we called it **economy of scale**.

**More reliable**: Even if a single processors fail, others will pack us up, nothing gone wrong, just share the job of the fail processor. 

## Types of multiprocessor systems

![[Pasted image 20240311092908.png]]

**Symmetric Multiprocessing:** Each processors are peers of each other, they're all join and performs all task, i.e CPU1, CPU2, CPU3 are together, join in to solve the P1, P2, P3.

**Asymmetric Multiprocessing:** A "Master - Slave" approach, one Master split out the task for each Slave, i.e the master will allocate the Slave 1 to solve P1, Slave 2 to solve P2, etc... If one slave die or what, the master will re-allocate the resource, split the task P1 for other slaves. 

# Clustered Systems:

![[Pasted image 20240311100019.png]]

Similar to multiprocessors system, the difference is that Clustered systems are typically constructed by combining multiple computers into a single system to perform a computational task distributed across the cluster. Multiprocessor systems on the other hand could be a single physical entity comprising of multiple CPUs.

Hot-Standby mode is like the master. The symmetrically approach for clustered systems is more better since it use resources in a a better way.
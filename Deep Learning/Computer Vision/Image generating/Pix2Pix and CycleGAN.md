## Review

### Head first:
Need a solid knowledge in GAN and DCGAN (please review this first)
### DCGAN: 
- Same as GAN.
- GAN is hard to train, DCGAN made GAN easier to train. 
- In DCGAN, the image used to train is with the shape (3, 64, 64).
- A different approach for picking data to train with noise vector.
- Adapt something called *__emergent__*
## Conditional GAN (cGAN)
### Motivation
User want to have a **specific** picture, not just some random thing like GAN and DCGAN. 

### High-level understanding
Adding context to the random vector. 
Conditional Probability. 

![[Pasted image 20240322203919.png]]

The ***Signal*** is the condition in this case. 

Signal in this case can also be viewed as an encoding vector (we get this from the `nn.Embedding`)

The cross section of the **signal** and the **random** is basically the `torch.cat`. This allow the model to know where the to look at (since the search space become smaller). 


## Pix2Pix


## Readmore
- StyleGAN

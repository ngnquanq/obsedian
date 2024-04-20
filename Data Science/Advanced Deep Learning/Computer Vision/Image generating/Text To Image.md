## Prerequisite

- DCGAN - [[GAN and DCGAN]]
- BERT

## Milestones

![[Pasted image 20240328105833.png]]


## Text to Image Synthesis using DCGAN
- Adjust the DCGAN model by adding a prompt as a condition to generate image. 
- The texts will be processed using Text Embedding.
- The text ideally should be: 
	- Short
	- Focus on specific object
	- Concrete
### Approach
- For processing text:
	- First: We need an embedding to **convert a text (sentence) to a vector**. Because the GAN generator work well with noise vector. 
	- Second: For the new noise vector, we will perform concat between the random noise (z) and the Text Embedding. 
	- Third: We also represent text ebedding into the discriminator, especially at the final conv layer and add a new CNN block. 

### Discriminator Loss
The Discriminator loss of this kind of model also involve many things else:
$$
L_D(\mathbf{Z},\mathbf{e}) = 
$$
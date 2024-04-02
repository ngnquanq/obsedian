## Overview
In order to increase data, we could perform data augmentation or use transfer learning when the data at hand is strict.  

**GOAL:** Generate data
## MNIST
**GOAL:** Generate MNIST data
**Discussing:**
- **Output**: For generating data in the MNIST dataset which is an image with the shape 28\*28 , the `output_shape = (1,1,28,28)` assuming we're setting the batch size equal to 1. 
- **Input:** 
	- For discussing, a mapping from many-to-many is easier than one-to-many, therefor the right approach is mapping from a vector to a 2D image (many-to-many), it's a better way to approach when compare with mapping from a number to a 2D image (one-to-many).  
	- With input as noise vector (also mean that we could have multiples context, leading to multiples image that we cangenerate from.).
- **Loss function**: 
	- Any distance metric can be applied for GAN, but **GAN doesn't use MSE as it loss function, rather it use KL-Div**. The reason is that when using MSE, the optimization's trying to minimize the loss of all samples, in which **using MSE might lead to overfit to a specific image**. 
	- We will use **a network as a loss function**. More clearly, we have **data $G$ from the Generator and data $R$ from the real data**. Then we have a **network to do binary classification network (named Discriminator)**. We'll denote:
		- Real data: y = 1
		- Fake data: y = 0
	- The objective is that when **$G$ is simlar with $R$ then the y value from the Discriminator will equal 1 (y=1).** But a good Discriminator is a model that can specify whether the image is real or not. With the pov above, the training process must be a 2 step training process. <mark style="background: #FF5582A6;"> A good Generator is a model can fool the Discriminator (the image is fake but the Discriminator can't detect).  </mark> 
	- There's no specific metric in GAN for having the right epoch to stop. 

# GAN
## Loss function
### Generator Loss

The goal of the Generator is to **fool the Discriminator**.

When we care about the Generator Loss, we **fix the Discriminator**. 

Because the goal of the Generator is to fool the Discriminator, therefore when:
- y of the Discriminator -> 1: loss is small
- y of the Discriminator -> 0: loss is large

The loss of the Generator can be viewed as follow:
$$
L_G(\mathbf{z}) = -log(D(G(\mathbf{z})))
$$

This loss can measure the "goodness" of the Generator.

We want the training process will make y produced by Discriminator with the fake image to be as close to 1 as possibile.

```python
criterion = nn.BCELoss()
real_labels = torch.ones(imgs.shape[0],1)

z = torch.randn((imgs.shape[0], latent_dim))
gen_imgs = generator(z)
G_loss = criterion(discriminator(gen_imgs), real_labels)
```
The reason in the G_loss is is that we want to pull the result such that the **Generator leaned in a way that it can fool the Discriminator**.

### Discriminator Loss

After having the $G$ fixed, we need to improve the $D$. The loss function for the Discriminator is:
$$
L_D(\mathbf{z,x}) = -ylog(D(\mathbf{x})) - (1-y)log(1-D(G(\mathbf{z})))
$$
In the loss function above:
- $-ylog(D(\mathbf{x}))$: is to validate the Real Data $\mathbf{X}$
- $(1-y)log(1-D(G(\mathbf{z})))$: is to validate the Generated Data $G(\mathbf{Z})$


```python
criterion = nn.BCELoss()
real_labels = torch.ones(imgs.shape[0], 1)
fake_labels = torch.zeros(imgs.shape[0], 1)

z = torch.randn((imgs.shape[0], latent_dim))
gen_imgs = generator(z)
real_loss = criterion(discriminator(real_imgs), real_labels)
fake_loss = criterion(discriminator(gen_imgs.detach()), fake_labels)
D_loss = (real_loss + fake_loss)/2 # Divide by 2 is optional
```

## Model so far

![[Pasted image 20240327144108.png]]

Remember that **this is a 2-stage training process**.

### Cons:
mode collapse.

# DCGAN

<mark style="background: #FF5582A6;">TLDR: Instead of MLP, DCGAN use CNN</mark>




# Introduction
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
	- We will use **a network as a loss function**. time: 1.10.38
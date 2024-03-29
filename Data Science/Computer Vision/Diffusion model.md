# Recall
- Gaussian Distribution (for single and multivariate rv)
# Objective
- Understand a Diffusion model
- Understand a Forward Diffusion Process
- Understand a Reverse Diffusion Process
- Be able to implement a Diffusion Model Using PyTorch

Paper to read: Deep Unsupervised Learning Nonequilibrium Thermodynamics

# Application of Diffusion Model

- Text Inversion
- Text to Videos
- Text to 3D
- Text to motion
- Image to Image
- Image Inpainting

# AutoEncoder, VAE, GAN: Limitations

**Main idea:** Illustration of a generative model based on noise input.

These models only inference 1 step (single stage) to create output

**Not the case in diffusion models**: Because the model can refined each step each step to produce a better output image


These 3 models have the same method is "single step".

We need a method to adjust this.

# Why diffusion model?
- Wouldnt need to generate image in 1 forward
- Iterativly improve the image
- Find and correct these mistakes

# Main idea of author

From an image which is none-random distribution, we will add noise until the new image follow a distribution (i.e Gaussian Distribution)

# Forward diffusion process
- Image is none-random distribution (an image must follow some distribution - i.e component in a picture must correlated in some sense, not random pixel). 
- 
**Key word:** Style Transfer

**Take away:** Can apply for any type of data

**Final architecture:** ![[Pasted image 20240314133654.png]]

# Local and Global Similarity

## Local similarity
I.e giving 2 person, for seeing the similarity between 2 person in a picture, we should able to see **local similarity**. 

## Inside a network
For having more local similarity, the earlier layer in a CNN capture more global features.

As contrast, the later layers in a CNN capture more global features.

For more meaningful feature, should use pretrained model, i.e VGG19 -> But only those ealier layers and few later layers.

# Objective function

Using some distance metrics loss.
- L2 and L1 loss
- Maybe:
	- Cosine similarity
	- Kullback-Leibler

## Content loss

Mostly use L2

The use of this loss is to copy the content and paste it into the ouput (noise picture). 


## Style Loss

**TLDR: Copy an interest.** 

Gram matrix comes to play.

Objective, although img_1 and img_2 are two diffrents things, but because it have the same component (value  of a pixel in the image). Therefore the gram matrix produce the same value, that's how the style loss work. **That's how it capture the interest of a image**.

The Gram matrix itself isn't important, but it's still there **as a pointer, as a guider**. With that being said, other image, will try to **adapt so that those have the same Gram matrix as the style image**. 

Dont forget that we just want the same pixel value, or almost the same, as a way to say that fuck the position.

$$
||\mathbf{G(F_{1)}- G(F_2)||}^2
$$
This is how we construct the style loss of the NST algorithm, instead of normal L2 or L1 norm in the content loss.

**Again: Why do we need Gram matrix?**
**Because:** It solve our desire. Also we cannot use the direct style image for the gram matrix. The core of Gram matrix is **it do something with itself.** 



# Experiment
Pre-requisite:
1. Data
	1. Content image
	2. Style image
	3. Noise image (same size as content image)


During:
- Only a first few layer already yield fine result, no need to further train
- Using a random network (i.e via He init), the objective still workwell, no need some big deal like pretrain model with VGG or stuffs. Because the same transformation is fixed for both images, also the objective function will still the same.  
- 
# Question and research experiment. 

- What will happen if we use other metrics? Let say Frobenius matrix distance.
- What will happen if we use the feature map of later layers of the style image as filter for the content image to slide upon?
- How about trying with different type? i.e with text, like writing style?

# Multimodalities style transfer data

## Objective:
- We're **already have good models** to extract features from both text and image.
- That propose a new question, a hardly answered one: **How to align the **

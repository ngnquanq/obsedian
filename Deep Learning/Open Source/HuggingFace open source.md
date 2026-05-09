
> A platform for multiple models for different tasks

# Selecting model

Open platform that hosts model

How to find a model suit for our project? 

1. Pick the task first 
2. Pick the sub-task
3. Pick by licenses and downloads 
4. Read the Model Card, checkpoint. Technically speaking, we dont load model, we load the model checkpoint 
5. Read File and Version (read the pytorch_model.bin to know the weight of the model and take that number, multiply by 1.2 to know how much memory that you use to run that model). 

In order to load the model from Hub, we can use the transformer library: `use in Transformer`. With the `pipeline`, we dont need all the preprocess task at hand

# Natural Language Processing 

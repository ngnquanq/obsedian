# Theory 

# QnA
1. How do you evaluate the quality of open source alignment datasets
=> Vibe testing: look at the data by yourself. Another way is to using GPT4 to judge the quality of the response in the dataset (it still stupid in math and logical stuffs). 

1. How much data is ideal for this process (the alignment)?
=> In practice, in multi-stage process: SFT and DPO, 10k - 100k is good enough (split for both process)

# Training and Aligning a Chatbot

![[Pasted image 20240419155747.png]]

# Annotated SFT and DPO

# Supervised Fine-Tuning (SFT)
Include 3 main steps:
1. Load a dataset
2. Apply **chat template** (HuggingFace recommend using ChatML template)
3. Perform SFT

# Direct Preference Optimization (DPO)
Still include 3 main steps:
1. Load a dataset (use the dataset for DPO)
2. Apply **chat template** (HuggingFace recommend using ChatML template)
3. Perform SFT

# DPO Training tips 

![[Pasted image 20240419161006.png]]

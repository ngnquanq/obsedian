# Objectives
1. How LLMs learn (training type)?
2. How to make LLMs adapt to a task? 
	1. Prompting (In-context learning)
	2. Instruction Tuning
3. How to train LLMs on a single (small) GPU ?
4. Apply Intruction Tuning for multiple choice math question solver task. 
# Introduction 

Chatbot can help users with many task. 

Textual Description (Prompt)
## What are LLMs?
1. LLMs are language model being trained on a very large corpus (almost every information appears on internet), also these corpus are not specific on a domain, it cover everything like economics, history, politic, etc. 
2. An LLMs which being trained on a wide variety of tasks are also called Foundation models 
3. Input of the LLMs is a text (prompt), which often a command. Output is the text only (in case of this exercises)
4. LLM is a generative AI. We may have different output although given the same input 
## Generative AI Prompting 

![[Pasted image 20240415091958.png]]

Prompting is also a research field. 

## Prompting in LLMs

![[Pasted image 20240415092221.png]]

On the left is the prompting. 

LLMs can perform such task is because it have the ability called zero-shot capability (doing differents task just for changing the input).

LLMs will very bad in computing stuffs. 

=> How can LLMs performance improve on a specific task? 
We will focus in (1) and (2):
1. In-context learning
2. Fine-tuning
3. Augmenting 
### In-context learning 

![[Pasted image 20240415092632.png]]
In this format, we just adjust the prompt, not the model weight 

For example: we want to change the date-time format  

![[Pasted image 20240415092845.png]]

The result may appear right, sometime wrong, but with instruction, it will do better 

There're many ways to perform in-context learning (prompting):
1. Zero/one/few-shot learning
2. Chain-of-Thought
3. etc ... 
#### Zero-shot learning

Given the task, let the LLMs do the job.
![[Pasted image 20240415093209.png]]

#### One-shot learning

Give it an right example and let the LLMs do the task 
![[Pasted image 20240415094111.png]]

#### Few-shot learning
An upgrade version of One-shot learning
![[Pasted image 20240415094202.png]]Instead of 1, we can give the model multiple example, thus hoping it to do better. 

Realiety, given 2-3 example is enough (given too many tokens, the model's performance will be restricted).

LLMs when small is 1B-7B params but also have a large context-length 

#### Chain-of-Thought prompting (CoT)

![[Pasted image 20240415094525.png]]
Can be viewed as an update version of all those above because we force the LLM to reason the reason why it given the output. 

We often combine CoT with zero-shot, one-shot, few-shot learning. 

![[Pasted image 20240415094705.png]]

**In-context learning is a suddenly result (showed in GPT3)**. The problem for this to success is that:
- Model size is large
- Multi-domain data (corpus)

Chain-of-Thought prompting (CoT) have many variations
![[Pasted image 20240415095813.png]]

### Instruction-Tuning

In machine learning, basically, we have 3 types of training model: 
![[Pasted image 20240415095904.png]]

When talking about Fine-Tuning for ML, we also have Instruction Fine Tuning for LLMs
![[Pasted image 20240415100352.png]]

It helps LLMs to improve the ability to do some specifies task 
![[Pasted image 20240415100449.png]]

In instruction finetuning, we will started with the pretrained weight model, but now, we will have a task which specific the model to solve instruction, right now, it became a supervise learning task.

#### Application
- Prepared pretrain LLMs and instruction data for some task 
- Fine-tuning on that task
- Therefore only inference on task A 

#### Use cases: 
![[Pasted image 20240415101530.png]]

we will build the model with the capability to choose the rightest solution. 

![[Pasted image 20240415101929.png]]

we will need a template to allow the data to instruct.

### Parameter Efficient Fine-Tuning (PEFT)
Most people (student) use colab for fine-tuning but finetuning a LLM model is not an appropriate way, therefore we should perform something called parameter efficient fine-tuning. 

![[Pasted image 20240415103428.png]]

There're 3 types of PEFT (3 approachs)

![[Pasted image 20240415103635.png]]
1. Addition: We adding a new layer and let the update perform on that new layer
2. Specification: We specify a layer, and let the model to update only on that allowing layer
3. Reparameterization: We fix the layers, but we somehow change the weight (reconfirm)

#### LoRA: Low Rank Adaptation

![[Pasted image 20240415103852.png]]

By using LoRA, we just have only finetune on the 2 matrices, which not effect the pre-trained weight. 

Also, by using LoRA, for different tasks, we'll just have to switch the weight of those 2 matrices. 

#### QLoRA

![[Pasted image 20240415224317.png]]

## LLM Metrics

![[Pasted image 20240415225918.png]]

### BLEU score
> How many words from the candidate appear in the reference? 

Although, BLEU score is specify as a metric for translation task, but somehow it seems stupid.

Cons:
- Dont consider semantic meaning
- Dont consider structure of the sentence 

### ROUGE score

### Other metrics 

![[Pasted image 20240415230504.png]]

Instead of finding an algorithm to judge the output, we could use the benchmark to evaluate it. 

Therefore for LLMs, people will use benchmark, instead of scoring like before
# Agenda
1. Introduction 
2. Building production grade RAGs with Canopy/Pinecone
3. Evaluating and iterating with TruLens/Truera
Learning outcome: Addressing challenges to build production grade RAGs  

# Introduction 
1. LLMs are Limited to their Training Data: We want our LLMs to understand/know Fresh web data (new data) and able to access proprietary data (of our institution)
=> Solution: We want to connect to both of thems 

By using **RAG**

![[Pasted image 20240419124700.png]]

Building a Demo for RAG system is easy, the main problem appear in the production environment 

![[Pasted image 20240419125310.png]]

**Hallucination** is the most common one that people care about. 
**Context Overflow** talking about the limit of the input, doing search might require lots of tokens. 
**Other stuffs too**. 

## Canopy
- An open source framework for production level (very solid framework)
- Canopy has the following: 

![[Pasted image 20240419125818.png]]

Very excel when come to scale 

Can be run as a service 

config.yaml

## Evaluating RAG is hard 

![[Pasted image 20240419130131.png]]

Compare with multiple choice problem versus an essay problem, RAG is much more harder. 


# Building production grade RAGs with Canopy/Pinecone 

Check notebook 

# Evaluating a RAG application 

Key pillars for a RAG application evaluation framework is that: 
- Evaluation are comprehensive 
- Extensible 
- Easy to add more stuffs and more 

![[Pasted image 20240419131741.png]]


## Evaluating RAGs for Hallucinations 

By using RAG triad, producing a fairly evalution on RAG for hallucinations problem

![[Pasted image 20240419132108.png]]



## Some retrieval failure 

![[Pasted image 20240419132249.png]]

The first true is actually correct, but the next two aren't. By using TruEra RAG Triad, we can prevent this, since the retrieval document violate the context relevance in the RAG Triad. 

## Lack of Groundedness

![[Pasted image 20240419132735.png]]

When in production, if the answer is well-grounded, we can allow the LLM to let it through, or else we can block it, and say: "We're not enough information to answer this question". **Setting gaurdrail is IMPORTANT**. 

## Track Experiments to Select the Best App Configuration 

![[Pasted image 20240419132927.png]]


# Evaluation metrics

For some example, in the video, we try two different method: 

## Canopy default method
For the evalution metrics
1. Context Relevance: 0.77 (Medium)
2. Groundedness: 0.53 (Low)
3. Answer Relevance: 0.97 (High)

## Reranking method 
For the evalution metrics
1. Context Relevance: 0.86 (High)
2. Groundedness: 0.83 (High)
3. Answer Relevance: 0.9 (High)

# Key takeaways
- Building production grade RAG apps is significantly easier with Canopy
- TruLens and TruEra provide observability required for production

# QnA

1. Which models are better for RAG solutions? (Instruct or Conversational?) And do small models like TinyLlama or are useful in RAG implementations? 
=> Depends on your application, whether it fall into. 
=> Can use any models. Small model have both downside and upside (small model can be good with good and more data)

1. Do we need to future proof out vector dimensionality? As new models will be released, do we need to upgrade it too? 
=> Short: yes
=> Long: changing model or changing the size of the vector also meaning reindexing, reembedding, since it will be considered as new data 

1. How to fix LLM inconsistency in production app? 
=> Ideally, if we care about answer being consistent, then set the temperature close to zero, having gaurdrail be a part of the application is a good thing to use. 

# Resources
https://github.com/truera/trulens/blob/main/trulens_eval/examples/expositional/frameworks/canopy/canopy_quickstart.ipynb
https://www.youtube.com/watch?v=fo0F-DAum7E
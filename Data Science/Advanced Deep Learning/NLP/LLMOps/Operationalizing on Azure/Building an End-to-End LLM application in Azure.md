**Learning objectives**:
- Deploy an **end-to-end LLM application** leveraging **RAG**, **Azure**, and **GitHub Actions.**
- Build GitHub Actions workflows to automate testing and deployment of LLM apps.
- Use Azure AI Search to create search indexes and embeddings to power RAG.
- Understand architectural patterns like RAG for building LLM applications.
# Architecture of an LLM application
## Architectural overview 
1. User input query.
2. Then the query go through the framework.
3. Then the query will go through the vector database to perform a search.
4. Then it go back to the framework to produce the context (now, the context has both the vector query and the vector database).
5. That extra context will go through the machine learning model. 
6. Then send it back to the framework and back to the user.
![[Pasted image 20240701101938.png]]
## Overview of Azure AI Search
Link: https://learn.microsoft.com/en-us/azure/search/search-what-is-azure-search
## Automation and deployment with GitHub
1. Create a folder called `.github/workflows/main.yaml`
2. Setting environment and stuffs
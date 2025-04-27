# Key Terms

- **API-based application**: An application that interacts with other software components using Application Programming Interfaces (APIs) for data exchange, communication, or functionality enhancement.

- **Embedded model**: A machine learning model integrated within an application, allowing the app to perform specific tasks without relying on external services.

- **Multi-model application**: An AI system that utilizes multiple models tailored to different functions or domains, improving efficiency and performance in various scenarios.

- **HTTP API**: An interface for exchanging data between systems using Hypertext Transfer Protocol (HTTP) requests and responses over the internet.

- **Azure OpenAI**: A cloud-based platform by Microsoft that offers access to large language models through an easy-to-use API, enabling developers to build AI applications with advanced text generation capabilities.

- **Separation of concerns**: A design principle that suggests dividing complex systems into smaller, independent components responsible for specific functions, improving maintainability and scalability.

- **Scale/Scalability**: The ability of an application or system to handle increasing workloads efficiently by adding resources (e.g., computing power, storage) without significantly impacting performance or functionality.

# Common types of Generative AI Applications
- Chatting (most commonly used + mentioned).
- In the past, the chatbot had been very clunky.
- Generate imagery, create video as well. 
- Seeing convergence of GenerativeAI in daily task
# Overview of an API-based application 
- With `.env` file, you can set plenty of things. 
- Which mean the **LLMs does not live in the repo**, rather, it live in a cloud, which provided via an endpoint.
- Everything will be connected remotely. 
- This is the typical API-based application, send something to the server, it sends something back. 
- Based on scenario, where you can choose to host the LLMs locally (which mean inside your repository), or you can just connect like the above saying. 
# Overview of an embedded-model application
- The LLMs lie within the application
- Now the model will in the application, being on the machine where it was installed
# What is a multi-model application
**TLDR:** based on the prompt, the framework decide what ML model to solve the problem (kinda like agent ngl)

Kindof a trade of, a person know wide dont know deep
![[Pasted image 20240514084600 1.png]]

Idea: trying to combine human resource management with deep learning model (LLMs in this case)
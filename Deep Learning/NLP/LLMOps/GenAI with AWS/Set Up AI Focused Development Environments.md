## Key Terms
- **Code Catalyst**: Cloud-based development environment for building serverless pipelines and applications
- **SageMaker Studio**: Integrated IDE for machine learning development with access to GPU compute
- **Lightsail**: Virtual machines for research with flexible access to GPUs
- **MLOps**: Applying DevOps principles like CI/CD to machine learning model development and deployment
- **Rust Bindings**: Libraries to interface Rust code with other frameworks like PyTorch
- **Hugging Face Candle**: Rust library to run and deploy large language models
- **Lorax**: Tool for running large batch AI workloads across cloud providers
## Development Environments for AI
![[Pasted image 20240512121545.png]]

## MLOps Challenges and Opportunities in Rust and Python
### What is it and why do we need it?
- Rule of 25% (DevOps + Data + Models + Business)
- No silver bullet
- No DevOps => No MLOps
- Solutions is not experiments
- Notebooks aren't production software
### Limitations of Python
- Lack of binary deployment 
- Poor performance at scale
- Concurrency bottlenecks
- Virtual environment productivity tax
- Modern Security, Security
- Packaging 
### Benefits of Rust for MLOPs
- Binary deploymeny
- Performance
- Safe concurrency without bottlenecks
- Security
- Greate for MLOps LLMOps, Data Engineering Libaries
#### Key concepts of RUST
![[Pasted image 20240512122531.png]]
 > "A Trampoline for your code" - Why not try a backflip

### Rust: Eating your veggies
- Syntax is harder than Python
- Rust Compiler is mean to you
- Lean on Cargo ecosystem
- Lean on Generative AI Tools (AWS Code Whisperer)

## Generative AI workflow for Rust
 ![[Pasted image 20240512122818.png]]
![[Pasted image 20240512123200.png]]
## Python for Data Science in the era of rust and genAI
Pros (best in hosted notebooks)
- Data Science libs
- Prototyping
- API document
- Teaching
- Deep Learning libs
Cons
![[Pasted image 20240512124518.png]]
Got exponential improvement at the start 
=> Hard to go beyond that
### When is the peak? 
> What does less python and jupyter look like? 
> Mixing Python and Rust

![[Pasted image 20240512124658.png]]

Rust tools for Python also leed to 10-100x faster when just using pure python

## Emerging Rust LLMOps workflows
### Key libraries: Rust LLMOps/MLOps/Data Engineering
- Rust PyTorch Bindings
- HuggingFace Candle
- Polar (high performance df ops)
- Actix
- Cargo Lambda (binary based deploy)
- Clap
- Lorax (AI workload in the cloud)

![[Pasted image 20240512135515.png]]

![[Pasted image 20240512140004.png]]

Cloud provider has many good feature, GPU, Copilot, stuffs

Rust work well on CLoud too

![[Pasted image 20240512140101.png]]
## Getting Started with Code Catalyst for Rust
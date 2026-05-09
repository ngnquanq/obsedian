# Data Platform, Data Stores, and Security 
## Architecting the Data Platform 
The total architecture: 
![[Pasted image 20240501101039.png]]
### Data Ingestion/Collection layer
![[Pasted image 20240501101147.png]]
Tools for Data Ingestion:
- Data Flow
- IBM Streams
- IBM Streaming Analytics on Cloud
- Amazon kinesis
- Apache Kafka
### Data Storage and Integration Layer
![[Pasted image 20240501101306.png]]
Some of the popular relational databases:
- Db2 (IBM)
- SQL Server (Microsoft)
- MySQL
- Oracle database
- PostgreSQL
Some of DaaS:
- Amazon RDS
- Google cloud SQL
- SQL Azure
Some of NoSQL:
- Cloudant
- Redis
- MongoDB
- Cassandra
- Neo4J
Integration Tools:
- IBM's cloud Pak for Data
- IBM's cloud Pak for Integration
- talend 
- OpenStudio
Open-source integration tools
- Boomi
- snapLogic
Platform as a Service(iPaaS)
- Adeptia Integration Suite
- Google Cloud's Cooperation
- IBM's Application Integration Suite on Cloud
- Informatica's Integration Cloud 
### Data Processing Layer
![[Pasted image 20240501101708.png]]
Some of the transformation tasks: 
- Structuring: action that change the form and schema of the data
- Normalization: cleaning the database of unused data and reducing redundancy and inconsistency 
- Denormalization: combining data from multiple tables into a single table so that it can be queried more efficiently 
- Data Clearning: fixing irregularitties in data to provide credible data for downstream applications and uses 
**NOTICE:**
![[Pasted image 20240501102012.png]]
And also, data processing layer can also precede the Data Storage layer, where transformations are applied before the data is loaded, or stored, in the database. 
### Analysis and User Interface Layer
![[Pasted image 20240501102133.png]]
Need to support Querying tools and programming languages.
API that can be used to run report on data for both online and offline processing
API that can consume data from the storage in real-time for use in other applications and services 
Dashboarding and Business Intelligence applications
### Data pipeline layer
![[Pasted image 20240501102353.png]]
Tools: 
- Apache Airflow
- Data Flow

## Factors for selecting and designing data stores
A data store, or data repository, refers to data that has been collected, organized, and isolated so that it can be:
- Used for business operations
- Mined for reporting and DA
A repository can be:
- A database
- A datawarehouse
- A data mart
- Big data store
- A data lake
Primary considerations for designing a data store
- Type of data
- Volume of data
- Intended use of data
- Storage considerations
- Privacy, security, and governance needs of your organization
### Type of data 
![[Pasted image 20240501115624.png]]
![[Pasted image 20240501115643.png]]
![[Pasted image 20240501115731.png]]
### Volume of Data
![[Pasted image 20240501115844.png]]
### Intended use of Data
![[Pasted image 20240501115927.png]]
![[Pasted image 20240501120014.png]]
![[Pasted image 20240501120100.png]]
### Storage Considerations
![[Pasted image 20240501121102.png]]
![[Pasted image 20240501121118.png]]
![[Pasted image 20240501121129.png]]
![[Pasted image 20240501121136.png]]
### Privacy, Security and Governance
![[Pasted image 20240501121210.png]]
![[Pasted image 20240501121237.png]]
## Security 
### The CIA Triad
![[Pasted image 20240501123955.png]]
![[Pasted image 20240501124009.png]]
### Physical Infrastructure Security 
![[Pasted image 20240501124100.png]]
### Network Security
![[Pasted image 20240501124323.png]]
### Application Security 
![[Pasted image 20240501124409.png]]
### Data Security 
![[Pasted image 20240501124450.png]]
![[Pasted image 20240501124538.png]]
### Monitoring and Intelligence
![[Pasted image 20240501124625.png]]
# Summary and Highlights

In this lesson, you have learned:

The architecture of a data platform can be seen as a set of layers, or functional components, each one performing a set of specific tasks. These layers include:

- Data Ingestion or Data Collection Layer, responsible for bringing data from source systems into the data platform.
    
- Data Storage and Integration Layer, responsible for storing and merging extracted data.
    
- Data Processing Layer, responsible for validating, transforming, and applying business rules to data.
    
- Analysis and User Interface Layer, responsible for delivering processed data to data consumers.
    
- Data Pipeline Layer, responsible for implementing and maintaining a continuously flowing data pipeline.
    

A well-designed data repository is essential for building a system that is scalable and capable of performing during high workloads. The choice or design of a data store is influenced by the type and volume of data that needs to be stored, the intended use of data, and storage considerations. The privacy, security, and governance needs of your organization also influence this choice. The CIA, or Confidentiality, Integrity, and Availability triad are three key components of an effective strategy for information security. The CIA triad is applicable to all facets of security, be it infrastructure, network, application, or data security.
# Data Collection and Data Wrangling 
## How to Gather and Import Data
### Using queries to extract data from (No)SQL databases
![[Pasted image 20240501130138.png]]
![[Pasted image 20240501130207.png]]
### APIs 
![[Pasted image 20240501130235.png]]
### Web Scrapping
![[Pasted image 20240501130306.png]]
### Sensor data
![[Pasted image 20240501130332.png]]
### Data exchanges 
![[Pasted image 20240501130358.png]]
![[Pasted image 20240501130419.png]]
### Other sources 
![[Pasted image 20240501130450.png]]
### Importing data 
![[Pasted image 20240501130517.png]]
### Data types and destination repositories 
![[Pasted image 20240501130557.png]]
![[Pasted image 20240501130618.png]]
![[Pasted image 20240501130706.png]]
![[Pasted image 20240501130720.png]]

## Data Wrangling 
### Introduction 
![[Pasted image 20240619230204.png]]
### Transformation
- Includes actions that change the form and schema of your data.
- In multiple ways depends.
- Include normalizing and denormalizing data
- Cleaning to fix irregularities 
### Inspection
- Includes:
	- Detecting issues and errors
	- Validating against rules and constraints
	- Profiling data to inspect source data 
	- Visualizing using statistical method: plot outlier
### Cleaning
- Depends on use case 
- I.E: 
	- Missing values can cause unexpected or biased results
		- Filter out records with missing data 
		- Source missing information
		- Impute missing value
	- Duplicate data: need to be removed
	- Irrelevant data: drop is needed. 
	- Data type conversion: ensure that values in a field are stored as the data type of that field. 
	- Standardizing data
	- Syntax errors 
	- Outlier
## Tools for Data Wrangling 
Including:
- Excel Power Query/ Spreadsheets
- Open Refine
- Google DataPrep
- Watson Studio Refinery
- Python
- R

# Querying Data, Performance Tuning and Troubleshooting 
## Querying and analyzing data 
### Introduction
- Counting and Aggregating
- Identifying extreme values
- Slicing data
- Sorting data
- Filtering patterns
- Grouping data 
`count`: Counting the number of rows of data, or records, in the dataset. 
`aggregation`: provide overview of the dataset from different perspective. 
`extreme value identification`: identify extreme values in a data column.
`slicing data`: finding customers based on a specific condition or set of conditions.
`sorting data`: arrange data in meaningful order, making it easier to understand and analyze. 
`filtering patterns`: perform partial matches of data values. 
`grouping data`: grouping data based on a commonality 
## Performance Tuning and Troubleshooting
### Data Pipelines
- runs with combination of complex tools and can face several different types of performance threats
- Performance threats:
	- Scalability
	- Application failures
	- Scheduled jobs not functioning accurately
	- Tool incompatibilities
- Performance metrics:
	- Latency: the time it takes for a service to fulfill a request 
	- Failures: the rate at which the application failed
	- Resource utilization and utilization patterns
	- Traffic: number of user requests received in a given period
- Troubleshooting:
	1. Collect information about the incident to ascertain if observed behavior is an issue
	2. Check if you're working with all the right versions of software and source codes. 
	3. Check logs and metrics early on in the trouble shooting. 
	4. Reproduce the issue in a test environment. 
### Database optimization for Performance
![[Pasted image 20240620081958.png]]![[Pasted image 20240620082138.png]]
![[Pasted image 20240620082203.png]]
### Monitoring Systems
![[Pasted image 20240620082230.png]]
![[Pasted image 20240620082410.png]]
![[Pasted image 20240620082440.png]]
![[Pasted image 20240620082502.png]]
![[Pasted image 20240620083422.png]]
![[Pasted image 20240620083435.png]]
### Maintenance routine
![[Pasted image 20240620083536.png]]
## Summary and highlights
In this lesson, you have learned,

- In order for raw data to become analytics-ready, a number of transformation and cleansing tasks need to be performed on raw data. And that requires you to understand your dataset from multiple perspectives. One of the ways in which you can explore your dataset is to query it.
    
- Basic querying techniques can help you explore your data, such as, counting and aggregating a dataset, identifying extreme values, slicing data, sorting data, filtering patterns, and grouping data.
    
- In a data engineering lifecycle, the performance of data pipelines, platforms, databases, applications, tools, queries, and scheduled jobs, need to be constantly monitored for performance and availability.
    
- The performance of a data pipeline can get impacted if the workload increases significantly, or there are application failures, or a scheduled job does not work as expected, or some of the tools in the pipeline run into compatibility issues.
    
- Databases are susceptible to outages, capacity overutilization, application slowdown, and conflicting activities and queries being executed simultaneously.
    
- Monitoring and alerting systems collect quantitative data in real time to give visibility into the performance of data pipelines, platforms, databases, applications, tools, queries, scheduled jobs, and more.
    
- Time-based and condition-based maintenance schedules generate data that helps identify systems and procedures responsible for faults and low availability.
# Governance and Compliance
## Governance and Compliance
### Introduction
- Data Governance is a **collection of principles, practices and processes to maintain the security, privacy and integrity**
### Data that needs Governance
![[Pasted image 20240620092245.png]]
![[Pasted image 20240620092330.png]]
### Compliance 
![[Pasted image 20240620092800.png]]
![[Pasted image 20240620092819.png]]
### Data Lifecycle 
![[Pasted image 20240620093047.png]]
![[Pasted image 20240620093114.png]]
![[Pasted image 20240620093131.png]]
![[Pasted image 20240620093146.png]]
![[Pasted image 20240620093205.png]]
### Technology as an Enabler 
![[Pasted image 20240620093307.png]]
![[Pasted image 20240620093336.png]]
![[Pasted image 20240620093400.png]]
![[Pasted image 20240620093417.png]]
![[Pasted image 20240620093429.png]]
![[Pasted image 20240620093449.png]]
![[Pasted image 20240620093504.png]]
![[Pasted image 20240620093521.png]]
![[Pasted image 20240620093542.png]]
## Summary and Highlights

In this lesson, you have learned:

Data Governance is a collection of principles, practices, and processes that help maintain the security, privacy, and integrity of data through its lifecycle.

Personal Information and Sensitive Personal Information, that is, data that can be traced back to an individual or can be used to identify or cause harm to an individual, needs to be protected through governance regulations.

General Data Protection Regulation, or GDPR, is one such regulation that protects the personal data and privacy of EU citizens for transactions that occur within EU member states. Regulations, such as HIPAA (Health Insurance Portability and Accountability Act) for Healthcare, PCI DSS (Payment Card Industry Data Security Standard) for retail, and SOX (Sarbanes Oxley) for financial data are some of the industry-specific regulations.

Compliance covers the processes and procedures through which an organization adheres to regulations and conducts its operations in a legal and ethical manner.

Compliance requires organizations to maintain an auditable trail of personal data through its lifecycle, which includes acquisition, processing, storage, sharing, retention, and disposal of data.

Tools and technologies play a critical role in the implementation of a governance framework, offering features such as:

- Authentication and Access Control.
    
- Encryption and Data Masking.
    
- Hosting options that comply with requirements and restrictions for international data transfers.
    
- Monitoring and Alerting functionalities.
    
- Data erasure tools that ensure deleted data cannot be retrieved.
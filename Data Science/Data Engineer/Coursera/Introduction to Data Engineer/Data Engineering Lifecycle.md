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
# Querying Data, Performance Tuning and Troubleshooting 
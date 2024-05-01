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
# Data Collection and Data Wrangling 

# Querying Data, Performance Tuning and Troubleshooting 
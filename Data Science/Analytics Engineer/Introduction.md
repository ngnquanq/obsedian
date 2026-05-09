## Reason
- Role was born due to the shift for ELT 
- In favor for business with strong techskills
- Focus on Data modelling and transformation
- Bridge between technical and business team
## Tools
- SQL, CLI, dbt, datawarehouse technology, Kimbal
- Github, gitlab, looker, tableau, airflow, dagster
- Python, R, Beam, Pub/sub


# What is a Database?
## 1. Definition
- A collection of data is stored
- Powers applications and companies
- Allows easier management and analysis of the data
## 2. Database
- Managed by DBMS (Database Management System) - Allow you to navigate database (These are different things)
- Software that stores vast amount of data into tables 
- Support s granular user management
- Allow backup
- etc
- Data is stored in table as rows and columns
- Use SQL to access stored data
	- Most modern DB use ANSI standard SQL
	- Be there for a long time
## 3. DBMS (Database Management System)
- Work w various data sources
- Popular DBMS:
	- MS SQL Server
	- MySQL 
	- Oracle Database
	- PostgreSQL
	- etc...
## 4. OLTP (Relational DB)
- OLTP: Online Transactional Processing
- Used for transaction-focus task 


# Datawarehouse
- Characteristics:
	- Subject-Oriented: focus on a subject, simple concise view around a specific subject, optimized to answer analytical questions, exclude unhelpful data
	- Integrated: hold data from all source and entire organization; we defined naming convention, measures and attribute. Extracted data is uniformly transformed
	- Time-variant: data is organized in time-periods; allow historical analysis; contains time element (either implicitly or explicitly). Once data is stored, it can not be modified
	- Non-volatile: data is permanent; is read only; only loading and accessing data is allowed; data keeps growing; refreshed at scheduled

# DataLake
- Storing EVERY DATA
## Staging Layer
- Sits between data lake and target layer 
- Stores raw data from data lake 
- Multiple data sources are aggregated at staging area
## Data Modelling and ERD Notation
- What is a data model?
- What is data modeling
- What is an ERD notation?
- Types of Data mordel?

## Normalization and Denormalization  
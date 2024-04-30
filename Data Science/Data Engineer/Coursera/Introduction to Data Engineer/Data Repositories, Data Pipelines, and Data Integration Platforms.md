# Overview of Data Repositories 
Types of data repositories:
- Databases
- Data Warehouses
- Big Data Stores

## Database
- Collection of data for input, storage, search, retrieval, and modification of data. 
- DBMS: Set of programs for creating and maintaining the database with multiple fun stuffs. 
- Database and DBMS are difference things. 
- Factor governing choice of database include:
	- Data type
	- Data structure
	- Querying mechanisms
	- Latency Requirements
	- Transaction speeds
	- Intended uses of data 
- 2 main types of database: 
	- Relational: RDBMS
		- Data is organized into a tabular format with rows and columns 
		- Well-defined structure and schema
		- Optimized for data operations and querying 
		- Use SQL as query language 
	- Non-relation: NoSQL 
		- Emerged in response to the volume, diversity, and speed at which data is being generated today 
		- Built for speed, flexibility and scale 
		- Data can be stored in a schema-less form 
		- Widely used for processing big data 
- Data Warehouse: consolidates data through the extract, transform, and load process, also known as the ETL process, into one comprehensive database for analytics and business intelligence

## Big data stores
Distributed computational and storaage infrastructure to store, scale and process very large data sets


# RDBMS (relational database management systems)
## What is relational database? 

![[Pasted image 20240422185837.png]]

- RDBMS use structured query language or SQL for querying data 

![[Pasted image 20240422190018.png]]

![[Pasted image 20240422190119.png]]

![[Pasted image 20240422190222.png]]

![[Pasted image 20240422190341.png]]

![[Pasted image 20240422190642.png]]

![[Pasted image 20240422190748.png]]

# NoSQL (Not only SQL)
A non relational database design that provides flexible schemas for the storage and retrieval of data.
- Gained greater popularity due to the emergence of cloud computing, big data, and high-volume web and mobile applications 
- Chosen for their attributes around scale, performance, and ease of use 
- Built for specific data models
- Has flexibble schemas that allow programmers to create and manage modern applications
- Not use a traditional row/column/table database design with fixed schemas
- Do not, typically use the structured query language (or SQL) to query data 

Allow data to be stored in a schema-less or free-form fashion

## Four different types of NoSQL databases

### Key-value store

![[Pasted image 20240422191248.png]]

![[Pasted image 20240422191304.png]]

![[Pasted image 20240422191321.png]]

### Document-based

![[Pasted image 20240422191405.png]]

![[Pasted image 20240422191415.png]]

### Column-based
![[Pasted image 20240422191459.png]]

![[Pasted image 20240422191528.png]]

![[Pasted image 20240422191538.png]]

### Graph-based
![[Pasted image 20240422191611.png]]
![[Pasted image 20240422191627.png]]
![[Pasted image 20240422191648.png]]
![[Pasted image 20240422191716.png]]

## Advantages of NoSQL
![[Pasted image 20240422191806.png]]

## Key differences between RDBMS and NoSQL

![[Pasted image 20240422191915.png]]

# Data Warehouses, Data Marts, Data Lakes 

These are data mining repositories
## Data Warehouses

![[Pasted image 20240422192231.png]]

![[Pasted image 20240422192259.png]]

![[Pasted image 20240422192333.png]]

Some big data warehouses platform: 
![[Pasted image 20240422192420.png]]
## Data Marts
![[Pasted image 20240422192556.png]]
### Dependent data marts
![[Pasted image 20240422192617.png]]

### Independent data marts

![[Pasted image 20240422192715.png]]
### Hybrid data marts 
![[Pasted image 20240422192724.png]]

### Purpose of data marts

![[Pasted image 20240422192811.png]]

## Data Lakes

![[Pasted image 20240422192913.png]]

![[Pasted image 20240422192943.png]]

### Pros and Cons 
![[Pasted image 20240422193020.png]]

### Providers

![[Pasted image 20240422193101.png]]

# Considerations for Choice of Data Repository

![[Pasted image 20240422220430.png]]

![[Pasted image 20240422220551.png]]

# ETL, ELT, Data pipelines

## Extract, Transform, and Load Process

![[Pasted image 20240422220729.png]]

### Extract process
![[Pasted image 20240422220816.png]]

![[Pasted image 20240422220832.png]]

### Transform process
![[Pasted image 20240422220913.png]]

### Load process 
![[Pasted image 20240422220951.png]]

![[Pasted image 20240422221015.png]]

### Tools

![[Pasted image 20240422221047.png]]

## Extract, Load, Transform process

![[Pasted image 20240422221115.png]]

### Advantages 

![[Pasted image 20240422221206.png]]

## Data Pipelines 
![[Pasted image 20240422221332.png]]

# Data integration platforms 

![[Pasted image 20240422221552.png]]

![[Pasted image 20240422221605.png]]

## Data integration pipeline 
![[Pasted image 20240423102151.png]]

ETL is an process lie within the Data integration pipeline 

## Capabilities of Data Integration platform

![[Pasted image 20240423102744.png]]


# Tools, Databases, and Data Repositories of Choice

![[Pasted image 20240423103312.png]]
![[Pasted image 20240423103344.png]]

![[Pasted image 20240423103435.png]]

![[Pasted image 20240423103547.png]]

![[Pasted image 20240423103741.png]]

![[Pasted image 20240423103856.png]]
# Summary and Highlights
In this lesson, you have learned:

A Data Repository is a general term that refers to data that has been collected, organized, and isolated so that it can be used for reporting, analytics, and also for archival purposes.

The different types of Data Repositories include:

- Databases, which can be relational or non-relational, each following a set of organizational principles, the types of data they can store, and the tools that can be used to query, organize, and retrieve data.
    
- Data Warehouses, that consolidate incoming data into one comprehensive store house.
    
- Data Marts, that are essentially sub-sections of a data warehouse, built to isolate data for a particular business function or use case.
    
- Data Lakes, that serve as storage repositories for large amounts of structured, semi-structured, and unstructured data in their native format.
    
- Big Data Stores, that provide distributed computational and storage infrastructure to store, scale, and process very large data sets.
    

The ETL, or Extract Transform and Load, Process is an automated process that converts raw data into analysis-ready data by:

- Extracting data from source locations.
    
- Transforming raw data by cleaning, enriching, standardizing, and validating it.
    
- Loading the processed data into a destination system or data repository.
    

The ELT, or Extract Load and Transfer, Process is a variation of the ETL Process. In this process, extracted data is loaded into the target system before the transformations are applied. This process is ideal for Data Lakes and working with Big Data.

Data Pipeline, sometimes used interchangeably with ETL and ELT, encompasses the entire journey of moving data from its source to a destination data lake or application, using the ETL or ELT process.

Data Integration Platforms combine disparate sources of data, physically or logically, to provide a unified view of the data for analytics purposes.
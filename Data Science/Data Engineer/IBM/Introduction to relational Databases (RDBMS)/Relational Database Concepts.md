# Fundamental Relational Database Concepts
## Review of Data Fundamentals
### Data
![[Pasted image 20240625220250.png]]
### Data Structure
![[Pasted image 20240625220310.png]]
#### Structured data
![[Pasted image 20240625220343.png]]
![[Pasted image 20240625220420.png]]
#### Unstructured data 
![[Pasted image 20240625220518.png]]
![[Pasted image 20240625220459.png]]
#### Semi-structured data
![[Pasted image 20240625220609.png]]
![[Pasted image 20240625220630.png]]
### Data Sources 
![[Pasted image 20240625220651.png]]
### File formats
- Delimited text files:
	- Rows of variables separated by character
	- Examples: CSV, TSV files
- Spreadsheets:
	- Includes data in rows columns for manipulation
	- Creates CSV files
- Language files:
	- Includes XML and JSON
	- Set rules
### Data repositories
- Store, manage and organize data
- Offer a structured framework for retrieval and administration
- Categories include:
	- Relational Databases
	- Non-relational Databases
- Relational databases
![[Pasted image 20240626075404.png]]
![[Pasted image 20240626075426.png]]
![[Pasted image 20240626075458.png]]
- Non-relational databases
![[Pasted image 20240626075524.png]]
### Conclusion
- Varied data types need tailored storage
- OLAP enables complex analytics
- Relational databases serve OLTP needs
- Non-relational databases offer flexibility
## Information and Data Models
### Data management
Key concepts in data organization:
- Information Models
- Data Models 
#### Information model
- Represents entities abstractly.
- Includes properties, relationships, and functions of entities. 
- Provides a high-level and organized view of information.
- Enables understanding of structure and interconnections of data without delve in implementation details. 
- Aspects:
	- Understanding different types of information.
	- Abstract complexity of real-world entities
	- Encompass broad concepts
	- Understand and define business concepts and rules
#### Data model
![[Pasted image 20240626092003.png]]
![[Pasted image 20240626092016.png]]
- Aspects. Data models specify:
	- Data elements
	- Structures
	- Constraints
	- Relationships
- Tailored to a particular DBMS, they define:
	- Schema
	- Tables
	- Indexes
	- Data types
	- Columns
### Differences: Information and data models
![[Pasted image 20240626092321.png]]
### Hierarchical model
Serves as the physical implementation of information systems
![[Databases_and_SQL.svg]]
### Relationship 
![[Pasted image 20240626092714.png]]
![[Pasted image 20240626092736.png]]
![[Pasted image 20240626092803.png]]
### Types of data models 
![[Pasted image 20240626093145.png]]
![[Pasted image 20240626093158.png]]
![[Pasted image 20240626093220.png]]
### Converting ER diagram into tables 
![[Pasted image 20240626093920.png]]
The entities is the rectangle, the attribute of that entities are the oval 
### Concepts in database management
#### Ensure adaptability and efficiency
![[Pasted image 20240626094204.png]]
## ERDs and Types of Relationship
### Entity-relationship Diagram (ERD)
- Visual representation
- Illustrates relationships and interactions between entities
- Showcases logical structure of a database system
- Entities: Boxes
- Relationships: Lines
### Fundamental components
Fundamental components of the relationship: 
![[Pasted image 20240626100700.png]]
![[Pasted image 20240626100718.png]]
![[Pasted image 20240626100738.png]]
![[Pasted image 20240626100755.png]]
### Relationships between entities
The scenario is that we want to build a relationship between `author` and `book`
![[Pasted image 20240626100957.png]]

![[Pasted image 20240626101031.png]]
![[Pasted image 20240626101052.png]]
![[Pasted image 20240626101136.png]]
![[Pasted image 20240626101109.png]]
## Mapping entities to tables
### Entity-relationship diagram (ERD)
![[Pasted image 20240626102400.png]]
### Components of ERD
![[Pasted image 20240626102440.png]]
### Relational database
![[Pasted image 20240626102643.png]]
### Mapping an ERD into a table 
![[Pasted image 20240626104136.png]]
![[Pasted image 20240626104151.png]]
![[Pasted image 20240626104202.png]]
### Best practices
![[Pasted image 20240626104247.png]]
![[Pasted image 20240626104318.png]]
![[Pasted image 20240626104405.png]]
![[Pasted image 20240626104427.png]]
## Data Types
### Database table 
![[Pasted image 20240626110058.png]]
Each column much contain it specific datatype, for example, `Publish date` cannot contain string or numerical value, it should be datetime with the right format. `Pages` also can only contain numerical value, but not string. 
### Varchar
![[Pasted image 20240626110253.png]]
![[Pasted image 20240626110313.png]]
![[Pasted image 20240626110325.png]]
![[Pasted image 20240626110719.png]]
![[Pasted image 20240626110731.png]]
![[Pasted image 20240626110752.png]]
![[Pasted image 20240626110801.png]]
![[Pasted image 20240626110828.png]]
![[Pasted image 20240626110915.png]]
![[Pasted image 20240626110952.png]]
**Char is best used when you expect the data values in a column to be the same length**. On the other hand, varchar is best used when you expect the data values in a column to be of variable length.
### Advantages of using data types
- Data integrity
- Data sorting
- Range selection
- Data calculations 
## Relational Model Concepts
Involves **two fundamental concepts:**
1. Sets
2. Relations
![[Pasted image 20240626111717.png]]
![[Pasted image 20240626111802.png]]
![[Pasted image 20240626111831.png]]
![[Pasted image 20240626111909.png]]
### Relation
![[Pasted image 20240626112247.png]]
### Aspect of relation
![[Pasted image 20240626112328.png]]
### Properties of relation
![[Pasted image 20240627094019.png]]
![[Pasted image 20240627094224.png]]
![[Pasted image 20240627094241.png]]
This is an example of relation schema. 
![[Pasted image 20240627094310.png]]
This is an example of relation instance.
![[Pasted image 20240627094406.png]]
### Key concepts 
- Degree: The number of attributes or columns of the table
- Cardinality: The number of tuples or rows
**Note**: distinct between **relation**(which is a table) and **relationship**(which is an association between relations)

## Summary and Highlights

Congratulations! You have completed this lesson. At this point, you know that:

- There are three main data categories. These include: structured, unstructured, and semi-structured.
    
- Data repositories store and manage data centrally, including relational and non-relational databases.
    
- Information Models provide abstract representations of entities and relationships, whereas Data Models serve as blueprints for practical database structures.
    
- An Entity-Relationship Diagram (ERD) is a visual representation that illustrates the relationships and interactions between entities in a database.
    
- The fundamental components that form the structure of a relationship include entities, relationship sets, and crow’s foot notations.
    
- Varchar, an abbreviation for variable character, is a data type that stores character strings.
    
- Sets characterized by their unordered collections include operations such as membership, subsets, union, and intersection.
    
- Relations describe connections between set elements and consist of two essential components: The Relation Schema and the Relation Instance.
# Introducing Relational Database Products 
## Database Architecture
### Deployment topology
Arrangement of configuration of:
- Hardware
- Software
- Network components
Depends on factors:
- Scalability
- Performance
- Reliability
- Nature of application
### Common deployment topologies
![[Pasted image 20240627100754.png]]
#### Single-tier architecture
- Deploys all components on a single server. 
- Operates within the same environment
#### Client-server architecture
- Also referred to as two-tier architecture
- Divides the application into two distinct layers
	- Client layer: responsible for user interface
	- Server layer: manages the application logic 
- The remote server hosts the database
- Users access it from client systems 
- An overview of two-tier database
![[Pasted image 20240627101127.png]]
- DBMS layers: 
![[Pasted image 20240627101235.png]]
- Communication in database interface
![[Pasted image 20240627101544.png]]
### Three-tier architecture database
![[Pasted image 20240627101938.png]]
![[Pasted image 20240627102732.png]]
![[Pasted image 20240627102954.png]]
### Cloud deployment
![[Pasted image 20240627103257.png]]
![[Pasted image 20240627103324.png]]
## Distributed architecture and clustered databases
### Distributed architectures
![[Pasted image 20240627103828.png]]
![[Pasted image 20240627103840.png]]
### Types of database architecture
#### Shared disk architecture
![[Pasted image 20240627103908.png]]
![[Pasted image 20240627103923.png]]
Advantages:
- Ensures effective workload distribution
- Ensure scalability as demand grows
- Reroutes clients during server failures
- Maintains high availability
#### Shared nothing architecture
![[Pasted image 20240627141202.png]]
### Combination and specialized architectures
- Employ combination of: 
	- Shared disk
	- Shared nothing
	- Replication or partitioning techniques
- Integrate specialized hardware components
### Common techniques
![[Pasted image 20240627141325.png]]
#### Database replication
![[Pasted image 20240627141405.png]]
If something went wrong, the system redirects clients to HA replica
#### Database partitioning and Sharding 
![[Pasted image 20240627141537.png]]
Advantages:
- Handle data warehousing and business intelligence
- Handle extensive volumes of data

## Database Usage Patterns
### Key user roles
![[Pasted image 20240627141729.png]]
## Introduction to Relational Database Offerings 
![[Pasted image 20240629145759.png]]

## Db2

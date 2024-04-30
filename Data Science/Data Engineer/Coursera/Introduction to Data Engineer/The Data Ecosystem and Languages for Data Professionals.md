# Overview of the Data Engineering Ecosystem

![[Pasted image 20240422103802.png]]

![[Pasted image 20240422103817.png]]

## Data
1. **Structured**: Data that follows a rigid format and can be organized into rows and columns 
2. **Unstructured**: Data that is complex and mostly qualitative information that cacnnot be structured into rows and columns 
3. **Semini-structured:** Mix of data that has consistent characteristics and data that does not conform to a rigid structure. Email is an example, it have name of the sender, time the email being sent, the receiver as structured, but the content of the email is unstructered. Photo, PDF, Social media content for examples 

![[Pasted image 20240422104513.png]]

## Data Repositories

### Transactional or Online Transaction Processing (OLTP system)
- Designed to store high volume day-to-day operational data 
- Typically relational, but can also be non-relational 

### Analytical or Online Analytical Processing (OLAP system)
- Optmized for conducting complex data analytics
- Include relational and non-relational databases, data warehouses, data marts, data lakes, and big data stores 

## Data integration 

![[Pasted image 20240422105523.png]]

## Data pipeline 

![[Pasted image 20240422105611.png]]

## Languages 

![[Pasted image 20240422105643.png]]

## BI and Reporting Tools 

![[Pasted image 20240422105716.png]]

# Types of Data 

Data combines: 
1. Facts, observations, perceptions
2. Numbers, characters, symbols
3. Images

Data can be:
- **Structured**: Has a well-defined structure. Can be stored in well-defined schemas. Can be represented in a tabular manner with rows and columns. Is objective facts and numbers that can be collected, exported, stored and organized. Structured data is stored: 
	- SQL Databases
	- Online Transaction Processing
	- Spreadsheets
	- Online forms 
	- Sensors GPS and RFID
	- Network and Web server logs 
- **Semi-structured data:** Has some organizational properties but lacks a fixed or rigid schema. Cannot be stored in the form of rows and columns as in databases. Contains tags and elements or metadata, which is used to group data and organize it in a hierarchy. Sources:
	- E-mails
	- XML and other markup languages
	- Binary executables 
	- TCP/IP packets
	- Zipped files
	- Integration of data 
- **Unstructured data:** Does not have an easily identifiable structure. Cannot be organized in a mainstream relational database in the form of rows and columns. Does not follow any particular format, sequence, semantics or rules. Sources include: 
	- Web pages
	- Social media feeds
	- Images in varied file formats
	- Video and Audio files
	- Documents and PDF files
	- PowerPoint presentations 
	- Media logs
	- Surveys

# Understanding Different Types of File Formats 

**TLDR:** Understanding this will support you to make the right decisions on the formats best suited for your data and performance needs

## Delimited text files: 
![[Pasted image 20240422112625.png]]


## Microsoft Excel Open XML Spreadsheet, or .XLSX
Is a Microsoft Excel Open XML file format that falls under the spreadsheet file format. It is an XML-based file format created by Microsoft. This is an open file format, accessible to most other applications. Can use and save all functions available in excel 

## Extensible Markup Language or .XML

![[Pasted image 20240422151020.png]]

## Portable Document Format or PDF

![[Pasted image 20240422151052.png]]

## JavaScript Object Notation or JSON 

![[Pasted image 20240422151117.png]]

# Sources of Data 
## Relational Databases 
- Such as MSSQL, Oracle, MySQL, IBM DB2
- Store structured data that can be leveraged for analysis 
## Flat file and XML datasets
#### Flat files
- Store data in plain text format 
- Each line, or row, is one record
- Each value is separated by a delimiter
- All of the data in a flat file maps to a single table 
- Most common format is .CSV
#### Spreadsheet files
- Special type of flat files
- Organize data in a tabular format
- Can contain multiple worksheets 
- .XLS or .XLSX are common spreadsheet formats
- Other formats include Google Sheets, Apple Numbers, and LibreOffiice Calc
#### XML files 
- Contain data values that are identified or marked up using tags 
- Can support complex data structures 
- Common uses include online surveys, bank statements, and other unstructured datasets

## API and Web Services 

![[Pasted image 20240422152056.png]]


![[Pasted image 20240422152412.png]]

![[Pasted image 20240422152445.png]]

![[Pasted image 20240422152536.png]]

Popular technologies:
- Kafka
- Spark
- Apache Storm 
- 
![[Pasted image 20240422152641.png]]

![[Pasted image 20240422160235.png]]

Some challenges :

![[Pasted image 20240422160700.png]]


# Summary and Highlights

In this lesson, you have learned:

A Data Engineer’s ecosystem includes the infrastructure, tools, frameworks, and processes for extracting data, architecting and managing data pipelines and data repositories, managing workflows, developing applications, and managing BI and Reporting tools.

Based on how well-defined the structure of the data is, data can be categorized as

- Structured data, that is data which is well organized in formats that can be stored in databases.
    
- Semi-structured data, that is data which is partially organized and partially free-form.
    
- Unstructured data, that is data which can not be organized conventionally into rows and columns.
    

Data comes in a wide-ranging variety of file formats, such as, delimited text files, spreadsheets, XML, PDF, and JSON, each with its own list of benefits and limitations of use.

Data is extracted from multiple data sources, ranging from relational and non-relational databases, to APIs, web services, data streams, social platforms, and sensor devices.

Once the data is identified and gathered from different sources, it needs to be staged in a data repository so that it can be prepared for analysis. The type, format, and sources of data influence the type of data repository that can be used.

Data professionals need a host of languages that can help them extract, prepare, and analyse data. These can be classified as:

- Querying languages, such as SQL, used for accessing and manipulating data from databases.
    
- Programming languages such as Python, R, and Java, for developing applications and controlling application behavior.
    
- Shell and Scripting languages, such as Unix/Linux Shell, and PowerShell, for automating repetitive operational tasks.

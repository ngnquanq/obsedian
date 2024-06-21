# Overview of Database Management Tasks 
## Introduction to Relational Database Administration
When you are skilling up to become a Data Engineer, you **need to learn about working with and managing databases.** This course teaches you the fundamental database administration skills you will need as a Data Engineer.

During this course, you will get an overview of the types of tasks involved in database management and see what a typical workday for a Database Administrator (DBA) looks like, revolving around various activities ranging from designing databases to planning and troubleshooting errors. You will gain hands-on experience learning about server objects, configurations, and database objects, including schemas, tables, triggers, and events.

The ability to respond quickly to system failures, corruption, and catastrophic events is a key part of any DBA's job. Crucial to this is the ability to recover data that has been lost, so you will learn to backup and recover databases and define backup and recovery policies and procedures through hands-on labs.

Security of data and databases is critical for any organization. To help ensure data is secure, you'll learn about database security and user management, including creating and resetting user passwords, creating groups, and more.

Ongoing monitoring and optimization of databases are essential tasks that enable DBAs to respond to issues before they become problems. Course topics include creating and keeping baselines, performance metrics, standards, and finally, monitoring RAM and disk usage, connections, and cache stats. You will learn about database optimization, including updating statistics, addressing slow queries, and creating indexes.

In this course, you'll explore some basic troubleshooting processes that help data engineers find frequently occurring issues, such as connectivity, login, configuration, and whether the instance is running.

Being able to automate processes is a skill that enables DBAs to make database administration easier. You can automate many functions, from managing alerts to generating and sending reports. You can create these automation tasks using standard Linux and Unix shell commands or cron jobs.

This course uses a free, cloud-based environment where you complete hands-on labs that enable you to apply the knowledge you learned during this course.

Course prerequisites include basic knowledge of relational databases and SQL fundamentals. Understanding the Linux command line interface and how to use shell commands will also benefit you during the final modules of the course.

So, let's get started!
## Day in the Life of a Database Administrator
1. Check database dashboards for activity alerts and resolve issues. 
2. Check overnight batch jobs 
3. Supporting users:
	1. Check email
	2. Review support tickets
	3. Triage user requests
	4. Optimize queries
	5. Clarify requests and schema changes 
4. Working with stakeholders:
	1. Meeting with developers, data engineers, and data architects
	2. Stress test scenarios
	3. Determine appropriate server resources needed
5. Finishing the day:
	1. Automate repeating tasks
	2. Respond to user requests
	3. Monitor database activities
## Database Management Lifecycle
![[Pasted image 20240620112532.png]]
**Requirements analysis**: Understand purpose and scope of the database (after discuss about data, users, producers and create samples)
- work with stakeholders (devs, DE, Administrators, End-users, TEchnology managers, other DBAs), works including:
	- Analyze need for database
	- Clarify goals for database 
**Design and plan**: Work with database objects
![[Pasted image 20240620112756.png]]
![[Pasted image 20240620112848.png]]
**Implementation**: 
- Create and configure database objects
- Grant access for database users, groups 
- Automate repeating tasks 
- Deploy data movement
**Monitor and maintain**:
- Monitor system for performance issues
- Review reports 
- Apply upgrades and patches to RDBMSes
- Automate deployments and routine tasks
- Troubleshoot issues 
- Security and Compliance 
	- Ensure data is secure and only authorized users can access it. 
	- Review logs, monitor failed logins and data access activity
	- Maintain database permissions - grant/revoke access
# Server Objects and Hierarchy
## Database Objects

## System Objects and Database Configuration

## Database Storage


1. Introduction to Java
	1. Features and Benefits
	2. Language Fundamentals 
2. Introduction to O-O programming with Java
	1. Basics of OO in Java
3. Object-Oriented Hierarchies in Java
	1. Deeper, more complete Object-Oriented in Java
4. Using the Java SE Class Library
	1. Covers key portions of the standard library
	2. Prepares you for more advanced Java Specializations
# Introduction to Java
1. Introduction to Java
2. Java Language Fundamentals - Types
3. Java Language Fundamentals - Flow of Control
# Introduction and Benefits
1. Write once run anywhere (WORA): 
	1. A Java Application is hosted on a Java Virtual Machine (JVM)
	2. The code is compiled into an "intermediate format" called **architecture-neutral bytecodes.** 
	3. Developers write code for the Java platform rather than a specific platform 
	4. The bytecodes are executed by the JVM and the bytecode instructions are translated into native machine code by the Java Runtime Environment (JRE)
	5. ![[Pasted image 20240720111039.png]]

2. Packages, Syntax and Libraries:
	1. Packages are Java's platform-neutral version of directories. Just as Windows directories are separated by the blackslash, the 'nodes' of a Java package structure are separated by a dot. For example: 
				`package com.learnquest.calculator.util`
		A Java program often use dozens, even hundreds of individual files. Packages can be used to group these files meaningfully. 
	2. Familiar C/C++ syntax.
	3. Rich library support.
3. Connectivity and Performance
	1. JDBC packages are a key offering found in java.sql and included as a part of the standard Java distribution.
		1. This package facilitates database-neutral interaction with a relational database. 
		2. The package provides a set of interfaces that have been standardized by the JDBC specification
		3. The required behavior is specified by the specification
		4. The actual implementation of this behavior is determined by the database vendor or some other standards-compliant 3rd party. 
	2. JDBC: ![[Pasted image 20240720112940.png]]
	3. Security: 
		1. In a WORA environment, where easy distribution is facilitated by the internet, guarding against malicious code is a key requirement. 
		2. The Bytecode Verifier checks for security violations in compiled bytecodes before it's executed by the JRE. 
		3. Java programs now run with client-specified security settings that give them specified degrees of access to local resources. 
	4. Performance: thanks to JIT, now java run fast. 
	5. Free.

# Editions
## Java Product Suite: 
1. Java Standard Edition (SE): 
	1. Language
	2. JVM
	3. Core libraries 
2. Java Enterprise Edition (EE):
	1. Application Server Framework
	2. For **handling web components**
	3. Business logic side
3. Java Micro-Edition (ME): 
	1. Hardly seen by developers
	2. Blu-Ray players 
## Java Standard Edition (SE)
- The core offering that underpins both the enterprise edition and micro edition
- Composed of a Java Runtime Environment (JRE)  and a Java Development Kit (JDK) for programming in Java
- Key tools:
	- javac: java compiler
	- java
	- javadoc: tools for generating java doc from java file
	- jdb: java debugger, rarely use. 
- For non-developer, it's possible to get a standard a stand-alone JRE. 
## Java Enterprise Edition (EE)
- Provides the following core API:
	- Java Servlets and Java Server Pages (JSP)
	- Enterprise Java Beans (EJB)
	- Java messaging service (JMS)
	- Everything provided by the Standard Edition
- Defines a set of standard APIs for multi-tier enterprise scale applications.
- Designed to work in conjunction with an application server environment such as WebSphere.
### Java EE API
1. JDBC core API
2. RMI-IIOP API
3. JNDI API
4. JDBC Extensions 2.0
5. EJB (Enterprise Java Bean)
6. Servlet API
7. JSP (Java Server Pages)
# Installation and Demo
## JDK Installation and Demo
![[Pasted image 20240720123353.png]]

## Java Ecosystem Popularity - Versions and Frameworks

The **snyk** company produces an annual JVM ecosystem report. Their [2020 report](https://snyk.io/blog/jvm-ecosystem-report-2020/)

identified a few items of interest:

- 36% of developers had switched from Oracle JDK to OpenJDK due to Oracle's licensing changes.
    
- 64% of developers are using Java 8. Only 25% use Java 11. Those are the current LTS (Long-Term Support) releases. Although, some took issue with the change in licensing, the primary reasons appear to be that Java 8 works just fine, and Java 11 not only offers nothing significant enough to inspire migration, but actually removed almost 2000 classes from the Standard Library.
    

- 60% of developers use Spring.
    

Based on this, one should expect Java 8 LTS to be around for a very long time, which is well-confirmed by the support plans, which state that Java 8 will be supported for years after Java 11 LTS is long gone.

# Java Types - Syntax 
## Creating Java Statements
- We will begin by defining an entry point into our Java program
- We will also learn to write the statements that will fill our program and add functionality to it. 
- Java statements end with a semi-colon (;).
## The structure of Java files 
1. Beginning Java programmers are often confused about how to get their program to run. Most Java files will never run by themselves. 
2. To create a "stand-alone" Java program, you need to include a special method - the "main" method. 
3. The instructions in the main method will run when you execute the program by itself. 
4. If you run a program that does not have a main method, an error occurs .
## A simple Java Program 
```java
public class HelloWorld {
	public static void main(String[] args) {
		System.out.println("Hello World)"};
}
```
1. `public class HelloWorld`: class (public so that it visible in runtime). Must be in a file called `HelloWorld.java`  
2. `public static void main`: it must be public, must be static for every entrypoint. void mean doesn't return anything. 
3. `String[] args`:  parse into the function as a string array. 
4. `{System.out.println("Hello World)"};`: The entire content of a program. 

## Java Naming Conventions 
1. Names are used to denote classes, objects, attributes and methods
2. A name is a sequence of letters and numbers and underscore. 
3. Names may not start with a number. 
4. Java names are case sensitive. 
	1. Class names utilize Camel Case (first letter in each word is capitalized).
		1. Examples: Class Name: 
			1. `ThisIsAClassNameInCamelCase`
	2. Finals (Constants) are completely capitalized as a stylistic convention.
		1. Examples: Constant:
			1. THIS_IS_A_CONSTANT
5. ![[Pasted image 20240720141529.png]]
![[Pasted image 20240720142704.png]]

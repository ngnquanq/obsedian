In this module, we discuss why we are using Object-Oriented Programming, and introduce the concepts in Java of Classes, Objects, Attributes, and Methods. Along with that, we'll discuss some of the conventions of the JavaBeans Specification, and make use of them in our code.
# Managing Complexity
## Why we use Object-Orientation
For communicate with graphical environment more effectively and managing complexity. 
Object Orientation programming uses "encapsulation" to isolate complex sections of code. Programmers can use code without having to understand the details of how it works. 

# Code Re-use
![[Pasted image 20240723142727.png]]
# Managing Change  
![[Pasted image 20240723142917.png]]A class should only have one responsibility. 

# Moving to OO from procedural
![[Pasted image 20240723143229.png]]![[Pasted image 20240723143423.png]]
A file in Java is a specify public class doing it specific job (SRP: Single responsibility princible)
![[Pasted image 20240723143614.png]]
# OO Definitions 
![[Pasted image 20240723144058.png]]
![[Pasted image 20240723144637.png]]

# Defining a class
![[Pasted image 20240723145255.png]]![[Pasted image 20240723150051.png]]
![[Pasted image 20240723150136.png]]
# The Bean Specification

This course covers the basics that are typically used by developers and used by most frameworks. But the [JavaBeans Specification](https://download.oracle.com/otn-pub/jcp/7224-javabeans-1.01-fr-spec-oth-JSpec/beans.101.pdf?AuthParam=1596756008_2f2bdcce270ee3b3b750fb904b12948f)

is over 100 pages long, and provides a much richer environment than most developers know and most frameworks leverage. Amongst the topics not covered in this course are:

- Indexed Properties
    
- Change Notification
    
- Vetoable Changes
    
- Events
    
- Persistence
    
- Property Editors
    

If you wish to master the subject of JavaBeans, you will want to read the specification, or at least review it to get an idea of what is provided, and know where to look if and when you need the details.

# Objects 
![[Pasted image 20240723151302.png]]
![[Pasted image 20240723151659.png]]

# Formatting Output using PrintStream

In the lesson's demo, we saw the use of the [printf](https://docs.oracle.com/javase/7/docs/api/java/io/PrintStream.html#printf(java.lang.String,%20java.lang.Object...)) method on System.out. System.out is a [PrintStream](https://docs.oracle.com/javase/7/docs/api/java/io/PrintStream.html), and we can use the printf or format methods interchangeably.

The official Java Tutorial provides further [information on using printf](https://docs.oracle.com/javase/tutorial/java/data/numberformat.html)to display information to the console. Take time to review printf, because you'll be wanting to use it. A lot.
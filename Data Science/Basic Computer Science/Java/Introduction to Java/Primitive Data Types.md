# Primitive Data Types
## Non-object Data in Java
- Java uses several types of constructs:
	- Outermost blocks
		- Classes
		- Interfaces
		- Annotations
		- Enums
	- Other types
		- Arrays
		- Primitives
## Primitive Data types
- Simply variables to hold data, the only thing in Java can hold data. 
- Java provides several primitive data types. They are:
	- byte, short, int, long, float, double, boolean, char
### Integer types
- The integer types in Java are byte, short, int and long. 
- Arithmetic expressions can throw exceptions (errors) for circumstances such as divide by zero. => The notion of throwing an exception will be covered later. 
- The compiler assumes literals are integer values; to declare a long literal, use: `long myLong = 23456L`
## Real number types
- Real numbers are represented by `float` and `double` types. 
- Real numbers also include special values for infinity and NaN. 
- Real number literals default to double. 
- To declare a float, suffix with F: `float myFloat = 234.78F`

## Creating primitives
- To create a primitive, just simply **specify its type** and **named it, separated by a space** and **followed by a semi-colon**. 
- Example: 
		`int x;
		`boolean isStarted;
- If you have **several primitives of the same type**, you can **create them in a comma separated list**: 
- Example:
		`int x, y, z`
- You can also assigned the value to those: `int x = 5;`
**For creating primitives**
1. You can declare primitives anywhere in your code. 
2. Their placement affects their visibility. 
3. Primitives that are declared inside a code block are only visible inside that block. 
4. Primitives are also only visible below the point at which they're declared
### Naming Conventions for Primitives
Primitives and methods share the same naming convention: the first word in the name is lowercase, the first letter in each additional word in the name is uppercase (**Low Camel Case**).

For finals, words are separated by underscores (**Snake case**) and are all capitals.

```java
public class Car{
	//Some "primitive" data 
	private int numberOfDoors;
	private int numberOfWheels;
}

```
### Initializing primitives
If you do not assign a value to a primitive, Java automatically uses a default value. (It will default to whatever 0 means). 

Otherwise, you can assign an initial value at the time you declare the variable. 
- Note that the best practice dictates that these types of variables are given values in constructor methods which we will cover later. 

```java
public class Car{
	//Some "primitive" data 
	private int numberOfDoors = 2;
	private int numberOfWheels = 4;
}

```

![[Pasted image 20240721123354.png]]

# Wrapper classes 
![[Pasted image 20240722151156.png]] 

![[Pasted image 20240722152010.png]]


# Arrays
![[Pasted image 20240722152234.png]]

To initialize an array we use the new operator and another set of square brackets like this: 

```java
int[] myIntArray = new int[25];
```
![[Pasted image 20240722170041.png]]

![[Pasted image 20240722172219.png]]
Each character in a String Object is a primitive which char stored. 

# Unboxing and Autoboxing in Java
In the lesson, we discussed how for each primitive there is a matching Class. Java 5 introduced autoboxing and unboxing, where the compiler lets us write code almost exclusively using primitives, and takes care of creating moving primitives into and out of objects where necessary.

For more details, read:

- Java Tutorial: [Autoboxing and Unboxing](https://docs.oracle.com/javase/tutorial/java/data/autoboxing.html)
    

- Java Documentation: [Autoboxing](https://docs.oracle.com/javase/8/docs/technotes/guides/language/autoboxing.html)
    

Remember: only Java primitives ultimately contain data in Java. Objects act as containers for those primitives. So write your code using primitives. The few use cases were we **need** to use the Wrapper classes are when dealing with Collections and when using Generics (the subject of a later less).
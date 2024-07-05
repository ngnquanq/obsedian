# Regions

When determining the right Region for your services, data, and applications, consider the following four business factors. 

### **Compliance with data governance and legal requirements**

Depending on your company and location, you might need to run your data out of specific areas. For example, if your company requires all of its data to reside within the boundaries of the UK, you would choose the London Region. 

Not all companies have location-specific data regulations, so you might need to focus more on the other three factors.

### **Proximity to your customers**

Selecting a Region that is close to your customers will help you to get content to them faster. For example, your company is based in Washington, DC, and many of your customers live in Singapore. You might consider running your infrastructure in the Northern Virginia Region to be close to company headquarters, and run your applications from the Singapore Region.

### **Available services within a Region**

Sometimes, the closest Region might not have all the features that you want to offer to customers. AWS is frequently innovating by creating new services and expanding on features within existing services. However, making new services available around the world sometimes requires AWS to build out physical hardware one Region at a time. 

Suppose that your developers want to build an application that uses Amazon Braket (AWS quantum computing platform). As of this course, Amazon Braket is not yet available in every AWS Region around the world, so your developers would have to run it in one of the Regions that already offers it.

### **Pricing**

Suppose that you are considering running applications in both the United States and Brazil. The way Brazil’s tax structure is set up, it might cost 50% more to run the same workload out of the São Paulo Region compared to the Oregon Region. You will learn in more detail that several factors determine pricing, but for now know that the cost of services can vary from Region to Region.

# Availability Zones

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/4Nn3-avkQfeZ9_mr5IH3Qg_6ff859ac606549e492cfa32a46d95438_AZ1.png?expiry=1720310400000&hmac=DDYsv8n8uBjZMFbXBMgk9zNmFfK7_LvyhrDYUXrlSbY)

An **Availability Zone** is a single data center or a group of data centers within a Region. Availability Zones are located tens of miles apart from each other. This is close enough to have low latency (the time between when content requested and received) between Availability Zones. However, if a disaster occurs in one part of the Region, they are distant enough to reduce the chance that multiple Availability Zones are affected.

## Running Amazon EC2 instances in multiple Availability Zones

### **Amazon EC2 instance in a single Availability Zone**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/vSjn8zX0Q3-o5_M19LN_lQ_c22a27a045cb46a59fd0c5f681b5ffc4_AZ2.png?expiry=1720310400000&hmac=ztGYTM78zQllyQmTm9dULzOrf74f_iaG2jMgrzAWAZc)

Suppose that you’re running an application on a single Amazon EC2 instance in the Northern California Region. The instance is running in the us-west-1a Availability Zone. If us-west-1a were to fail, you would lose your instance. 

### **Amazon EC2 instances in multiple Availability Zones**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/ezjWgJXgS9241oCV4Fvd4w_baab4f6f87dc4c76b32c187348a2281d_AZ3.png?expiry=1720310400000&hmac=1VgRv0rZrMWsmNwp3ezhKMFTV2tNYKa7RIl30RV-_QI)

A best practice is to run applications across at least two Availability Zones in a Region. In this example, you might choose to run a second Amazon EC2 instance in us-west-1b.

### **Availability Zone failure**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/2MzaxFyuTOOM2sRcrhzjkA_f927f8e6b5e744bc8f19d05ba2759d25_AZ4.png?expiry=1720310400000&hmac=tqDGFCRE1KK4Cv_yodv9yTtikOoXxJHDFrzbieTDGmY)

If us-west-1a were to fail, your application would still be running in us-west-1b.
# Edge Locations
An **edge location** is a site that Amazon CloudFront uses to store cached copies of your content closer to your customers for faster delivery.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/-a9Jewz_SECvSXsM_4hArA_e79997e9255644d3ac232ea0bc3c5598_EdgeLocations1.png?expiry=1720310400000&hmac=Rspcijt3rjyoPalZc2qxme10dBRS-4rW5XfCwERuwQA)

### **Origin** 

Suppose that your company’s data is stored in Brazil, and you have customers who live in China. To provide content to these customers, you don’t need to move all the content to one of the Chinese Regions.

### **Edge Location**

Instead of requiring your customers to get their data from Brazil, you can cache a copy locally at an edge location that is close to your customers in China.

### **Customer**

When a customer in China requests one of your files, Amazon CloudFront retrieves the file from the cache in the edge location and delivers the file to the customer. The file is delivered to the customer faster because it came from the edge location near China instead of the original source in Brazil.

# Ways to Interact with AWS Services

### **AWS Management Console**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/hF4BjX0NSgaeAY19DeoGRg_ee2edbfb776b4a28ab3930a9d53bec8f_Ways-to-interact1.png?expiry=1720310400000&hmac=KL0gTUqMcxoWqyr4YZf6Aooek7wKJqHU54gGnE6pUK8)

The **AWS Management Console** is a web-based interface for accessing and managing AWS services. You can quickly access recently used services and search for other services by name, keyword, or acronym. The console includes wizards and automated workflows that can simplify the process of completing tasks. You can also use the AWS Console mobile application to perform tasks such as monitoring resources, viewing alarms, and accessing billing information. Multiple identities can stay logged into the AWS Console mobile app at the same time.

### **AWS Command Line Interface**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/bz4GteTiSZO-BrXk4nmTzA_f210f1b2c5d34d91850ff7ec52aebe05_Ways-to-interact2.png?expiry=1720310400000&hmac=qeS2LzGGpGM1a-UC_l0LPvouv6PUFDvy0FuOMj2pmkY)

To save time when making API requests, you can use the **AWS Command Line Interface (AWS CLI)**. AWS CLI enables you to control multiple AWS services directly from the command line within one tool. AWS CLI is available for users on Windows, macOS, and Linux. 

By using AWS CLI, you can automate the actions that your services and applications perform through scripts. For example, you can use commands to launch an Amazon EC2 instance, connect an Amazon EC2 instance to a specific Auto Scaling group, and more.

### **Software development kits (SDKs)**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/elP4JbJ5RqiT-CWyeUaopw_9954e0abfd7547ba8001a55c3996dca4_Ways-to-interact3.png?expiry=1720310400000&hmac=zDGDLVrnpF8fiwyqciBbOZxbC9mZPIjVIo1OaudNL2A)

Another option for accessing and managing AWS services is the **software development kits (SDKs)**. SDKs make it easier for you to use AWS services through an API designed for your programming language or platform. SDKs enable you to use AWS services with your existing applications or create entirely new applications that will run on AWS.

To help you get started with using SDKs, AWS provides documentation and sample code for each supported programming language. Supported programming languages include C++, Java, .NET, and more.
# AWS Elastic Beanstalk and AWS CloudFormation

### **AWS Elastic Beanstalk**

With **AWS Elastic Beanstalk**, you provide code and configuration settings, and Elastic Beanstalk deploys the resources necessary to perform the following tasks:

- Adjust capacity
    
- Load balancing
    
- Automatic scaling
    
- Application health monitoring
    

### **AWS CloudFormation**

With **AWS CloudFormation**, you can treat your infrastructure as code. This means that you can build an environment by writing lines of code instead of using the AWS Management Console to individually provision resources.

AWS CloudFormation provisions your resources in a safe, repeatable manner, enabling you to frequently build your infrastructure and applications without having to perform manual actions or write custom scripts. It determines the right operations to perform when managing your stack and rolls back changes automatically if it detects errors.


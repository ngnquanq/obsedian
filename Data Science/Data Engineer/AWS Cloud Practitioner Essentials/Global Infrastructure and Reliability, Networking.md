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
# Connectivity to AWS
### **Amazon Virtual Private Cloud (Amazon VPC)**

Imagine the millions of customers who use AWS services. Also, imagine the millions of resources that these customers have created, such as Amazon EC2 instances. Without boundaries around all of these resources, network traffic would be able to flow between them unrestricted. 

A networking service that you can use to establish boundaries around your AWS resources is [**Amazon Virtual Private Cloud (Amazon VPC)**](https://aws.amazon.com/vpc/)

.

Amazon VPC enables you to provision an isolated section of the AWS Cloud. In this isolated section, you can launch resources in a virtual network that you define. Within a virtual private cloud (VPC), you can organize your resources into subnets. A **subnet** is a section of a VPC that can contain resources such as Amazon EC2 instances.

### **Internet gateway**

To allow public traffic from the internet to access your VPC, you attach an **internet gateway** to the VPC.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/JtigqyfVR7iYoKsn1ee4sQ_69b244acd3f04813bc2c997b9d7d83cd_Internet_gateway.png?expiry=1720396800000&hmac=xiO3S77m8jRMH4XSD3CMeYixNE6C8PwWXBhQEwWAxIc)

An internet gateway is a connection between a VPC and the internet. You can think of an internet gateway as being similar to a doorway that customers use to enter the coffee shop. Without an internet gateway, no one can access the resources within your VPC.

## What if you have a VPC that includes only private resources?

### **Virtual private gateway**

Here’s an example of how a virtual private gateway works. You can think of the internet as the road between your home and the coffee shop. Suppose that you are traveling on this road with a bodyguard to protect you. You are still using the same road as other customers, but with an extra layer of protection. 

The bodyguard is like a virtual private network (VPN) connection that encrypts (or protects) your internet traffic from all the other requests around it. 

The virtual private gateway is the component that allows protected internet traffic to enter into the VPC. Even though your connection to the coffee shop has extra protection, traffic jams are possible because you’re using the same road as other customers. 

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/m7JWN_MlRBWyVjfzJfQV2w_d5d7e759f59c44ff891fe9d062603fe7_Virtual-Private-Gateway.png?expiry=1720396800000&hmac=P0bHfSfhDBscwZ4FSfb8ZaQFXOCYTEE6SQnysKImvFs)

A virtual private gateway enables you to establish a virtual private network (VPN) connection between your VPC and a private network, such as an on-premises data center or internal corporate network. A virtual private gateway allows traffic into the VPC only if it is coming from an approved network.

### **AWS Direct Connect**

[**AWS Direct Connect**](https://aws.amazon.com/directconnect/)

 is a service that enables you to establish a dedicated private connection between your data center and a VPC.  

Suppose that there is an apartment building with a hallway directly linking the building to the coffee shop. Only the residents of the apartment building can travel through this hallway. 

This private hallway provides the same type of dedicated connection as AWS Direct Connect. Residents are able to get into the coffee shop without needing to use the public road shared with other customers. 

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/h3jOQrMiSDy4zkKzIog8ew_efdbade19174425b85b6566bbb6579da_AWS-Direct-Connect.png?expiry=1720396800000&hmac=niINduVbWzGBfyOFBrZZ1OS8_wNJm2sJTsnCy63L_jQ)

The private connection that AWS Direct Connect provides helps you to reduce network costs and increase the amount of bandwidth that can travel through your network.

# Subnets and Network Access Control Lists

To learn more about the role of subnets within a VPC, review the following example from the coffee shop.

First, customers give their orders to the cashier. The cashier then passes the orders to the barista. This process allows the line to keep running smoothly as more customers come in. 

Suppose that some customers try to skip the cashier line and give their orders directly to the barista. This disrupts the flow of traffic and results in customers accessing a part of the coffee shop that is restricted to them.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/MJ6yxntdTkOessZ7Xa5Dnw_8f7936d9be1e41ca8015e889a4c6dde4_Subnets1.png?expiry=1720396800000&hmac=7HgPQen4eci5JJhbOtXCB0HTPDIEXMm3Z6GRYSdbi0M)

To fix this, the owners of the coffee shop divide the counter area by placing the cashier and the barista in separate workstations. The cashier’s workstation is public facing and designed to receive customers. The barista’s area is private. The barista can still receive orders from the cashier but not directly from customers.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/Cfw9Y8p3QNG8PWPKd8DRVg_395dce6a4fe94a37a6a1343f82d5418e_Subnets2.png?expiry=1720396800000&hmac=MLcTwcQL5bKlCyck4TQUVUNU2jA50c6N-0gopJsCG6A)

This is similar to how you can use AWS networking services to isolate resources and determine exactly how network traffic flows.

In the coffee shop, you can think of the counter area as a VPC. The counter area divides into two separate areas for the cashier’s workstation and the barista’s workstation. In a VPC, **subnets** are separate areas that are used to group together resources.

### **Subnets**

A subnet is a section of a VPC in which you can group resources based on security or operational needs. Subnets can be public or private. 

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/IuYyEivXQXemMhIr17F3qg_3d5d4c825541434f8407e33d7048d9e3_Subnets3.png?expiry=1720396800000&hmac=-6382ntx7H1UGJb1ylopZbGTYmb75tCtPW8JC3J_v00)

**Public subnets** contain resources that need to be accessible by the public, such as an online store’s website.

**Private subnets** contain resources that should be accessible only through your private network, such as a database that contains customers’ personal information and order histories. 

In a VPC, subnets can communicate with each other. For example, you might have an application that involves Amazon EC2 instances in a public subnet communicating with databases that are located in a private subnet.

### **Network Traffic in a VPC**

When a customer requests data from an application hosted in the AWS Cloud, this request is sent as a packet. A **packet** is a unit of data sent over the internet or a network. 

It enters into a VPC through an internet gateway. Before a packet can enter into a subnet or exit from a subnet, it checks for permissions. These permissions indicate who sent the packet and how the packet is trying to communicate with the resources in a subnet.

The VPC component that checks packet permissions for subnets is a [**network access control list (ACL)**](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)

.

### **Network Access Control Lists (ACLs)**

A network access control list (ACL) is a virtual firewall that controls inbound and outbound traffic at the subnet level.

For example, step outside of the coffee shop and imagine that you are in an airport. In the airport, travelers are trying to enter into a different country. You can think of the travelers as packets and the passport control officer as a network ACL. The passport control officer checks travelers’ credentials when they are both entering and exiting out of the country. If a traveler is on an approved list, they are able to get through. However, if they are not on the approved list or are explicitly on a list of banned travelers, they cannot come in.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/zalo09JzRtSpaNPSc3bUzg_1a33ef5c42294d678b633f023cad0357_ACLs.png?expiry=1720396800000&hmac=GD7WRIUZYFNtirADIxYAV_txd4Z43mdPpH-HcCFwcj8)

Each AWS account includes a default network ACL. When configuring your VPC, you can use your account’s default network ACL or create custom network ACLs. 

By default, your account’s default network ACL allows all inbound and outbound traffic, but you can modify it by adding your own rules. For custom network ACLs, all inbound and outbound traffic is denied until you add rules to specify which traffic to allow. Additionally, all network ACLs have an explicit deny rule. This rule ensures that if a packet doesn’t match any of the other rules on the list, the packet is denied. 

### **Stateless Packet Filtering**

Network ACLs perform **stateless** packet filtering. They remember nothing and check packets that cross the subnet border each way: inbound and outbound. 

Recall the previous example of a traveler who wants to enter into a different country. This is similar to sending a request out from an Amazon EC2 instance and to the internet.

When a packet response for that request comes back to the subnet, the network ACL does not remember your previous request. The network ACL checks the packet response against its list of rules to determine whether to allow or deny.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/IT1vh3SMRZG9b4d0jEWRpw_c64f09027a6a4e75b868128e6838ed81_stateless.png?expiry=1720396800000&hmac=yH3uLtN_vWtxIjOUBS2q3jDKDXtsu-c13Bn6ZZL0KCg)

After a packet has entered a subnet, it must have its permissions evaluated for resources within the subnet, such as Amazon EC2 instances. 

The VPC component that checks packet permissions for an Amazon EC2 instance is a [**security group**](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

.

### **Security Groups**

A security group is a virtual firewall that controls inbound and outbound traffic for an Amazon EC2 instance.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/XhV_f1ibSYyVf39Ym-mMYg_beeffd478d4341a59c0dbd6c3875df86_Security-groups.png?expiry=1720396800000&hmac=b_YG_J0Cvkrp3YZW2sbLHT42yxSouLDT4f2fkmrVpNk)

By default, a security group denies all inbound traffic and allows all outbound traffic. You can add custom rules to configure which traffic to allow or deny.

For this example, suppose that you are in an apartment building with a door attendant who greets guests in the lobby. You can think of the guests as packets and the door attendant as a security group. As guests arrive, the door attendant checks a list to ensure they can enter the building. However, the door attendant does not check the list again when guests are exiting the building

If you have multiple Amazon EC2 instances within a subnet, you can associate them with the same security group or use different security groups for each instance. 

### **Stateful Packet Filtering**

Security groups perform **stateful** packet filtering. They remember previous decisions made for incoming packets.

Consider the same example of sending a request out from an Amazon EC2 instance to the internet. 

When a packet response for that request returns to the instance, the security group remembers your previous request. The security group allows the response to proceed, regardless of inbound security group rules.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/HSQHiuCoR3WkB4rgqJd1pA_a832a55bf8b24f358ac0a2e7c2504239_Stateful.png?expiry=1720396800000&hmac=SiAEedRA0XO8VOOBx23vDETJXttFYh3BHSdL4l6gz6M)

Both network ACLs and security groups enable you to configure custom rules for the traffic in your VPC. As you continue to learn more about AWS security and networking, make sure to understand the differences between network ACLs and security groups.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/ULa-zH4MTHq2vsx-DPx6xg_75ffd32fc93b4897812bb144d3a51176_stateful2.png?expiry=1720396800000&hmac=f7y3a7mAkXLM24KsSxy-_3e8RkmHYwjx5Z7GA3vPYuU)
 
# Global Networking

### **Domain Name System (DNS)**

Suppose that AnyCompany has a website hosted in the AWS Cloud. Customers enter the web address into their browser, and they are able to access the website. This happens because of **Domain Name System (DNS)** resolution. DNS resolution involves a DNS server communicating with a web server.

You can think of DNS as being the phone book of the internet. DNS resolution is the process of translating a domain name to an IP address. 

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/nIVOzpcgQnqFTs6XIAJ6kw_40390dcbe8cc4598a9c77dba6aacb862_global-networking.png?expiry=1720396800000&hmac=rWg90UMzI1yBNPsOM_5nYTbnEFnoHsFMLX5JQr3KgMY)

For example, suppose that you want to visit AnyCompany’s website. 

1. When you enter the domain name into your browser, this request is sent to a DNS server. 
    
2. The DNS server asks the web server for the IP address that corresponds to AnyCompany’s website.
    
3. The web server responds by providing the IP address for AnyCompany’s website, 192.0.2.0.
    

### **Amazon Route 53**

[**Amazon Route 53**](https://aws.amazon.com/route53)

 is a DNS web service. It gives developers and businesses a reliable way to route end users to internet applications hosted in AWS. 

Amazon Route 53 connects user requests to infrastructure running in AWS (such as Amazon EC2 instances and load balancers). It can route users to infrastructure outside of AWS.

Another feature of Route 53 is the ability to manage the DNS records for domain names. You can register new domain names directly in Route 53. You can also transfer DNS records for existing domain names managed by other domain registrars. This enables you to manage all of your domain names within a single location.

In the previous module, you learned about Amazon CloudFront, a content delivery service. The following example describes how Route 53 and Amazon CloudFront work together to deliver content to customers.

### **Example: How Amazon Route 53 and Amazon CloudFront deliver content**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/_U7EaNoSQuqOxGjaEhLqeg_303dd3fef2024ca1b8036096537913ff_global-networking2.png?expiry=1720396800000&hmac=ejachcqIuBp2WLSEoyIJPgO5YVDQoxowHqhEhncrsvY)

Suppose that AnyCompany’s application is running on several Amazon EC2 instances. These instances are in an Auto Scaling group that attaches to an Application Load Balancer. 

1. A customer requests data from the application by going to AnyCompany’s website. 
    
2. Amazon Route 53 uses DNS resolution to identify AnyCompany.com’s corresponding IP address, 192.0.2.0. This information is sent back to the customer. 
    
3. The customer’s request is sent to the nearest edge location through Amazon CloudFront. 
    
4. Amazon CloudFront connects to the Application Load Balancer, which sends the incoming packet to an Amazon EC2 instance.


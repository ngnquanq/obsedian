# Amazon CloudWatch
### **Amazon CloudWatch**

[**Amazon CloudWatch**](https://aws.amazon.com/cloudwatch/)

 is a web service that enables you to monitor and manage various metrics and configure alarm actions based on data from those metrics.

CloudWatch uses [**metrics**](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html)

 to represent the data points for your resources. AWS services send metrics to CloudWatch. CloudWatch then uses these metrics to create graphs automatically that show how performance has changed over time. 

### **CloudWatch Alarms**

With CloudWatch, you can create [**alarms**](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)

 that automatically perform actions if the value of your metric has gone above or below a predefined threshold. 

For example, suppose that your company’s developers use Amazon EC2 instances for application development or testing purposes. If the developers occasionally forget to stop the instances, the instances will continue to run and incur charges. 

In this scenario, you could create a CloudWatch alarm that automatically stops an Amazon EC2 instance when the CPU utilization percentage has remained below a certain threshold for a specified period. When configuring the alarm, you can specify to receive a notification whenever this alarm is triggered.

### **CloudWatch Dashboard**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/Eo-CyAH_RqePgsgB_3anXQ_024f30d001cc4e6caa850f474e1e7b6a_CloudWatch-Dashboard.png?expiry=1720569600000&hmac=4DfjQFXpqE_fRDWad88UyhWCXGQYaiMruMI9CUPqeos)

The CloudWatch [**dashboard**](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html)

 feature enables you to access all the metrics for your resources from a single location. For example, you can use a CloudWatch dashboard to monitor the CPU utilization of an Amazon EC2 instance, the total number of requests made to an Amazon S3 bucket, and more. You can even customize separate dashboards for different business purposes, applications, or resources.
# AWS CloudTrail
### **AWS CloudTrail**

[**AWS CloudTrail**](https://aws.amazon.com/cloudtrail/)

 records API calls for your account. The recorded information includes the identity of the API caller, the time of the API call, the source IP address of the API caller, and more. You can think of CloudTrail as a “trail” of breadcrumbs (or a log of actions) that someone has left behind them.

Recall that you can use API calls to provision, manage, and configure your AWS resources. With CloudTrail, you can view a complete history of user activity and API calls for your applications and resources. 

Events are typically updated in CloudTrail within 15 minutes after an API call. You can filter events by specifying the time and date that an API call occurred, the user who requested the action, the type of resource that was involved in the API call, and more.

### **Example: AWS CloudTrail Event**

Suppose that the coffee shop owner is browsing through the AWS Identity and Access Management (IAM) section of the AWS Management Console. They discover that a new IAM user named Mary was created, but they do not who, when, or which method created the user.

To answer these questions, the owner navigates to AWS CloudTrail.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/Z5Fe-ggMQn2RXvoIDHJ9aQ_91b0299eb8e04b23bfa23c1059e70c1c_CloudTrail.png?expiry=1720569600000&hmac=FaH5igsz1U8NdNLNHawofdUCqJ_4vzzFaZUJh3IlTr4)

In the CloudTrail Event History section, the owner applies a filter to display only the events for the “CreateUser” API action in IAM. The owner locates the event for the API call that created an IAM user for Mary. This event record provides complete details about what occurred: 

On January 1, 2020 at 9:00 AM, IAM user John created a new IAM user (Mary) through the AWS Management Console.

### **CloudTrail Insights**

Within CloudTrail, you can also enable [**CloudTrail Insights**](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-insights-events-with-cloudtrail.html)

. This optional feature allows CloudTrail to automatically detect unusual API activities in your AWS account. 

For example, CloudTrail Insights might detect that a higher number of Amazon EC2 instances than usual have recently launched in your account. You can then review the full event details to determine which actions you need to take next.

# AWS Trusted Advisor

### **AWS Trusted Advisor**

[**AWS Trusted Advisor**](https://aws.amazon.com/premiumsupport/technology/trusted-advisor/)

 is a web service that inspects your AWS environment and provides real-time recommendations in accordance with AWS best practices.

Trusted Advisor compares its findings to AWS best practices in five categories: cost optimization, performance, security, fault tolerance, and service limits. For the checks in each category, Trusted Advisor offers a list of recommended actions and additional resources to learn more about AWS best practices. 

The guidance provided by AWS Trusted Advisor can benefit your company at all stages of deployment. For example, you can use AWS Trusted Advisor to assist you while you are creating new workflows and developing new applications. Or you can use it while you are making ongoing improvements to existing applications and resources.

### **AWS Trusted Advisor Dashboard**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/Is4jCetfRgCOIwnrX9YA5Q_9c6ff9d5d3bc4636b004614d17198a8b_AWS-Trusted-Advisor.jpg?expiry=1720569600000&hmac=RNh2wAzJa6djjblXImWrlsclLDB28sqST-ktJgEg67w)

When you access the Trusted Advisor dashboard on the AWS Management Console, you can review completed checks for cost optimization, performance, security, fault tolerance, and service limits.

For each category:

- The green check indicates the number of items for which it detected **no problems**.
    
- The orange triangle represents the number of recommended **investigations**.
    
- The red circle represents the number of recommended **actions**.

# Pricing and Support
# AWS Free Tier

### **AWS Free Tier**

The [AWS Free Tier](https://aws.amazon.com/free/)

 enables you to begin using certain services without having to worry about incurring costs for the specified period. 

Three types of offers are available: 

- Always Free
    
- 12 Months Free
    
- Trials
    

For each free tier offer, make sure to review the specific details about exactly which resource types are included. 

### **Always Free**

These offers do not expire and are available to all AWS customers.

For example, AWS Lambda allows 1 million free requests and up to 3.2 million seconds of compute time per month. Amazon DynamoDB allows 25 GB of free storage per month.

### **12 Months Free**

These offers are free for 12 months following your initial sign-up date to AWS.

Examples include specific amounts of Amazon S3 Standard Storage, thresholds for monthly hours of Amazon EC2 compute time, and amounts of Amazon CloudFront data transfer out.

### **Trials**

Short-term free trial offers start from the date you activate a particular service. The length of each trial might vary by number of days or the amount of usage in the service.

For example, Amazon Inspector offers a 90-day free trial. Amazon Lightsail (a service that enables you to run virtual private servers) offers 750 free hours of usage over a 30-day period.
# AWS Pricing Concepts

### **How AWS Pricing Works**

AWS offers a range of cloud computing services with pay-as-you-go pricing. 

### **Pay for what you use.**

For each service, you pay for exactly the amount of resources that you actually use, without requiring long-term contracts or complex licensing. 

### **Pay less when you reserve.**

Some services offer reservation options that provide a significant discount compared to On-Demand Instance pricing.

For example, suppose that your company is using Amazon EC2 instances for a workload that needs to run continuously. You might choose to run this workload on Amazon EC2 Instance Savings Plans, because the plan allows you to save up to 72% over the equivalent On-Demand Instance capacity.

### **Pay less with volume-based discounts when you use more.**

Some services offer tiered pricing, so the per-unit cost is incrementally lower with increased usage.

For example, the more Amazon S3 storage space you use, the less you pay for it per GB.

### **AWS Pricing Calculator**

The [**AWS Pricing Calculator**](https://calculator.aws/#/)

 lets you explore AWS services and create an estimate for the cost of your use cases on AWS. You can organize your AWS estimates by groups that you define. A group can reflect how your company is organized, such as providing estimates by cost center.

When you have created an estimate, you can save it and generate a link to share it with others.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/1_4r7Di5TIW-K-w4ueyFxg_f05d6ae0a6934c0abcb54a0647d98285_AWS-Pricing-Calculator.jpg?expiry=1720569600000&hmac=bxpSjKOgjvaeZgxFdjl6jg-8e7v3vMVReyrHbdaLX8o)

Suppose that your company is interested in using Amazon EC2. However, you are not yet sure which AWS Region or instance type would be the most cost-efficient for your use case. In the AWS Pricing Calculator, you can enter details such as the kind of operating system you need, memory requirements, and input/output (I/O) requirements. By using the AWS Pricing Calculator, you can review an estimated comparison of different EC2 instance types across AWS Regions.

### **AWS Pricing Examples**

This section presents a few examples of pricing in AWS services. 

### **AWS Lambda Pricing**

For AWS Lambda, you are charged based on the number of requests for your functions and the time that it takes for them to run.

AWS Lambda allows 1 million free requests and up to 3.2 million seconds of compute time per month.

You can save on AWS Lambda costs by signing up for a Compute Savings Plan. A Compute Savings Plan offers lower compute costs in exchange for committing to a consistent amount of usage over a 1-year or 3-year term. This is an example of **paying less when you reserve**. 

### **AWS Lambda Pricing Example**

If you have used AWS Lambda in multiple AWS Regions, you can view the itemized charges by Region on your bill. 

In this example, all the AWS Lambda usage occurred in the Northern Virginia Region. The bill lists separate charges for the number of requests for functions and their duration. 

Both the number of requests and the total duration of requests in this example are under the thresholds in the AWS Free Tier, so the account owner would not have to pay for any AWS Lambda usage in this month.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/Sd3ISSepQ3edyEknqUN3gA_3932c9cf31e14427ba12db01afe0d90a_AWS-Lambda-Pricing.png?expiry=1720569600000&hmac=-udhpo0gvmCB43-ffkWyjY7U-zSx-RO1pji8dpatwJc)

### **Amazon EC2 Pricing**

With Amazon EC2, you pay for only the compute time that you use while your instances are running.

For some workloads, you can significantly reduce Amazon EC2 costs by using Spot Instances. For example, suppose that you are running a batch processing job that is able to withstand interruptions. Using a Spot Instance would provide you with up to 90% cost savings while still meeting the availability requirements of your workload.

You can find additional cost savings for Amazon EC2 by considering Savings Plans and Reserved Instances.

### **Amazon EC2 Pricing Example**

The service charges in this example include details for the following items:

- Each Amazon EC2 instance type that has been used
    
- The amount of Amazon EBS storage space that has been provisioned
    
- The length of time that Elastic Load Balancing has been used
    

In this example, all the usage amounts are under the thresholds in the AWS Free Tier, so the account owner would not have to pay for any Amazon EC2 usage in this month.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/ba1z7ug4Sqmtc-7oOGqpmQ_9f9f744c54dd4ae69efcdce3f04427d3_Amazon-EC2-Pricing-Example.png?expiry=1720569600000&hmac=5asvefd3WIfgr-55tpHSAaTtPjOzxgxScHsSxP9I3mk)

### **Amazon S3 Pricing**

For Amazon S3 pricing, consider the following cost components:

- **Storage -** You pay for only the storage that you use. You are charged the rate to store objects in your Amazon S3 buckets based on your objects’ sizes, storage classes, and how long you have stored each object during the month.
    
- **Requests and data retrievals -** You pay for requests made to your Amazon S3 objects and buckets. For example, suppose that you are storing photo files in Amazon S3 buckets and hosting them on a website. Every time a visitor requests the website that includes these photo files, this counts towards requests you must pay for.
    
- **Data transfer -** There is no cost to transfer data between different Amazon S3 buckets or from Amazon S3 to other services within the same AWS Region. However, you pay for data that you transfer into and out of Amazon S3, with a few exceptions. There is no cost for data transferred into Amazon S3 from the internet or out to Amazon CloudFront. There is also no cost for data transferred out to an Amazon EC2 instance in the same AWS Region as the Amazon S3 bucket.
    
- **Management and replication -** You pay for the storage management features that you have enabled on your account’s Amazon S3 buckets. These features include Amazon S3 inventory, analytics, and object tagging.
    

### **Amazon S3 Pricing Example**

The AWS account in this example has used Amazon S3 in two Regions: Northern Virginia and Ohio. For each Region, itemized charges are based on the following factors:

- The number of requests to add or copy objects into a bucket
    
- The number of requests to retrieve objects from a bucket
    
- The amount of storage space used
    

All the usage for Amazon S3 in this example is under the AWS Free Tier limits, so the account owner would not have to pay for any Amazon S3 usage in this month.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/9IgnMeN3RfqIJzHjd8X6Gw_a465a014a6894349be8d95144cc950f2_Amazon-S3-Pricing-Example.png?expiry=1720569600000&hmac=3BRGqR7aO3BaiOR9k-6zSRAOHnYEZGfHf8-cEXSt9mc)

# Billing Dashboard

Use the [**AWS Billing & Cost Management dashboard**](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-what-is.html)

 to pay your AWS bill, monitor your usage, and analyze and control your costs.

- Compare your current month-to-date balance with the previous month, and get a forecast of the next month based on current usage.
    
- View month-to-date spend by service.
    
- View Free Tier usage by service.
    
- Access Cost Explorer and create budgets.
    
- Purchase and manage Savings Plans.
    
- Publish [AWS Cost and Usage Reports](https://docs.aws.amazon.com/cur/latest/userguide/what-is-cur.html)
# Consolidated Billing

In an earlier module, you learned about AWS Organizations, a service that enables you to manage multiple AWS accounts from a central location. AWS Organizations also provides the option for [**consolidated billing**](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/consolidated-billing.html)

. 

The consolidated billing feature of AWS Organizations enables you to receive a single bill for all AWS accounts in your organization. By consolidating, you can easily track the combined costs of all the linked accounts in your organization. The default maximum number of accounts allowed for an organization is 4, but you can contact AWS Support to increase your quota, if needed.

On your monthly bill, you can review itemized charges incurred by each account. This enables you to have greater transparency into your organization’s accounts while still maintaining the convenience of receiving a single monthly bill.

Another benefit of consolidated billing is the ability to share bulk discount pricing, Savings Plans, and Reserved Instances across the accounts in your organization. For instance, one account might not have enough monthly usage to qualify for discount pricing. However, when multiple accounts are combined, their aggregated usage may result in a benefit that applies across all accounts in the organization.

### **Example: Consolidated Billing**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/5PYbtBAESS-2G7QQBHkv-w_fd2ad6d08d9c4fa28021d16734599f2c_Consolidated-Billing-1.png?expiry=1720569600000&hmac=9nxy07K0sAmi9rSVxrbJyzt9wFlCeVKsrD2ajBSz8Pw)

Suppose that you are the business leader who oversees your company’s AWS billing. 

Your company has three AWS accounts used for separate departments. Instead of paying each location’s monthly bill separately, you decide to create an organization and add the three accounts. 

You manage the organization through the primary account.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/3YzlJmCtQI-M5SZgrdCPnQ_1484c593e154498a96dbc0cda86222d6_Consolidated-Billing-2.png?expiry=1720569600000&hmac=b34mTDSJLEQdA90Cmy523YFB6sgO2p7laHtg3A_YzU8)

Each month, AWS charges your primary payer account for all the linked accounts in a consolidated bill. Through the primary account, you can also get a detailed cost report for each linked account. 

The monthly consolidated bill also includes the account usage costs incurred by the primary account. This cost is not a premium charge for having a primary account. 

The consolidated bill shows the costs associated with any actions of the primary account (such as storing files in Amazon S3 or running Amazon EC2 instances).

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/_Q9N68PASbePTevDwAm3pw_83b0b6352ec74be08317974c6f8921a3_Consolidated-Billing-3.png?expiry=1720569600000&hmac=4Us_aMwQEoflsHRnkG3ykkaG3i0YIamgMMzDDbSR3sc)

Consolidated billing also enables you to share volume pricing discounts across accounts. 

Some AWS services, such as Amazon S3, provide volume pricing discounts that give you lower prices the more that you use the service. In Amazon S3, after customers have transferred 10 TB of data in a month, they pay a lower per-GB transfer price for the next 40 TB of data transferred. 

In this example, there are three separate AWS accounts that have transferred different amounts of data in Amazon S3 during the current month: 

- Account 1 has transferred 2 TB of data.
    
- Account 2 has transferred 5 TB of data.
    
- Account 3 has transferred 7 TB of data.
    

Because no single account has passed the 10 TB threshold, none of them is eligible for the lower per-GB transfer price for the next 40 TB of data transferred.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/PO8RgP-QQYevEYD_kPGHSg_d1ef0f6ef69e49aea14c24db96063a05_Consolidated-Billing-4.png?expiry=1720569600000&hmac=PjHSBevQSZMZ1tmfxZGxHH3JDGLVszFgHXpvWWXQQrs)

Now, suppose that these three separate accounts are brought together as linked accounts within a single AWS organization and are using consolidated billing.

When the Amazon S3 usage for the three linked accounts is combined (2+5+7), this results in a combined data transfer amount of 14 TB. This exceeds the 10-TB threshold. 

With consolidated billing, AWS combines the usage from all accounts to determine which volume pricing tiers to apply, giving you a lower overall price whenever possible. AWS then allocates each linked account a portion of the overall volume discount based on the account's usage. 

In this example, Account 3 would receive a greater portion of the overall volume discount because at 7 TB, it has transferred more data than Account 1 (at 2 TB) and Account 2 (at 5 TB).

# AWS Budgets

### **AWS Budgets**

In [**AWS Budgets**](https://aws.amazon.com/aws-cost-management/aws-budgets)

, you can create budgets to plan your service usage, service costs, and instance reservations.

The information in AWS Budgets updates three times a day. This helps you to accurately determine how close your usage is to your budgeted amounts or to the AWS Free Tier limits.

In AWS Budgets, you can also set custom alerts when your usage exceeds (or is forecasted to exceed) the budgeted amount.

### **Example: AWS Budgets**

Suppose that you have set a budget for Amazon EC2. You want to ensure that your company’s usage of Amazon EC2 does not exceed $200 for the month. 

In AWS Budgets, you could set a custom budget to notify you when your usage has reached half of this amount ($100). This setting would allow you to receive an alert and decide how you would like to proceed with your continued use of Amazon EC2.

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/jT5ZQ1nIRFm-WUNZyIRZzg_7d0676d303d74e5aa7d14012b1c44611_AWS-Budgets.jpg?expiry=1720569600000&hmac=N5NXvBlISn1srg_ZgTeJjaOUxITn9kqcgbIjkOZ5JUw)

In this sample budget, you can review the following important details:

- The current amount that you have incurred for Amazon EC2 so far this month ($136.90)
    
- The amount that you are forecasted to spend for the month ($195.21), based on your usage patterns.
    

You can also review comparisons of your current vs. budgeted usage, and forecasted vs. budgeted usage. 

For example, in the top row of this sample budget, the forecasted vs. budgeted bar is at 125.17%. The reason for the increase is that the forecasted amount ($56.33) exceeds the amount that had been budgeted for that item for the month ($45.00).
# AWS Cost Explorer

### **AWS Cost Explorer**

[**AWS Cost Explorer**](https://aws.amazon.com/aws-cost-management/aws-cost-explorer/)

 is a tool that enables you to visualize, understand, and manage your AWS costs and usage over time.

AWS Cost Explorer includes a default report of the costs and usage for your top five cost-accruing AWS services. You can apply custom filters and groups to analyze your data. For example, you can view resource usage at the hourly level.

### **Example: AWS Cost Explorer**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/OfnSSQmuROa50kkJroTm9A_bb2570b358bc411c8f23f8bb5430a099_AWS-Cost-Explorer.png?expiry=1720569600000&hmac=9942gsLy0x-peQM9OQiodjLY_DmEoDJ0l4uWM51QqnY)

This example of the AWS Cost Explorer dashboard displays monthly costs for Amazon EC2 instances over a 6-month period. The bar for each month separates the costs for different Amazon EC2 instance types (such as t2.micro or m3.large). 

By analyzing your AWS costs over time, you can make informed decisions about future costs and how to plan your budgets.
# AWS Support Plans

### **AWS Support**

AWS offers four different [**Support plans**](https://aws.amazon.com/premiumsupport/plans/)

 to help you troubleshoot issues, lower costs, and efficiently use AWS services. 

You can choose from the following Support plans to meet your company’s needs: 

- Basic
    

- Developer
    

- Business
    
- Enterprise On-Ramp
    

- Enterprise
    

### **Basic Support**

**Basic Support** is free for all AWS customers. It includes access to whitepapers, documentation, and support communities. With Basic Support, you can also contact AWS for billing questions and service limit increases.

With Basic Support, you have access to a limited selection of AWS Trusted Advisor checks. Additionally, you can use the **AWS Personal Health Dashboard**, a tool that provides alerts and remediation guidance when AWS is experiencing events that may affect you. 

If your company needs support beyond the Basic level, you could consider purchasing Developer, Business, Enterprise On-Ramp, or Enterprise Support.

### **Developer, Business,** Enterprise On-Ramp, **and Enterprise Support**

The Developer, Business, Enterprise On-Ramp, and Enterprise Support plans include all the benefits of Basic Support, in addition to the ability to open an unrestricted number of technical support cases. These three Support plans have pay-by-the-month pricing and require no long-term contracts.

The information in this course highlights only a selection of details for each Support plan. A complete overview of what is included in each Support plan, including pricing for each plan, is available on the [AWS Support](https://aws.amazon.com/premiumsupport/plans/)

 site.

In general, for pricing, the Developer plan has the lowest cost, the Business and Enterprise On-Ramp plans are in the middle, and the Enterprise plan has the highest cost. 

### **Developer Support**

Customers in the **Developer Support** plan have access to features such as:

- Best practice guidance
    
- Client-side diagnostic tools
    
- Building-block architecture support, which consists of guidance for how to use AWS offerings, features, and services together
    

For example, suppose that your company is exploring AWS services. You’ve heard about a few different AWS services. However, you’re unsure of how to potentially use them together to build applications that can address your company’s needs. In this scenario, the building-block architecture support that is included with the Developer Support plan could help you to identify opportunities for combining specific services and features.

### **Business Support**

Customers with a **Business Support** plan have access to additional features, including: 

- Use-case guidance to identify AWS offerings, features, and services that can best support your specific needs
    
- All AWS Trusted Advisor checks
    
- Limited support for third-party software, such as common operating systems and application stack components
    

Suppose that your company has the Business Support plan and wants to install a common third-party operating system onto your Amazon EC2 instances. You could contact AWS Support for assistance with installing, configuring, and troubleshooting the operating system. For advanced topics such as optimizing performance, using custom scripts, or resolving security issues, you may need to contact the third-party software provider directly.

### **Enterprise On-Ramp Support**

In November 2021, AWS opened enrollment into AWS Enterprise On-Ramp Support plan. In addition to all the features included in the Basic, Developer, and Business Support plans, customers with an Enterprise On-Ramp Support plan have access to:

- A pool of Technical Account Managers to provide proactive guidance and coordinate access to programs and AWS experts
    
- A Cost Optimization workshop (one per year)
    
- A Concierge support team for billing and account assistance
    
- Tools to monitor costs and performance through Trusted Advisor and Health API/Dashboard
    

Enterprise On-Ramp Support plan also provides access to a specific set of proactive support services, which are provided by a pool of Technical Account Managers.

- Consultative review and architecture guidance (one per year)
    
- Infrastructure Event Management support (one per year)
    
- Support automation workflows
    
- 30 minutes or less response time for business-critical issues
    

### **Enterprise Support**

In addition to all features included in the Basic, Developer, Business, and Enterprise On-Ramp support plans, customers with Enterprise Support have access to:

- A designated Technical Account Manager to provide proactive guidance and coordinate access to programs and AWS experts
    
- A Concierge support team for billing and account assistance
    
- Operations Reviews and tools to monitor health
    
- Training and Game Days to drive innovation
    
- Tools to monitor costs and performance through Trusted Advisor and Health API/Dashboard
    

The Enterprise plan also provides full access to proactive services, which are provided by a designated Technical Account Manager:

- Consultative review and architecture guidance
    
- Infrastructure Event Management support
    
- Cost Optimization Workshop and tools
    
- Support automation workflows
    
- 15 minutes or less response time for business-critical issues
    

### **Technical Account Manager (TAM)**

The Enterprise On-Ramp and Enterprise Support plans include access to a **Technical Account Manager (TAM)**. The TAM is your primary point of contact at AWS. If your company subscribes to Enterprise Support or Enterprise On-Ramp, your TAM educates, empowers, and evolves your cloud journey across the full range of AWS services. TAMs provide expert engineering guidance, help you design solutions that efficiently integrate AWS services, assist with cost-effective and resilient architectures, and provide direct access to AWS programs and a broad community of experts. For example, suppose that you are interested in developing an application that uses several AWS services together. Your TAM could provide insights into how to best use the services together. They achieve this, while aligning with the specific needs that your company is hoping to address through the new application.

# AWS Marketplace

### **AWS Marketplace**

[**AWS Marketplace**](https://aws.amazon.com/marketplace)

 is a digital catalog that includes thousands of software listings from independent software vendors. You can use AWS Marketplace to find, test, and buy software that runs on AWS. 

For each listing in AWS Marketplace, you can access detailed information on pricing options, available support, and reviews from other AWS customers.

You can also explore software solutions by industry and use case. For example, suppose that your company is in the healthcare industry. In AWS Marketplace, you can review use cases that software helps you to address, such as implementing solutions to protect patient records or using machine learning models to analyze a patient’s medical history and predict possible health risks.

### **AWS Marketplace Categories**

![](https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/M30xtJaNQqC9MbSWjaKgOw_a4dbb5b4c69348c4a5725b7023ae65f1_Screen-Shot-2022-07-22-at-3.00.49-PM.png?expiry=1720569600000&hmac=FuJG_0au2i5w-Z7I_Q0ECWfTIM9ZH2lYhUhnC2tSGRw)

AWS Marketplace offers products in several categories, such as Infrastructure Software, DevOps, Data Products, Professional Services, Business Applications, Machine Learning, Industries, and Internet of Things (IoT).

Within each category, you can narrow your search by browsing through product listings in subcategories. For example, subcategories in the DevOps category include areas such as Application Development, Monitoring, and Testing.
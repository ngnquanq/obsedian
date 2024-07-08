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

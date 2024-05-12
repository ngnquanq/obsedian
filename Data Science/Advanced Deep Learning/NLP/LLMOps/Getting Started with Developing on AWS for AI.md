# Introduction
**Goal:**
- Hands-on
- Skill specific

**Key terms:**
- **Infrastructure-as-a-Service (IaaS)**: Low level cloud service model that provides fundamental compute, storage, networking resources. Examples on AWS: EC2, S3, VPC.
```python
import boto3

  

# Create an EC2 instance 

ec2 = boto3.resource('ec2')

instance = ec2.create_instances(

    ImageId='ami-0c55b159cbfafe1f0',

    InstanceType='t2.micro',

    MaxCount=1,

    MinCount=1

)

  

# Store file in S3 bucket

s3 = boto3.client('s3')  

s3.upload_file('data.csv', 'mybucket', 'data/data.csv')

  

# Create a VPC 

ec2 = boto3.client('ec2')

vpc = ec2.create_vpc(CidrBlock='10.0.0.0/16')
```
- Platform-as-a-Service (PaaS):Provides platforms and tools for application development, deployment, management without managing servers. Examples on AWS: Elastic Beanstalk, Lambda, AppRunner.
```python
import boto3  

  

# Deploy app on Elastic Beanstalk

elastic_beanstalk = boto3.client('elasticbeanstalk')

response = elastic_beanstalk.create_application_version(

    ApplicationName='my-app', 

    VersionLabel='v1',

    SourceBundle={

        # zipped code

    }  

)

  

# Run Lambda function 

lambda_client = boto3.client('lambda')

response = lambda_client.invoke(

    FunctionName='myfunction',

    Payload=json.dumps({

        # event data

    })

)

```

- **Software-as-a-Service (SaaS)**: Ready to use cloud applications accessed over the internet. Examples: Salesforce, Office 365, Slack.
- **Hybrid Cloud**: Combination of on-premises infrastructure with public cloud providers. Provides flexibility, security, and control.
```cmd
# Hybrid cloud uses orchestration to manage across environments 

  

# Copy data from on-prem database to S3  

aws s3 cp my_db_data s3://bucket/database_backup --recursive 

  

# Start EC2 instance to run analysis on data 

aws ec2 run-instances # etc...

  

# Copy outputs back to on-prem

aws s3 cp s3://bucket/analysis onprem_folder --recursive

```
## Cloud Service Model for AI
Trending stuffs:
![[Pasted image 20240510141317.png]]

## Cloud Deployment Model for AI
![[Pasted image 20240510142952.png]]

Choose the cloud wisely -> Lots of options are become available 

## AWS Cloud Adoption Framework for AI
![[Pasted image 20240510143321.png]]

When thinking about AI, can business unlock new business value? -> Must know what value will AI brought in?

Platform: Must have skill for AI workflow.
Security: Identify and mitegrate AI vulnerable ability as well 
Operations: Mange and monitor AI performance  
## Lesson Reflection

**Summary**

This lesson provided an overview of key cloud computing concepts for AI, including the cloud service models of IaaS for core infrastructure, PaaS for application services, and SaaS for ready-to-use apps. It covered the benefits of cloud around costs, scaling, speed/agility, geographic reach and focusing on core business. The lesson outlined cloud deployment models like public, private and hybrid cloud, explaining how AI workloads may leverage different environments based on data, latency and compliance needs. It introduced the AWS Cloud Adoption Framework which provides guidance across business, people, governance, platform, security and operations for organizations adopting cloud-powered AI.

**Top 3 Key Points**

- Cloud service and deployment models provide a range of options to enable AI applications based on infrastructure needs, data considerations and business priorities.
    
- Migrating AI workloads to the cloud can lower costs, accelerate innovation cycles, facilitate geographic reach, while allowing focus on core business capabilities.
    
- The AWS Cloud Adoption Framework helps organizations take a structured approach to enable cloud-based AI across technology, people, governance and business lenses.
    

**Reflection Questions**

- Which cloud deployment approach - public, private or hybrid - seems most appropriate for our AI initiatives and why?
    
- How can adopting cloud-based AI impact our business metrics like time-to-market, geographic reach and innovation velocity?
    
- What are some reasons our organization should proactively develop an AI cloud adoption strategy?
    
- Which AWS CAF perspectives seem most critical for us to address in the near-term - business, people, governance or platform?
    
- How would our data strategy need to evolve to fully leverage cloud AI capabilities?
    

**Challenge Exercises**

- Map 2-3 current or potential AI applications to appropriate cloud deployment models
    
- Compare on-prem vs. cloud costs for a current AI workload
    
- Define an initial 12-month cloud AI adoption strategy
    
- Set up a proof-of-concept to assess feasibility of a cloud AI application
    
- Identify top people and governance considerations for responsible cloud AI adoption

# Setup AI focused development environments
## Key Terms
- **Code Catalyst**: Cloud-based development environment for building serverless pipelines and applications
```python
import boto3

client = boto3.client('codecatalyst')
```
- **SageMaker Studio**: Integrated IDE for machine learning development with access to GPU compute
```python
import sagemaker

# Connect to SageMaker studio
session = sagemaker.session.Session()

# Access GPU instance
ml = session.notebook_instance_lifecycle_config.create(
											InstanceType='ml.g4dn.xlarge' #GPU machine
)

print('SageMaker studio launched for ML development')
```
- **Lightsail:** Virtual machines for research with flexible access to GPUs
```python
import boto3

# Launch Lightsail instance
client = boto3.client('lightsail')
instance = client.create_instances(
								   InstanceNames=['Research-1'], AvailabilityZone='us-east-1a', InstanceBundleID='gpu.2xlarge'
)
print("Launched lightsaild research instance")
```
- **MLOps:** APplying DevOps principles like CI/CD to machine learning model development and deployment
```python
import sagemaker
from sagemaker.sklearn.estimator import SKLearn

# Containerize scikit-learn model

sklearn_estimator = SKLearn(
							entry_point='train.py',
							role=sagemaker.get_execution_role(), 
)
```
# With Parameter Store  : 

## Description
To hide our sensitive data, we prefer to use parameter store. So Mysql Password, Username and GitHub TOKEN will be locate in SSM parameter store and we refer these parameter from CloudFormation template and Flask .py file. 

## Part 1 Creating parameters in SSM Parameter Store 

- Go SSM and from left hand menu, select Parameters Store 

- Click "Create Parameter"

- Create parameter for `database master password`  :

 `Name`         : /clarusway/phonebook/password               
 `Description`  : ---
 `Tier`         : Standard
 `Type`         : SecureString   (So AWS encrypts sensitive data using KMS)
 `Data type`    : text
 `Value`        : clarusway_1234

- Create parameter for `database username`  :

 `Name`         : /clarusway/phonebook/username             
 `Description`  : ---
 `Tier`         : Standard
 `Type`         : String   (No encryption)
 `Data type`    : text
 `Value`        : admin

- Create parameter for `Github TOKEN`  :

 `Name`         : /clarusway/phonebook/token             
 `Description`  : ---
 `Tier`         : Standard
 `Type`         : SecureString   (So AWS encrypts sensitive data using KMS)
 `Data type`    : text
 `Value`        : xxxxxxxxxxxxxxxxxxxx

## Part 2 Modify phonebook-app.py file

- We need to add/change the existing code  according to Boto3 from `beginning` to `def init_phonebook_db():` function. 

```text
# Import Flask modules
from flask import Flask, request, render_template
from flaskext.mysql import MySQL
import boto3

def get_ssm_parameters():
    ssm = boto3.client('ssm', region_name='us-east-1')

    # AWS SSM 
    username_param = ssm.get_parameter(Name='/osvaldo/phonebook/username')
    password_param = ssm.get_parameter(Name="/osvaldo/phonebook/password", WithDecryption=True)


    # Assign values to parameters 
    username = username_param['Parameter']['Value']
    password = password_param['Parameter']['Value']

    return username, password

# Create Flask 
app = Flask(__name__)

# Retrieve parameters form SSM'den
db_username, db_password = get_ssm_parameters()

# This "/home/ec2-user/dbserver.endpoint" file has to be created from cloudformation template and it has RDS endpoint
db_endpoint = open("/home/ec2-user/dbserver.endpoint", 'r', encoding='UTF-8') 

# Configure mysql database

app.config['MYSQL_DATABASE_HOST'] = db_endpoint.readline().strip()
app.config['MYSQL_DATABASE_USER'] = db_username
app.config['MYSQL_DATABASE_PASSWORD'] = db_password
app.config['MYSQL_DATABASE_DB'] = 'clarusway_phonebook'
app.config['MYSQL_DATABASE_PORT'] = 3306
db_endpoint.close()
mysql = MySQL()
mysql.init_app(app) 
connection = mysql.connect()
connection.autocommit(True)
cursor = connection.cursor()

```

- ## Part 3 Modify phonebook-app.yaml file 

### Section 1: Changing TOKEN, Database Username, Database Password. 

- Add a new parameter named MyDbusername.

```
MyDbusername:
    Type: AWS::SSM::Parameter::Value<String>
    Default: /clarusway/phonebook/username 
```
- Change the database instance's ` master password`  and  ` username`  section. 

```
.
.
.
MasterUsername: !Ref MyDbusername
MasterUserPassword: '{{resolve:ssm-secure:/clarusway/phonebook/password:1}}'
.
.
.
```

- Go the `userdata` section inside the `Launch Template `and chenge TOKEN:xxxxxxxxxxxxx to :

```
TOKEN=$(aws --region=us-east-1 ssm get-parameter --name /clarusway/phonebook/token --with-decryption --query 'Parameter.Value' --output text)
```

- So here we used 3 different ways to retrieve values. With CLI (TOKEN), Dynamic (masterpassword) and referring from parameter (username )

### Section 2: Permission.

- Since our EC2 instance reach  SSM service  to  retrieve values from, we need to give permission to EC2. We have to options. Either can we configure AW CLI or use IAM Role. Since it is more secure, we'll use  IAM ROle. 
But we can not directly assign a role to Launch template/Instance . So we use Instance profile contains IAM Role

- First we need to create IAM role and then create  a Instance profile using that Role. 

```
 MyInstanceProfile:
    Type: AWS::IAM::InstanceProfile
    Properties:
      InstanceProfileName: SSMInstanceProfile
      Roles:
        - !Ref MySSMRole

  MySSMRole:
    Type: AWS::IAM::Role
    Properties:
      RoleName: SSMRoleWithManagedPolicy
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service: ec2.amazonaws.com
            Action: sts:AssumeRole
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/AmazonSSMFullAccess
```

- then use this profile in Launch template : 

```
.
.
.
KeyName: !Ref KeyName 
IamInstanceProfile: 
  Name: !Ref MyInstanceProfile
SecurityGroupIds:
.
.
.
```

- Dont forget to push new version of the .py file to your repo before create  Cfn stack

- Create the stack

- After you delete the stack please also delete the manuel snapshot of the DB instance. Because  AWS creates a new snapshot after deletion of stack. 


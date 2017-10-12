# AWS-EC2-Security-Groups
A package for managing ec2 security groups

## Pre-Requisites
1. You’ll need to install a few packages first:
* [jq](https://stedolan.github.io/jq/)
* [awscli](https://aws.amazon.com/cli/)

### AWS CLI Setup
You must follow the [AWS CLI setup instructions](http://docs.aws.amazon.com/lambda/latest/dg/setup-awscli.html) to configure your environment with your aws account.

## Usage

```
aws-sg [-h --help] [-p --port -g --group] [-m --max -n --number -a --asc -d --desc] 

-- program to manage EC2 security groups

where:
    -h --help    show this help text
    -p --port    set the port value (example: 22 - ssh) *required
    -g --group   set the group name (example: default) *required
    -m --max     set the number of rules allowed (default: 0)
    -n --number  set the number of rules to be deleted (default: delete until down to supplied max value)
    -a --asc     delete the oldest rules first (default)
    -d --desc    delete the newest rules first
```

## Installing Options

### Clone the repository 

`git clone https://github.com/themsabs/AWS-EC2-Security-Groups.git`<br>
`cd AWS-EC2-Security-Groups`

### dpkg
```wget https://s3.amazonaws.com/ec2-sg/releases/0.1/aws-sg_0.1-1_all.deb```
```sudo dpkg -i aws-sg_0.1-1_all.deb```

### yum
```sudo yum install https://s3.amazonaws.com/ec2-sg/releases/0.1/aws-sg-0.1-2.noarch.rpm```

### rpm
```wget https://s3.amazonaws.com/ec2-sg/releases/0.1/aws-sg-0.1-2.noarch.rpm```
```sudo rpm -Uvh aws-sg-0.1-2.noarch.rpm```

If you encounter the error(s):
>file / from install of hello-0.1-2.noarch conflicts with file from package filesystem-2.4.30-3.8.amzn1.x86_64
>file /usr/bin from install of hello-0.1-2.noarch conflicts with file from package filesystem-2.4.30-3.8.amzn1.x86_64

```sudo rpm -ivh --replacefiles aws-sg-0.1-2.noarch.rpm```

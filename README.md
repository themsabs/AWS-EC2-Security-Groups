# AWS-EC2-Security-Groups
A package for managing ec2 security groups

## Installing
1. You’ll need to install a few packages first:
* [jq](https://stedolan.github.io/jq/)
* [awscli](https://aws.amazon.com/cli/)

### AWS CLI Setup
You must follow the AWS CLI setup instructions to configure your environment with your aws account.

2. Clone the repository 

`git clone https://github.com/themsabs/AWS-EC2-Security-Groups.git`<br>
`cd AWS-EC2-Security-Groups`

3. Install with your package manager

### dpkg
```sudo dpkg -i aws-sg_0.1-1_all.deb```

### yum
```sudo rpm -Uvh aws-sg-0.1-2.noarch.rpm```

If you encounter the error(s):
>file / from install of hello-0.1-2.noarch conflicts with file from package filesystem-2.4.30-3.8.amzn1.x86_64
>file /usr/bin from install of hello-0.1-2.noarch conflicts with file from package filesystem-2.4.30-3.8.amzn1.x86_64

```sudo rpm -ivh --replacefiles aws-sg-0.1-2.noarch.rpm```

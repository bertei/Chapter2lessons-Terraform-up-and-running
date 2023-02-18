# Deploying a Web Server
The goal is to deploy the simplest web architecture possible: a single web server that can respond to HTTP requests.

## Set up Provider (AWS)
This tells TF that you'll be using AWS provider and deploying into us-east-1 region.
For each provider, there are many different kinds of resources that you can create. The general syntax is:
```
resource "PROVIDER_TYPE" "NAME" {}
````
* Where PROVIDER is the name of a provider (e.g., aws), TYPE is the type of resource to create in that provider (e.g., instance), NAME is an identifier you can use throughout TF code to refer to this resource (e.g., my_instance), and CONFIG consists of one or more arguments that are specific to that resource.
## Code notes
* ami = the amazon machine image to run on the EC2 instance. The code sets the ami parameter to the id OF an ubuntu 20.04 ami in us-east-1. AMI IDs are different in every AWS region.
* instance_type = the type of ec2 instance to run. Each type of ec2 provides different hw resources.
* tags = Name (identifier within AWS to refer to the EC2)
## Bash script 'Hello world'
* Bash script that writes "Hello world" into index.html and runs a tool called busybox to fire up a web server on port 8080 to serve that file.
* EC2 user data is a set of instructions used to configure an EC2 instance at launch time using cloud-init or shell scripting.
* The <<-EOF and EOF are Terraform's heredoc syntax, which allows you to create multiline strings without having to insert \n characters all over the place.
* The user_data_replace_on_change parameter is set to true so that when you change the user_data parameter and run apply, Terraform will terminate the original instance and launch a totally new one. Terraform’s default behavior is to update the original instance in place, but since User Data runs only on the very first boot, and your original instance already went through that boot process, you need to force the creation of a new instance to ensure your new User Data script actually gets executed.
## Allow EC2 instance to receive traffic (SG) & TF references
* By default, AWS does not allow any incoming or outgoing traffic from an EC2 Instance. To allow the EC2 Instance to receive traffic on port 8080, you need to create a security group.
* It specifies that this group allows incoming TCP requests on port 8080 from the CIDR block 0.0.0.0/0. CIDR blocks are a concise way to specify IP address ranges. For example, a CIDR block of 10.0.0.0/24 represents all IP addresses between 10.0.0.0 and 10.0.0.255. The CIDR block 0.0.0.0/0 is an IP address range that includes all possible IP addresses, so this security group allows incoming requests on port 8080 from any IP.
* Simply creating a security group isn’t enough; you need to tell the EC2 Instance to actually use it by passing the ID of the security group into the vpc_security _group_ids argument of the aws_instance resource
* One particularly useful type of expression is a reference, which allows you to access values from other parts of your code. To access the ID of the security group resource, you are going to need to use a resource attribute reference, which uses the following syntax:
```
    <PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
````
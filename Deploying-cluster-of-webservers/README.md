# Deploying a Cluster of Web servers
* Running a single server is a good start, but in the real world, a single server is a single point of failure. If that server crashes, or if it becomes overloaded from too much traffic, users will be unable to access your site. The solution is to run a cluster of servers, routing around servers that go down and adjusting the size of the cluster up or down based on traffic.

## Auto Scaling Group (ASG)
* ASG takes care of a lot of tasks for you completely automatically, including launching a cluster of EC2 Instances, monitoring the health of each Instance, replacing failed Instances, and adjusting the size of the cluster in response to load.
* The first step in creating an ASG is to create a **launch configuration**, which specifies how to configure each EC2 instance in the ASG.
* The **aws_launch_configuration** resource uses almost the same parameters as the **aws_instance** resource, although it doesn't supports tags or the  **user_data_replace_on_change** (asg's launch new instances by default, so you don't need this parameter), and two of the parameters have different names (ami is now imagE_id, and vpc_security_group_ids is now security_groups).

## Lifcycle setting
* Every Terraform resource supports several lifecycle settings that configure how that resource is created, upda‐ ted, and/or deleted. A particularly useful lifecycle setting is create_before_destroy. If you set create_before_destroy to true, Terraform will invert the order in which it replaces resources, creating the replacement resource first (including updating any references that were pointing at the old resource to point to the replacement) and then deleting the old resource.

## Subnet ids
* This parameter specifies to the ASG into which VPC subnets the EC2 instances should be deployed. Each subnet lives in an isolated AWS AZ (that is, isolated datacenter), so by deploying your instances across multiple subnets, you ensure that your service can keep running even if some of the datacenters have an outage. You could hardcode the list of subnets, but that won't be maintanable, so a better option is to use **data sources** to get the list of subnets in your aws acc.

## Data sources
* A data source represents a piece of read-only information that is fetched from the provider every time you run TF. It's a way to make that data available to the rest of your tf code.
```
data "<PROVIDER>_<TYPE>" "<NAME>" {
      [CONFIG ...]
}
```
* Note that with data sources, the arguments you pass in are typically search filters that indicate to the data source what information you're looking for. With the **aws_vpc_data source*, the only filter you need is default = true, which directs tf to look up the default vpc in your aws account.
```
To get the data ouf of a data source, you use the following syntax:
data.<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
http://data.aws_vpc.default.id/
```
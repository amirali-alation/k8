# Kubernetes Cluster deployment using EKS

This repo provides a terraform to deploy a VPC and setup Kubernetes using EKS module.

The installer.sh will install all the dependency for you

Note: Assumption is that you are using centOS and you need to install the following dependencies manually if you want to run it on your Mac/Windows. 

 - Kubectl
 - AWS Authenticator
 - HELM
 - AWS CLI V2
 - Terraform 0.12

Before begin please make sure you have configured your aws CLI.

You need sufficient permission for the user that you are using to deploy the cluster like the following
[IAM Permission](https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/iam-permissions.md)

```shell
$ aws configure
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <YOUR_AWS_REGION>
Default output format [None]: json
```

After you've done this, initalize your Terraform workspace, which will download the provider and initialize it

```shell
$ cd infra
$ terraform init

Initializing modules...
Downloading terraform-aws-modules/eks/aws 12.2.0 for eks...
- eks in .terraform/modules/eks/terraform-aws-eks-12.2.0
- eks.node_groups in .terraform/modules/eks/terraform-aws-eks-12.2.0/modules/node_groups
Downloading terraform-aws-modules/vpc/aws 2.6.0 for vpc...
- vpc in .terraform/modules/vpc/terraform-aws-vpc-2.6.0

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...
- Downloading plugin for provider "template" (hashicorp/template) 2.1.2...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.70.0...
- Downloading plugin for provider "kubernetes" (hashicorp/kubernetes) 1.11.4...
- Downloading plugin for provider "random" (hashicorp/random) 2.3.0...
- Downloading plugin for provider "local" (hashicorp/local) 1.4.0...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Then, provision your EKS cluster by running terraform apply. (may take upto 15 minutes)

```bash
$ cd infra
$ terraform apply 
```

After successful apply of the Terraform you can view the outputs by running the following command. 

```bash
$ cd infra
$ terraform output
```

## Configure kubectl 

If you did not use installer.sh, make sure you have installed AWS Authenticator before configuring your kubectl.
you can get both region and cluster name from the output of terraform output command. 
The kube config file should be already generated for you after a successful terraform apply. 


```shell
$ aws eks --region <region-name> update-kubeconfig --name <cluster-name>
```

At this point your cluster is ready to be used and you can deploy your application on it. 



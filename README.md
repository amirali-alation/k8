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

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "template" (hashicorp/template) 2.1.2...
- Downloading plugin for provider "kubernetes" (hashicorp/kubernetes) 1.10.0...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.52.0...
- Downloading plugin for provider "random" (hashicorp/random) 2.2.1...
- Downloading plugin for provider "local" (hashicorp/local) 1.4.0...
- Downloading plugin for provider "null" (hashicorp/null) 2.1.2...

Terraform has been successfully initialized!
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



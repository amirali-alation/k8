#!/bin/bash

set -ex
yum update -y && yum install -y  unzip curl wget

# install Kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/

# setup kubectl auto completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source ~/.bashrc

# install HELM
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh
rm ./get_helm.sh


# install AWS Authenticator
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mv ./aws-iam-authenticator /usr/local/bin

# install AWSCLI V2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm ./awscliv2.zip
rm -rf ./aws

# install terraform

curl https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip -o terraform.zip
unzip ./terraform.zip && mv terraform /usr/bin && rm terraform.zip

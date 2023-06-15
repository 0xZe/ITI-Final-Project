# Deploy App on EKS Cluster Using Jenkins Pipeline

This project is to build EKS Cluster on AWS and use Jenkins on the cluster to run the Jenkinsfile to deploy the application on the same cluster

## Step 1: Build AWS EKS Cluster

```
$ cd EKS-Terraform/
$ terraform init
$ terraform apply
```
Compenetes that will built are:

- `VPC`
- `Public Subnet & Private Subnets`
-  `EKS`
-  `private Worker Nodes`
---

## Step 2: Connect to the Bastion 
`I will use the bastion to connect to the cluster from it to Install Docker on the cluster`

```
$ ssh -i mykey.pem ubuntu@<Bastion-public-ip-address>
```

## Step 3: Connect to the cluster from the Bastion to install docker on it
`We will need docker daemon socket on the pipeline`
`Note that you will make the ssh key in bastion by copying it`
```
$ ssh -i mykey.pem ec2-user@<Bastion-public-ip-address>
```

## Step 4: Install docker on the node

```
$ sudo yum update
$ sudo yum install docker
$ sudo systemctl enable docker.service
$ sudo systemctl start docker.service
$ sudo usermod -a -G docker ec2-user
```


## Step 5: Update Kubeconfig

```
$ aws eks --region us-east-1 update-kubeconfig --name eks-cluster
```

## Step 6: Deploy Jenkins on EKS Cluster to make the pipeline

```
$ cd Jenkins-K8s
$ kubectl apply -f admin-clusterrole.yaml
$ kubectl apply -f deployment.yaml -n jenkins
$ kubectl apply -f service.yaml -n jenkins
```

## Step 7: Access Jenkins

```
# Replace <jenkins-service ip> with the ip of the jenkins-service
<jenkins-service ip>
```
## Step 8: Configure Jenkins

### Add Credentials

`Install aws cloud bees pligin`
`then`
`Manage Jenkins > Manage Credentials > global > Add Credentials`

Add AWs Acess Key & Secret Access Key

Add Dockerhub Username & Password

## Step 9: Create and Run Pipeline

`Dashboard > New Item > Ppeline`

From Definition choose "Pipeline Script from SCM" > Choose "Git" as SCM > Add repository URL > Choose Credentials from the dropdown menu

`make sure the branch name is right and the path where Jenkinsfile is located in the repository`

Save > Build Now





continuing
.
.
.
.
.
.
.
.
.
.
.
.
.
![iti-final](https://github.com/0xZe/ITI-Final-Project/assets/81789671/3a9e3f13-005a-40c4-9b37-9f7a0e239ada)
```


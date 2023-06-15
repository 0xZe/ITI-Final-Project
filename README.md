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
`ssh to the created Bastion using the following command`

```
$ ssh -i mykey.pem ubuntu@<Bastion-public-ip-address>
```

## Step 3: Connecting to the cluster from the Bastion to install docker on it
`We will need docker deamon socket on the pipeline`
`ssh to the Node using the following command`

```
$ ssh -i mykey.pem ec2-user@<Bastion-public-ip-address>
`Note that you will make the ssh key in bastion by copying it`
```

## Step 4: Update Kubeconfig

```
$ aws eks --region us-east-1 update-kubeconfig --name eks-cluster
```

## Step 5: Deploy Jenkins on EKS Cluster to make the pipeline

```
$ cd Jenkins-K8s
$ kubectl apply -f admin-clusterrole.yaml
$ kubectl apply -f deployment.yaml -n jenkins
$ kubectl apply -f service.yaml -n jenkins
```

```

```
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

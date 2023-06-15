# Deploy App on EKS Cluster Using Jenkins Pipeline

This project is to build EKS Cluster on AWS and use Jenkins on the cluster to deploy application on the same cluster

## Step 1: Build the infrastructure

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


![1](https://github.com/0xZe/ITI-Final-Project/assets/81789671/c745deb4-c8ff-4f9a-b06d-cac810b414a8)

---

## Step 2: Connect to the Bastion 
`I will use the bastion to connect to the cluster from it to Install Docker on the cluster`

```
$ ssh -i mykey.pem ubuntu@<Bastion-public-ip-address>

![2](https://github.com/0xZe/ITI-Final-Project/assets/81789671/fb59a907-1148-471a-80ce-4c6022ba7034)

```

## Step 3: Connect to the cluster from the Bastion to install docker on it
`We will need docker daemon socket on the pipeline`
`Note that you will make the ssh key in bastion by copying it`
```
$ ssh -i mykey.pem ec2-user@<Bastion-public-ip-address>

![3](https://github.com/0xZe/ITI-Final-Project/assets/81789671/388a456d-304e-43ea-89ac-91de1cb99762)

```

## Step 4: Install docker on the node

```
$ sudo yum update
$ sudo yum install docker
$ sudo systemctl enable docker.service
$ sudo systemctl start docker.service
$ sudo usermod -a -G docker ec2-user

![4](https://github.com/0xZe/ITI-Final-Project/assets/81789671/55d738c5-b55a-4ea9-969b-e3ede39fc776)

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
# Replace <jenkins-service URL> with the URL of the jenkins-service
<jenkins-service URL>

![5](https://github.com/0xZe/ITI-Final-Project/assets/81789671/889d89e6-5071-4019-8dad-44f27c9c1df8)
![6](https://github.com/0xZe/ITI-Final-Project/assets/81789671/1e887161-934e-4c65-a168-9757964207f2)

```
## Step 8: Configure Jenkins

### Add Credentials

`First Install CloudBees AWS Credentials Plugin`
`then go to`
`Manage Jenkins > Manage Credentials > global > Add Credentials`

Add AWs Acess Key & Secret Access Key

Add Dockerhub Username & Password

## Step 9: Create and Run Pipeline

`Dashboard > New Item > Pipeline`

From Definition choose "Pipeline Script from SCM" > Choose "Git" as SCM > Add repository URL > Choose Credentials from the dropdown menu

`make sure the branch name is right and the path where Jenkinsfile is located in the repository`

Save > Build Now

![7](https://github.com/0xZe/ITI-Final-Project/assets/81789671/0f692c3e-35e2-49fa-971a-2f7dd730f759)


## Step 10: Access our App

`The pipeline will return the URL of our App at the end `

![8](https://github.com/0xZe/ITI-Final-Project/assets/81789671/47564c91-9327-4885-a1c5-9fc58d1d21c4)
![10](https://github.com/0xZe/ITI-Final-Project/assets/81789671/f8f20a19-bd17-475b-9024-741b41da6adf)





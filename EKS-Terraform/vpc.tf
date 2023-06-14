#vpc
resource "aws_vpc" "eks-vpc" {
  cidr_block = "10.0.0.0/16"
}

# igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks-vpc.id
}
#Elastic Ip For Nat Gateway
resource "aws_eip" "nat_ip" {

}

#Create Nat Gateway and put it in subnet public1
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnet.id
}

##########Subnets##################

#public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.eks-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone ="us-east-1a"

}


#private subnets

resource "aws_subnet" "private_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.private_subnets_cidr[count.index]
  map_public_ip_on_launch = var.private_subnets_map_ip[count.index]
  availability_zone       = var.subnets_az[count.index]

}

############Route Tables#############

#public subnet route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


#public subnet assosiation
resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

#private subnet route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
}


#private subnet1  assosiation
resource "aws_route_table_association" "private_rt_asso" {
  subnet_id      = aws_subnet.private_subnets[0].id
  route_table_id = aws_route_table.private_rt.id
}


#private subnet2  assosiation
resource "aws_route_table_association" "private_rt_asso2" {
  subnet_id      = aws_subnet.private_subnets[1].id
  route_table_id = aws_route_table.private_rt.id
}



################Security Groups######################

resource "aws_security_group" "sg" {
  name        = "public-sg"
  description = "Restrict SSH traffic from the Vpc & Allow HTTP and HTTPS from any where"
  vpc_id = aws_vpc.eks-vpc.id

# ingress {
#    from_port   = 30009
#    to_port     = 30009
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  } 

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#!/bin/bash

export vpcId=$(aws ec2 create-vpc --cidr-block 172.19.0.0/24 --query 'Vpc.VpcId' --output text)
echo "VPC-ID " $vpcId
aws ec2 modify-vpc-attribute --vpc-id $vpcId --enable-dns-hostnames "{\"Value\":true}"
aws ec2 create-tags --resources $vpcId --tags Key=Name,Value=fromCLI
# Attach the VPC to the Internet
export internetGatewayId=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
echo "IG-ID " $internetGatewayId
aws ec2 attach-internet-gateway --internet-gateway-id $internetGatewayId --vpc-id $vpcId
aws ec2 create-tags --resources $internetGatewayId --tags Key=Name,Value=fromCLI
#Attach the Subnet to the VPC
export subnetId=$(aws ec2 create-subnet --vpc-id $vpcId --cidr-block 172.19.0.0/24 --query 'Subnet.SubnetId' --output text)
echo "Subnet " $subnetId
aws ec2 create-tags --resources $subnetId --tags Key=Name,Value=fromCLI
#Create RouteTable
export routeTableId=$(aws ec2 create-route-table --vpc-id $vpcId --query 'RouteTable.RouteTableId' --output text)
echo  "RouteTable " $routeTableId
aws ec2 create-tags --resources $routeTableId --tags Key=Name,Value=fromCLI
#Associate RouteTable with subnet
aws ec2 associate-route-table --route-table-id $routeTableId --subnet-id $subnetId
#Add a Route to the RT
aws ec2 create-route --route-table-id $routeTableId --destination-cidr-block 0.0.0.0/0 --gateway-id $internetGatewayId
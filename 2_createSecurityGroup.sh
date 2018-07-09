#!/bin/bash


export sgId=$(aws ec2 create-security-group --group-name FromCLI --description FromCLI --vpc-id ${vpcId} --output text)
echo "SGID " $sgId
aws ec2 authorize-security-group-ingress --group-id $sgId --protocol -1 --port -1 --cidr 0.0.0.0/0 
aws ec2 create-tags --resources $sgId --tags Key=Name,Value=fromCLI
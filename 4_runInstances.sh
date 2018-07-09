#!/bin/bash
#amiId="ami-b81dbfc5"
amiId="ami-4826c22b"
instanceType="m5.xlarge"
export instanceId=$(aws ec2 run-instances --no-dry-run \
                      --instance-type $instanceType \
                      --image-id $amiId \
                      --security-group-ids $sgId \
                      --subnet-id $subnetId \
                      --count 1 \
                      --key-name devenv-key \
                      --block-device-mappings "DeviceName=/dev/sda1,Ebs={VolumeSize=250,VolumeType=gp2}" \
                      --associate-public-ip-address \
                      --user-data file:///tmp/centossetup.txt \
                      --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=fromCLI}]' \
                      --query 'Reservations[*].Instances[*][InstanceId]' --output text)

# unable to get the Instance id
echo "InstanceID " $instanceId
# aws ec2 create-tags --resources $instanceId --tags Key=Name,Value=fromCLI

# 
export publicIP=$(aws ec2 describe-instances --region=$awsregion --filters "Name=tag:Name,Values=fromCLI" --query "Reservations[*].Instances[*][PublicIpAddress]" --output text)
echo "IP " $publicIP
echo 'ssh -i devenv-key.pem centos@'$publicIP
echo "OR"
echo 'ssh -i devenv-key.pem ec2-user@'$publicIP
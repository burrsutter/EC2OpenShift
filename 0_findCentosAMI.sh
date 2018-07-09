#!/bin/bash

# finding the Centos image product code comes from: https://wiki.centos.org/Cloud/AWS
# note: does not work
# aws ec2 describe-images --owners aws-marketplace --region=us-east-1 --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce --query "sort_by(Images, &CreationDate)[-1].[ImageId]" --output text
# this one does work but it takes a long time
aws ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce


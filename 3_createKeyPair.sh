#!/bin/bash

aws ec2 create-key-pair --key-name mykeyburr --query 'KeyMaterial' --output text > mykeyburr.pem
chmod 400 mykeyburr.pem
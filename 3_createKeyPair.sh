#!/bin/bash

aws ec2 create-key-pair --key-name devenv-key --query 'KeyMaterial' --output text > devenv-key.pem
chmod 400 devenv-key.pem
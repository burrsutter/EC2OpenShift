

aws cli installation
https://docs.aws.amazon.com/cli/latest/userguide/cli-install-macos.html

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
aws --version
aws-cli/1.15.53 Python/2.7.10 Darwin/15.6.0 botocore/1.10.52

CLI docs
https://docs.aws.amazon.com/cli/latest/reference/ec2/index.html#cli-aws-ec2


From IAM console, create user and access key

aws configure

AWS Access Key ID 
AWS Secret Access Key 
Default region name [us-east-1] (note this is critical, us-east-1 tends to be too overloaded to launch a bigger instance)
Default output format [None]: text

aws ec2 describe-instances --output json

Find the AMI ID for Centos in your region, modify the region
./0_findCentosAMI.sh

source 1_createVPC.sh 

source 2_createSecurityGroup.sh

./3_createKeyPair.sh

source 4_runInstances.sh

If you wish to try the Minishift variant
same steps as above but replace 
                      --user-data file://./centosminisetup.txt \
in 4_runInstances.sh

source 4_runInstances.sh

./minishift_install.sh

source minishift_setup.sh

./minishiftCreateEC2.sh

source minishift_ocenv.sh

minishift console

./install_istio.sh

How to pull the master-config.yml off the remote VM?
scp -i devenv-key.pem centos@52.53.223.193:/var/lib/origin/openshift.local.config/master/master-config.yaml .

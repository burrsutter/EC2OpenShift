#!/bin/bash
minishift profile set ec2instance
# what memory and CPU will minishift pick?
# minishift config set memory 14GB
# minishift config set cpus 3
minishift config set vm-driver generic
minishift config set image-caching true
minishift addon enable admin-user
minishift addon enable anyuid
# minishift ip --set-static
minishift config set remote-ipaddress $publicIP
minishift config set remote-ssh-user centos # or ec2-user
minishift config set remote-ssh-key devenv-key.pem

minishift start


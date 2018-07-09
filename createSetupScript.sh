#!/bin/bash

# note: change the devpassword and adminpassword
cat << 'EOF' >/tmp/centossetup.txt
#cloud-config
runcmd:
  - yum update -y
  - yum upgrade -y
  - yum install -y wget docker git httpd-tools
  - mkdir -p /etc/rhsm/ca/
  - touch /etc/rhsm/ca/redhat-uep.pem
  - sed -i '/OPTIONS=.*/c\OPTIONS="--selinux-enabled --insecure-registry 172.30.0.0/16"' /etc/sysconfig/docker
  - systemctl enable docker
  - groupadd docker
  - usermod -aG docker centos
  - service docker start
  - wget https://github.com/openshift/origin/releases/download/v3.9.0/openshift-origin-server-v3.9.0-191fece-linux-64bit.tar.gz
  - tar -xzf openshift-origin-server-v3.9.0-191fece-linux-64bit.tar.gz
  - cd openshift-origin-server-v3.9.0-191fece-linux-64bit
  - cp oc /usr/local/bin/
  - export PATH=$HOME/openshift-origin-server-v3.9.0-191fece-linux-64bit:$PATH
  - oc cluster up --routing-suffix=$(curl http://169.254.169.254/latest/meta-data/public-ipv4).nip.io --public-hostname=$(curl http://169.254.169.254/latest/meta-data/public-ipv4).nip.io
  - htpasswd -c -b /var/lib/origin/openshift.local.config/master/users.htpasswd developer devpassword
  - htpasswd -c -b /var/lib/origin/openshift.local.config/master/users.htpasswd admin adminpassword
EOF
: '
  - wget https://github.com/openshift/origin/releases/download/v3.9.0/openshift-origin-server-v3.9.0-191fece-linux-64bit.tar.gz
  - tar -xzf openshift-origin-server-v3.9.0-191fece-linux-64bit.tar.gz
  - export PATH=$HOME/openshift-origin-server-v3.9.0-191fece-linux-64bit:$PATH
  - oc cluster up --routing-suffix=$(curl http://169.254.169.254/latest/meta-data/public-ipv4).nip.io --public-hostname=$(curl http://169.254.169.254/latest/meta-data/public-ipv4).nip.io
  - oc adm policy add-cluster-role-to-user cluster-admin admin --config /var/lib/origin/openshift.local.config/master/admin.kubeconfig
'
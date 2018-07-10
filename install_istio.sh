#!/bin/bash

curl -L https://github.com/istio/istio/releases/download/0.8.0/istio-0.8.0-osx.tar.gz | tar xz

cd istio-0.8.0

export ISTIO_HOME=`pwd`
export PATH=$ISTIO_HOME/bin:$PATH

oc create -f install/kubernetes/istio-demo.yaml
oc project istio-system
oc expose svc istio-ingressgateway
oc expose svc servicegraph
oc expose svc grafana
oc expose svc prometheus
oc process -f https://raw.githubusercontent.com/jaegertracing/jaeger-openshift/master/all-in-one/jaeger-all-in-one-template.yml | oc create -f -
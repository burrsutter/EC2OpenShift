#!/bin/bash

minishift openshift config set --patch '{"oauthConfig": {"identityProviders": [ {"challenge": true,"login": true,"mappingMethod": "add","name": "htpasswd","provider": {"apiVersion": "v1","kind": "HTPasswdPasswordIdentityProvider","file": "users.htpasswd"}}]}}'
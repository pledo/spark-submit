#!/bin/bash

kubectl create serviceaccount spark-submit
kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark-submit --namespace=default

# Spark-submit

## Description:
This repository should provide a Dockerfile of the icpauloledo/spark-submit docker image, 
a deployment.yaml and cronjob.yaml with an example to show a simple way to run the spark-submit with Kubernetes.

### Getting start:

- First, You need to create a serviceAccount on your Kubernetes to grant access to spark-submit to create pods.

*source: https://spark.apache.org/docs/latest/running-on-kubernetes.html#rbac

It's really simple, you should to run two commands

### Create the serviceAccount because the Spark-submit needs to create a pod, the driver:
```sh
$ kubectl create serviceaccount spark-submit
```


#### Second, create the ClusterRoleBinding to associate a role with the permissions to the spark-submit serviceAccount:
```sh
$  kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark-submit --namespace=default
```

#### Or you can run the creating_service-account.sh to do that at once
```sh
$  bash creating_service-account.sh
```


On the deployment.yaml and cronjob.yaml files you can see the --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-submit line.

Aaaand adios amigo, just run the kubectl create command and check if the spark-submit pod will be created. After some seconds you will se
the the drive pod and then the executor pod.

```sh
kubectl create -f k8files/pod-cli.yaml 
```

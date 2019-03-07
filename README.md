# Spark-submit

## Description:
This repository should provide a Dockerfile of the icpauloledo/spark-submit docker image, 
a deployment.yaml and cronjob.yaml with an example to show a simple way to run the spark-submit with Kubernetes.

### Getting started:

- First, You need to create a serviceAccount on your Kubernetes to grant access to spark-submit to create pods.

*source: 
- https://spark.apache.org/docs/latest/running-on-kubernetes.html#docker-images
- https://spark.apache.org/docs/latest/running-on-kubernetes.html#rbac

It's really simple, follow the steps:

### Change the Kuberntes master api url
  
  You can get this information running the command.
  
```
kubectl cluster-info|egrep master
  Kubernetes master is running at https://api.k8s.my-k8.com    # for example
```

### With the k8's master url you should go to the k8files/(cronjob/deployment).yaml files and
### And change the K8S_MASTER variable

```
 - name: K8S_MASTER
   value: k8s://https://api.k8s.my-k8.tech:443
```

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

Thanks my friend @rodrigodelmonte - https://github.com/rodrigodelmonte
for help me with the spark docker image

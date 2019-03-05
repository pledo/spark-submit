# spark-submit


## You need to create a serviceAccount on your Kubernetes to grant access to spark-submit to create pods.

*source: https://spark.apache.org/docs/latest/running-on-kubernetes.html#rbac

It's really simple, you should to run two commands

###First, create the serviceAccount:
```sh
$ kubectl create serviceaccount spark-submit
```


####Second, create the ClusterRoleBinding:
```sh
$  kubectl create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark-submit --namespace=default
```

On the pod-cli and cronjob files you can see the --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-submit line.

Aaaand adios amigo, just run the kubectl create command and check if the spark-submit pod will be created. After some seconds you will se
the the drive pod and then the executor pod.

```sh
kubectl create -f k8files/pod-cli.yaml 
```

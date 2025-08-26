##  Passo a passo da implantação do cluster

1. instale o [minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)
2. instale os minikube addons:
  - storage-provisioner
  - ingress
  - ingress-dns
  - metrics-server
  - dashboard
  - default-storageclass


```bash
minikube addons enable storage-provisioner
minikube addons enable ingress-dns
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable ingress 
minikube addons enable default-storageclass
```

3. aplique todos os `yamls` da pasta [kube_yamls](./kube_yamls)
4. adicione o `minikube` como um servidor dns



##  Estratégia de versionamento.



## Os códigos de automação desenvolvidos, scripts e Docker file.

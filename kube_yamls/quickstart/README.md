# Configuração e Instalação do quickstart no minikube

Como o projeto a ser posto em produção e desenvolvimento não possui banco de dados, armazenamento persistente,
portanto precisamos criar um, _namespace_, _deployment_, _service_, e _ingress_

### Passo 1 um _namespace_ para o quickstart:

Para criar um _namespace_ para o quickstart, basta executar o comando

```bash
kubectl create namespace quickstart
```

### Passo 2 criar deployments para quickstart:

```bash
kubectl create -f quickstart-des-deployment.yaml
kubectl create -f quickstart-prd-deployment.yaml
```

### Passo 3 criar services para quickstart:

```bash
kubectl create -f quickstart-des-service.yaml
kubectl create -f quickstart-prd-service.yaml
```

### Passo 4 criar o ingress:

```bash
kubectl create -f ingress.yaml
```

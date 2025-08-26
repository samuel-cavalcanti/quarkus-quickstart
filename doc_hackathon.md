##  Passo a passo da implantação do cluster

1. instale o [minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)
2. baixe meu minikube e extraia para sua pasta `.minikube/machines`
  1. No linux fica: `~/.minikube/machines/`, caso já tenha uma máquina chamda **minikube** 


3. aplique todos os `yamls` da pasta [kube_yamls](./kube_yamls)
4. adicione o `minikube` como um servidor dns



##  Estratégia de versionamento.

O versionamento da aplicação é controlando pela variável de ambiente `TAG` que por sua vez está sendo versionando
pelo git em um repositório no Github. O valor contido no repositório é a fonte da verdade de modo que para rodar
uma pipeline com a nova versão, devesse atualizar o repositório git e então executar a pipeline.
A variável `TAG` controla a versão do container docker da aplicação. Na pipeline [Jenkinsfile_DES](./Jenkinsfile_DES)
`TAG`é utilizada para a compilação do novo container que por sua vez é disponibilizado no meu [repositório quickstart do Docker Hub](https://hub.docker.com/repository/docker/samuelcavalcanti/quickstart/general). 



## Os códigos de automação desenvolvidos, scripts e Docker file.

Todos os códigos desenvolvidos foram salvos nesse repositório no Github: https://github.com/samuel-cavalcanti/quarkus-quickstart na pasta [kube_yamls](./kube_yamls)

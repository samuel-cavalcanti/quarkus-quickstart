# Configuração e Instalação do Jenkins no minikube 

Todos os yamls foram inspirados na documentação oficial do Jenkins: https://www.jenkins.io/doc/book/installing/kubernetes/


## Criando o Deploy do Jenkins

### Passo 1 um *namespace*  para o jenkins:

Para criar  um *namespace*  para o jenkins, basta executar o comando

```bash
kubectl create namespace devops-tools
```

### Passo 2 criar o o *ServiceAccout* e *clusterRole*  para o Jenkins e o bind entre eles:

Aplique o manifesto ./jenkins-01-serviceAccount.yaml, exemplo: `kubectl apply -f jenkins-01-serviceAccount.yaml`.

O manifesto cria `jenkins-admin` *clusterRole*, `jenkins-admin` *ServiceAccout* e faz o bind entre eles.
No caso o `jenkins-admin` possui **todas** as permissões aos componentes do cluster, como boas praticas de segurança
está sendo levada em conta iremos limitar o acesso posteriormente.


### Passo 3 Criar um armazenamento local para o jenkins 

Aplique o manifesto ./jenkins-02-volume.yaml 

```bash
kubectl create -f ./jenkins-02-volume.yaml
```

Observe que diferente da documentação oficial:
- foi reduzido a memória de disco de 10Gi para 5Gi e o *request* de 3Gi para 2Gi.
- foi modificado `matchExpressions` para se adequar ao nosso cluster de único nó minikube


O manifesto cria um armazenamento local, ou seja, se o pod foi reiniciado os dados continuam salvos,
mas se o nó for **deletado** todos os dados são perdidos. Como nosso cluster possui um único nó e
portanto não tem como haver resiliência ou tolerância a falhas. No entanto isso torna o projeto mais
simples de ser compreendido pelo avaliador e respeita a limitação de hardware que eu possuo.

Como estamos utilizando o minikube, temos que adicionar uma configuração adicional para para que os dados persistam,
após uma reinicialização. Segundo a documentação [persistent_volumes](https://minikube.sigs.k8s.io/docs/handbook/persistent_volumes/),
precisamos adicionar  um `hostPath`



### Passo 4 criar jenkins Deployment:

```bash
kubectl apply -f jenkins-03-deployment.yaml
```


### Passo 5 acessar o jenkins 

Para que seja possível acessar **temporariamente** um serviço do kubernetes fora do cluster é preciso
fazer o forward da porta do serviço. Para isso é necessário saber o nome do pod e a porta a ser liberada. Por padrão o jenkins utiliza a porta 8080 e podemos ver o nome do pod através do comando:

```bash
kubectl get pods -n devops-tools
```
no caso o nome do pod era: `jenkins-5874c666f4-hqhq8`. Portanto o comando do forward fica:

```bash
kubectl --namespace  devops-tools port-forward jenkins-5874c666f4-hqhq8 8080:8080
```

Na primeira vez que se inicia o Jenkins, ele irá mostrar nos logs do Pod a senha admin.
Com a senha padrão foi instalado todos os plugins recomendados mais o **kubernetes**  e criado um usuário admin:

- username: admin
- password: eu*WL!4qGRiFpySm6zKWca^A5p

Para expor o Jenkins permanentemente foi escolhido criar um *Ingress*. 

```bash
kubectl apply -f jenkins-04-service.yaml
```

Habilite os addons `ingress` e `ingress-dns`  e configure o minikube para ser um dos
servidores de DNS do seu PC local:
https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/#Linux.

Para habilitar os addons:

```
minikube addons enable ingress;
minikube addons enable ingress-dns
```

No Caso eu configurei para o cluster resolver o domínio `.minikube`,
caso tenha feito. Crie o um Ingress para o Jenkins:

```bash
kubectl apply -f ingress.yaml
```

Com isso feito poderemos acessar o Jenkins pela url: https://jenkins.minikube/

### Passo 6 Configurar o Plugin kubernetes no Jenkins

Segundo na documentação oficial do Jenkins: [scaling-jenkins-on-kubernetes](https://www.jenkins.io/doc/book/scaling/scaling-jenkins-on-kubernetes/),
para adicionar o nosso cluster minikube, precisamos de duas informações:
a `KUBERNETES_URL` e o `JENKINS_URL`.
Podemos obtermos o `KUBERNETES_URL` usamos o comando

```bash
kubectl cluster-info
```

Onde o endereço do *control plane* é o endereço é o `KUBERNETES_URL`. Já o `JENKINS_URL`
é o IP do `jenkins-service`  e **habilitamos a conexão via Websocket**.

Após a configuração foi criado uma pipeline chamada: Test Pipeline que cria um pod que executa testes e validações de uma aplicação maven.


### Passo 7 Configurar o Github no Jenkins

Um dos desafios é criar uma uma pipeline de testes e validações para a seguinte aplicação:
[getting-started](https://github.com/quarkusio/quarkus-quickstarts/tree/main/getting-started)
e como boa práticas de segurança está sendo avaliada então foi decidido criar uma repositório
privado no Github onde o Jenkins deve interagir com ele.

Para acessar o repositório privado foi escolhido o método de autenticação chamado [deploy key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys). Nesse método
criamos uma pra de chaves ssh, onde a pública fica com o Github e a privada com o Jenkins. Uma deploy
key só permite o acesso de leitura ou leitura e escrita para um **único repositório**. Foi gerado
a chave SSH através do comando:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

e armazenamento na pasta [keys](../../keys)



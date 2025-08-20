# Configuração e instalação do Nginx no minikube

Para expor uma aplicação de um cluster kubernetes para a internet pode-se utilizar um *LoadBalancer*
ou *NodePort* ou *Ingress*.

### NodePort

O NodePort expõe o serviço  através de uma porta estática (NodePort) **em cada Nó**.

### LoadBalancer

O LoadBalancer permite expor um serviço através de um balanceador, o balanceador pode ter múltiplos pods ou replicas para lidar com o tráfico

### Ingress

O mais complexo das opções, porém ele possui configurações avançadas baseadas em URL e com suporte a TLS.

Como Boas práticas de segurança é um dos critérios de avaliação o *Ingress* foi escolhido, de modo
que possa utilizar o HTTPS

# Desafio Técnico: Implantação Automatizada em Ambiente Orquestrado

O desafio tem o objetivo de automatizar a implantação de uma aplicação Quarkus em um ambiente Kubernetes local,
utilizando ferramentas de automação, simulando uma pipeline completa de entrega contínua.
Esse desafio foca em práticas de DevOps, como entrega contínua, versionamento, e infraestrutura como código.

## Objetivo do Desafio

Ao final do desafio, você deverá apresentar os seguintes entregáveis:

- Cluster Kubernetes **local** provisionado

- Pipeline **local** de automação

- Compilação da Aplicação: A aplicação Quarkus deve ser compilada e empacotada em um executável JAR (ou outro formato otimizado para container, se preferir).

- Imagem de container com o pacote gerado na compilação

- Aplicação Quarkus implantada nos ambientes:

  - DES (Desenvolvimento): para testes e validações.

  - PRD (Produção): simulação de ambiente final.

- Documentação técnica contendo:

  - Passo a passo da implantação.
  - Estratégia de versionamento.
  - Os códigos de automação desenvolvidos, scripts e Docker file.

## Recomendações

- Documentação: Gere uma documentação com o passo a passo da instalação, Comandos utilizados, Estratégia de versionamento e como validar se a aplicação está funcionando.

- Ferramentas: Escolha ferramentas locais para simular o cluster Kubernetes e Docker.

- Ambiente: Defina e instale previamente as ferramentas que vão suportar a implantação.

## Requisitos Técnicos

- Imagem de Container Base: https://hub.docker.com/_/eclipse-temurin

- Código da aplicação: https://github.com/quarkusio/quarkus-quickstarts/tree/main/getting-started

## Critérios de Avaliação

- Clareza e organização do pipeline.

- Qualidade da automação e cobertura das etapas.

- Uso de boas práticas de segurança e versionamento.

- Documentação clara e objetiva.

- Criatividade na escolha e integração das ferramentas.

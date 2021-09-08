# Description

Na Brasil Paralelo, estamos passando da fase do MVP para um produto que deverá atender milhões de pessoas. Para tal, precisamos de uma ferramenta que orquestre múltiplos serviços, ferramentas e sistemas de maneira previsível, escalável e declarativa.

Neste repositório, há dois serviços demo, `authentication` e `feed`. O primeiro contém as credenciais cadastradas e os escopos de acesso. O segundo contém conteúdo, que só pode ser acessado por usuários com o escopo correto. A cada requisição, `feed` verifica o token fornecido pelo usuário com auth para permitir ou não acesso. Pode-se testar o funcionamento do sistema colocando os dois serviços no ar e rodando os comandos abaixo

```

curl -H "Authorization: Bearer 66ec51ac-72ea-479d-8b5f-d99eede929f0" -v localhost:3000/feed/patriota # 200 OK

curl -H "Authorization: Bearer 66ec51ac-72ea-479d-8b5f-d99eede929f0" -v localhost:3000/feed/premium # 403 Forbidden

```

Seu desafio é criar para os serviços um deployment Kubernetes que permita interagir com eles utilizando um cliente http de fora do cluster, como os comandos curl acima. Para tal, virtualize cada serviço (usando docker, rkt ou outros), e use numa receita com um deployer de sua preferência os recursos que julgar adequados, como services, pods, storages, ingresses, etc.

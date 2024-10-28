# Blu Project

### Objetivo
  API populada por um crawler com endpoints de busca.

### Staks
  - Ruby on Rails: crawler e api
  - Postgresql: banco de dados
  - Rspec: testes
  - Docker: reprodução em outros sistemas de forma fácil

## Instruções 

1. Clone o repositório
2. Acesse o diretório
3. No terminal coloque
   docker-compose build

4. Ainda no terminal, para iniciar os conteiners
    docker-compose up -d

5. Para rodar as migrations e inicar o banco de dados, no terminal cole:
      docker-compose run web rails db:create db:migrate

6. Abra o navegador e entre:
   http://localhost:3000

### Para visualizar as categorias
  http://localhost:3000/categorias



### Para visualizar os estados
  http://localhost:3000/estados

### Para visualizar os fornecedores
 http://localhost:3000/fornecedores

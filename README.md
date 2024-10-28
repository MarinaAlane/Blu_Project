# Blu Project

### Objetivo
  API populada por um crawler com endpoints de busca.

### Tecnologias Utilizadas
- Ruby on Rails: Responsável pela lógica do crawler e pela API.
- PostgreSQL: Banco de dados para armazenamento das informações.
- RSpec: Testes automatizados para assegurar a qualidade do código.
- Docker: Facilita a execução em diferentes ambientes de maneira consistente.
  
## Instruções 

1. Clone o repositório
2. Acesse o diretório
3. No terminal coloque
    `docker-compose build`

4. Ainda no terminal, para iniciar os conteiners
    `docker-compose up -d`

5. Para rodar as migrations e inicar o banco de dados, no terminal cole:
      `docker-compose run web rails db:create db:migrate`

6. Abra o navegador e entre:
   http://localhost:3000

### Para visualizar as categorias
  http://localhost:3000/categorias

### Para visualizar os estados
  http://localhost:3000/estados
  
### Para visualizar os fornecedores
 http://localhost:3000/fornecedores

### Para filtrar por estado
  http://localhost:3000/busca?=uf<nome-do-estado>

### Para filtrar por id da categoria
  http://localhost:3000/busca?=category<id-da-categoria>


## Testes

Para executar os teste digite no console
   `docker-compose run web rspec`

### Para filtrar por nome do fornecedor
  http://localhost:3000/busca?=name<nome-ou-palavra-que-faça-parte-do-nome-do-fornecedor>

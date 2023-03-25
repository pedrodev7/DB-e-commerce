# Desafio de Projeto - DB e-commerce <img align="center" height="30" width="40" src="https://ada-site-frontend.s3.sa-east-1.amazonaws.com/home/header-logo.svg" />

### Principais Informações

A ideia deste projeto tem como proposta desenvolver uma modelagem física de um ecommerce, bem como todos os comandos SQL de DDL e DML da modelagem produzida.

> _Este é um desafio de projeto desenvolvido durante o Curso da **ADA** no programa Polo Tech | Back-End durante a trilha Banco de Dados I._

### Entendendo o Desafio

**1 - Modelagem do e-commerce**
Do modelo conceitual abaixo, realizar o `modelo fisico completo` referente ao projeto conceitual do ecommerce visto em aula. Entregar o link do github com os arquivos do print do modelo físico completo e o arquivo (.dbs) do DBSchema.

<div style="display: inline_block"><br>
  <img align="center" src="https://github.com/viniciusCornieri/ada-turma-926-bd-po-001/blob/main/modelo_conceitual.png?raw=true" />
<div>

**2 - DDL - Data definition Language**
Para o modelo físico entregue no tópico anterior, entreguem o SQL com todo o DDL necessário para criar esse banco de dados no postgreSql. O SQL pode estar em um arquivo chamado `ecommerce-ddl.sql` no github.

**3 - DML - Data Manipulation Language**
Com o banco de dados e tabelas criadas agora é hora de popularmos nosso e-commerce com dados, crie o SQL com a inserção dos seguintes dados:

* 5 clientes
* 5 produtos
* 2 clientes devem ter pelo menos 3 produtos no carrinho
* 6 pedidos com pelo menos 2 produtos cada um
* 3 campanhas de cupons
    * 2 pedidos que utilizaram cupons
* 2 fornecedores
    * Associe os produtos com esses dois fornecedores
* 2 estoques
    * Adicione os produtos cadastrados nos estoque
- Entregar também a remoção de 1 cliente que não possua pedidos ou items no carrinho e a atualização da descrição e valor de um produto. 

A entrega pode ser feita no github e estar em um arquivo chamado `ecommerce-dml.sql.`


### Linguagens e Ferramentas Utilizadas
<div style="display: inline_block"><br>
  <img align="center" height="30" width="40" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg" />
  <img align="center" height="30" width="40" src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg" />
  <img align="center" height="30" width="40" src="https://freeprosoftz.com/wp-content/uploads/2021/10/logo-300x260.png" />
  <img align="center" height="30" width="100" src="https://dbeaver.com/wp-content/themes/utouch/img/dbeaver_logo_bg.png" />
</div>


### Grupo 08
* Luciana Ferreira
* Pedro Henrique Vieira da Silva
* Matheus Felipe Lima Domingos
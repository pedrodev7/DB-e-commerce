-- 1 Listar todos os cliente que tem o nome 'ANA'.> Dica: Buscar sobre função Like
select * from cliente where nome ilike 'ana%';

-- 2 Pedidos feitos em 2023
select * from pedido p where TO_CHAR(p.data_criacao, 'YYYY') = '2023';

-- 3 Pedidos feitos em Janeiro de qualquer ano
select * from pedido p where TO_CHAR(p.data_criacao, 'MM') = '01';

-- 4 Itens de pedido com valor entre R$2 e R$5
select * from item_pedido where valor between 2 and 5;

-- 5 Trazer o Item mais caro comprado em um pedido
select MAX(valor) from item_pedido;

-- 6 Listar todos os status diferentes de pedidos;
select distinct status from pedido;

-- 7 Listar o maior, menor e valor médio dos produtos disponíveis.
select max(valor) as MaiorValor, min(valor) as MenorValor, avg(valor) as MediaValor from produto;

-- 8 Listar fornecedores com os dados: nome, cnpj, logradouro, numero, cidade e uf de todos os fornecedores;
-- select * from fornecedor f;
select f.nome, f.cnpj, e.logradouro , e.numero , e.cidade , e.uf  from fornecedor f
join endereco e on f.id_endereco = e.id;

-- 9 Informações de produtos em estoque com os dados: id do estoque, descrição do produto, 
-- quantidade do produto no estoque, logradouro, numero, cidade e uf do estoque;
-- select * from item_estoque;
select e.id ,p.descricao,  ie.quantidade, ee.logradouro, ee.numero, ee.cidade, ee.uf  from item_estoque ie 
join produto p on ie.id_produto = p.id
join estoque e on ie.id_estoque = e.id
join endereco ee on e.id_endereco = ee.id;

-- 10 Informações sumarizadas de estoque de produtos com os dados: descrição do produto, código de barras, 
-- quantidade total do produto em todos os estoques;
-- select * from item_estoque ie where id_produto = 171;
-- select * from produto where id = 171;
select p.descricao , p.codigo_barras, sum(ie.quantidade) from produto p
left join item_estoque ie on p.id = ie.id_produto 
group by p.id;

-- 11 Informações do carrinho de um cliente específico (cliente com cpf '26382080861') com os dados: 
-- descrição do produto, quantidade no carrinho, valor do produto.
-- select * from item_carrinho ic where id_cliente = 96;
-- select * from cliente where cpf = '26382080861';
select p.descricao, ic.quantidade, p.valor  from produto p 
join item_carrinho ic on p.id = ic.id_produto
join cliente c on c.cpf = '26382080861' and c.id = ic.id_cliente;

-- 12 Relatório de quantos produtos diferentes cada cliente tem no carrinho ordenado pelo cliente que tem mais produtos no 
-- carrinho para o que tem menos, com os dados: id do cliente, nome, cpf e quantidade de produtos diferentes no carrinho.
select ic.id_cliente, c.nome, c.cpf , count(ic.id_cliente) as qtdproduto from item_carrinho ic
join cliente c ON ic.id_cliente = c.id 
group by ic.id_cliente, c.nome , c.cpf
order by count(ic.id_cliente) desc;

-- 13 Relatório com os produtos que estão em um carrinho a mais de 10 meses, ordenados pelo inserido a mais tempo, com os dados: 
-- id do produto, descrição do produto, data de inserção no carrinho, id do cliente e nome do cliente;
select p.id, p.descricao, ic.data_insercao, ic.id_cliente, c.nome  from item_carrinho ic
join produto p on p.id = ic.id_produto
join cliente c on c.id = ic.id_cliente 
where data_insercao < current_date - interval '10 months'
order by data_insercao desc;

-- 14 Relatório de clientes por estado, com os dados: uf (unidade federativa) e quantidade de clientes no estado;
select e.uf, count(e.uf) as quantidade_cliente from cliente c 
join endereco e on c.id_endereco = e.id
group by e.uf;

-- 15 Listar cidade com mais clientes e a quantidade de clientes na cidade;
select e.cidade, count(e.cidade) from cliente c 
join endereco e on c.id_endereco = e.id
group by e.cidade
order by count(e.cidade) desc
limit 1;

-- 16 Exibir informações de um pedido específico, pedido com id 952, com os dados 
-- (não tem problema repetir dados em mais de uma linha): nome do cliente, id do pedido, previsão de entrega, 
-- status do pedido, descrição dos produtos comprados, quantidade comprada produto, valor total pago no produto;
select c.nome, p.id, p.previsao_entrega, p.status, pr.descricao, ip.quantidade , ip.valor
from pedido p, cliente c, produto pr, item_pedido ip where p.id = 952;

-- 17 Relatório de clientes que realizaram algum pedido em 2022, com os dados: 
-- id_cliente, nome_cliente, data da última compra de 2022;
select p.id_cliente, c.nome , p.data_criacao from pedido p 
join cliente c on c.id = p.id_cliente
where TO_CHAR(p.data_criacao, 'YYYY') = '2022' 
and p.data_criacao = (select MAX(data_criacao) from pedido p2 where p2.id_cliente = p.id_cliente and TO_CHAR(p2.data_criacao, 'YYYY') = '2022' ) 
order by id_cliente asc;


-- 18 Relatório com os TOP 10 clientes que mais gastaram esse ano, com os dados: nome do cliente, valor total gasto;
select c.nome, sum(ip.quantidade * ip.valor) as total_Gasto from pedido p  
join item_pedido ip on ip.id_pedido = p.id and TO_CHAR(p.data_criacao, 'YYYY') = '2023' and status = 'SUCESSO'
join cliente c on p.id_cliente = c.id 
group by c.nome, p.id_cliente 
order by sum(ip.quantidade * ip.valor) desc
limit 10;

-- 19 Relatório com os TOP 10 produtos vendidos esse ano, com os dados: descrição do produto, 
-- quantidade vendida, valor total das vendas desse produto;
select p.descricao, sum(ip.quantidade) as qtd ,sum(ip.quantidade * ip.valor) as total_vendido, p.id from produto p 
join item_pedido ip on ip.id_produto = p.id
join pedido p2 on p2.id = ip.id_pedido and TO_CHAR(p2.data_criacao, 'YYYY') = '2023' and p2.status = 'SUCESSO'
group by p.descricao, p.id;

-- 20 Exibir o ticket médio do nosso e-commerce, ou seja, a média dos valores totais gasto em pedidos com sucesso;
select avg(ip.quantidade * ip.valor) from pedido p 
join item_pedido ip on p.id = ip.id_pedido and p.status ='SUCESSO';

-- 21 Relatório dos clientes gastaram acima de R$ 10000 em um pedido, com os dados: 
-- id_cliente, nome do cliente, valor máximo gasto em um pedido;
select p.id_cliente, c.nome, sum(ip.quantidade * ip.valor) as valor_total from pedido p 
join cliente c on p.id_cliente = c.id
join item_pedido ip on ip.id_pedido = p.id
group by p.id,p.id_cliente,c.nome
having sum(ip.quantidade * ip.valor)>10000
order by valor_total desc;

-- 22 Listar TOP 10 cupons mais utilizados e o total descontado por eles.

select c.descricao, p.id_cupom, count(p.id_cupom) qtd_utilizada, c.valor, sum(c.valor) valor_total_descontado
from pedido p, cupom c
where p.id_cupom = c.id 
group by p.id_cupom, c.descricao , c.valor 
order by qtd_utilizada desc limit 10;

-- 23 Listar cupons que foram utilizados mais que seu limite;
select c.id, count(p.id_cupom) as qtd_usado, c.limite_maximo_usos from cupom c
join pedido p on c.id = p.id_cupom
group by c.id, c.limite_maximo_usos
having c.limite_maximo_usos < count(p.id_cupom);

-- 24 Listar todos os ids dos pedidos que foram feitos por pessoas que moram em São Paulo 
-- (unidade federativa, uf, SP) e compraram o produto com código de barras '97692630963921';
select p.id from pedido p
join item_pedido ip on p.id = ip.id_pedido
join produto pr on ip.id_produto = pr.id 
join cliente c on p.id_cliente = c.id
join endereco e on c.id_endereco = e.id
where e.uf = 'SP' and pr.codigo_barras = '97692630963921';

-- 25 Faça um relatório de sua escolha, crie uma view para ele e faça uma consulta nessa view;
create view cliente_fornecedor as 
select 'CLIENTE' as tipo_cliente , c.id, c.nome, c.cpf as document_id
from cliente c
union
select 'FORNECEDOR' as tipo_cliente, f.id, f.nome, f.cnpj 
from fornecedor f
order by tipo_cliente asc;
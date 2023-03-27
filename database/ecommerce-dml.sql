-- SETUP PARA CONSEGUIR RODAR O SQL MAIS DE UMA VEZ

delete from item_pedido;
delete from pedido;
delete from item_carrinho;
delete from cupom;
delete from carrinho;
delete from cliente;
delete from endereco;
delete from produto;


ALTER SEQUENCE endereco_id_seq RESTART WITH 1;
ALTER SEQUENCE cliente_id_seq RESTART WITH 1;
ALTER SEQUENCE produto_id_seq RESTART WITH 1;
ALTER SEQUENCE cupom_id_seq RESTART WITH 1;
ALTER SEQUENCE carrinho_id_seq RESTART WITH 1;
ALTER SEQUENCE item_carrinho_id_seq RESTART WITH 1;
ALTER SEQUENCE pedido_id_seq RESTART WITH 1;
ALTER SEQUENCE item_pedido_id_seq RESTART WITH 1;

-- ENDEREÇO

INSERT INTO public.endereco
(cep, logradouro, numero, cidade, uf)
VALUES
	('54321250', 'Rua Um', '111', 'Recife', 'PE'),
	('54321878', 'Rua Dois', '222', 'Olinda', 'PE'),
    ('12345678', 'Rua Três', '333', 'São Paulo', 'SP'),
    ('87654321', 'Rua Quatro', '444', 'Brasília', 'DF'),
    ('55555333', 'Rua Cinco', '555', 'Porto Alegre', 'RS'),
    ('44444455', 'Rua Seis', '666', 'Salvador', 'BA');

-- CLIENTE
INSERT INTO public.cliente
(nome, cpf, id_endereco)
VALUES
    ('Matheus', '12345678901', 1),
    ('Luciana', '88888888552', 3),
    ('Pedro', '78787878999', 4),
    ('Maria', '55555444488', 2),
    ('João', '12354654622', 2);

-- PRODUTO
INSERT INTO public.produto
(descricao, codigo_barra, valor)
VALUES
    ('Monitor ASUS', '00000000000', 1000),
    ('Monitor Samsung', '111111111111', 1200),
    ('GPU NVidia 3060', '222222222222', 2000),
    ('GPU NVidia 1060', '333333333333', 950),
    ('Processador AMD Ryzen', '444444444444', 450);

-- CUPOM
INSERT INTO public.cupom
(data_inicio, data_expiracao, descricao, valor, cliente_id)
VALUES
    (CURRENT_DATE, '2023-04-28', 'Cupom R$ 10', 10, 1),
    (CURRENT_DATE, '2023-04-28', 'Cupom R$ 10', 10, 2),
    (CURRENT_DATE, '2023-04-28', 'Cupom R$ 15', 15, 3);
    
-- CARRINHO
INSERT INTO public.carrinho
(id_cliente)
VALUES
    (1),
    (2),
    (3),
    (4),
    (5);

-- ITEM CARRINHO
INSERT INTO public.item_carrinho
(id_produto, quantidade, data_insercao, id_carrinho)
VALUES
    (3, 1, CURRENT_DATE, 4),
    (4, 1, CURRENT_DATE, 4),
    (5, 1, CURRENT_DATE, 4),
    (1, 1, CURRENT_DATE, 5),
    (2, 1, CURRENT_DATE, 5),
    (3, 1, CURRENT_DATE, 5);

-- PEDIDO
INSERT INTO public.pedido
(previsao_de_entrega, meio_pagamento, status, data_criacao, id_cliente, id_cupom)
VALUES
    ('2023-04-28', 'Dinheiro', 'Finalizado', CURRENT_DATE, 1, 1),
    ('2023-04-28', 'Dinheiro', 'Finalizado', CURRENT_DATE, 2, 2);
   
INSERT INTO public.pedido
(previsao_de_entrega, meio_pagamento, status, data_criacao, id_cliente)
VALUES
    ('2023-04-28', 'Cartão de Crédito', 'Finalizado', CURRENT_DATE, 3),
    ('2023-04-28', 'Dinheiro', 'Finalizado', CURRENT_DATE, 3),
    ('2023-04-28', 'Cartão de Crédito', 'Finalizado', CURRENT_DATE, 4),
    ('2023-04-28', 'Cartão de Crédito', 'Finalizado', CURRENT_DATE, 5);

-- ITEM PEDIDO
INSERT INTO public.item_pedido
(id_pedido, id_produto, quantidade, valor)
VALUES
    (1, 1, 1, 1000),
    (1, 2, 1, 1200),
    (2, 1, 1, 1000),
    (2, 2, 1, 1200),
    (3, 3, 1, 2000),
    (3, 5, 1, 450),
    (4, 3, 1, 2000),
    (4, 5, 1, 450),
    (5, 1, 1, 1000),
    (5, 2, 1, 1200),
    (6, 1, 1, 1000),
    (6, 2, 1, 1200);

-- FORNECEDOR
INSERT INTO public.fornecedor
(cnpj, id_endereco)
VALUES
    ('12345678901234', 5),
    ('55555555554444', 6);

-- FORNECEDOR PRODUTO
INSERT INTO public.fornecedor_produto
(id_produto, id_fornecedor)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2);

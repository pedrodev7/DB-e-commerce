-- CLIENTE / FORNECEDOR / ENDERECO

CREATE  TABLE endereco ( 
	id                   serial  NOT NULL  ,
	cep                  char(8)  NOT NULL  ,
	logradouro           varchar(200)  NOT NULL  ,
	numero               varchar(30) DEFAULT 'Sem numero' NOT NULL  ,
	cidade               varchar(100)  NOT NULL  ,
	uf                   char(2)  NOT NULL  ,
	CONSTRAINT pk_endereco PRIMARY KEY ( id )
 );

CREATE  TABLE cliente ( 
	id                   serial  NOT NULL  ,
	nome                 varchar(895)  NOT NULL  ,
	cpf                  char(11)  NOT NULL  ,
	id_endereco          integer  NOT NULL  ,
	CONSTRAINT unq_cliente_cpf UNIQUE ( cpf ) ,
	CONSTRAINT pk_cliente PRIMARY KEY ( id )
 );

ALTER TABLE cliente ADD CONSTRAINT fk_cliente_endereco FOREIGN KEY ( id_endereco ) REFERENCES endereco( id );

CREATE  TABLE fornecedor ( 
	id                   serial  NOT NULL  ,
	cnpj                 integer  NOT NULL  ,
	id_endereco          integer  NOT NULL  ,
	CONSTRAINT pk_fornecedor PRIMARY KEY ( id ),
	CONSTRAINT unq_fornecedor_cnpj UNIQUE ( cnpj ) ,
	CONSTRAINT unq_fornecedor_endereco UNIQUE ( id_endereco ) 
 );

ALTER TABLE fornecedor ADD CONSTRAINT fk_fornecedor_endereco FOREIGN KEY ( id_endereco ) REFERENCES endereco( id );

-- PRODUTO / ESTOQUE / FORNECEDOR_PRODUTO

CREATE  TABLE produto ( 
	id                   serial  NOT NULL  ,
	descricao            varchar(1000)  NOT NULL  ,
	codigo_barra         varchar(44)  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	CONSTRAINT pk_produto PRIMARY KEY ( id ),
	CONSTRAINT unq_produto_codigo_barra UNIQUE ( codigo_barra ) 
 );

CREATE  TABLE estoque ( 
	id                   serial  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	CONSTRAINT pk_estoque PRIMARY KEY ( id )
 );

ALTER TABLE estoque ADD CONSTRAINT fk_estoque_quantidade FOREIGN KEY ( id_produto ) REFERENCES produto( id );

CREATE  TABLE fornecedor_produto ( 
	id_produto           integer  NOT NULL  ,
	id_fornecedor        integer  NOT NULL  ,
	CONSTRAINT pk_fornecedor_produto PRIMARY KEY ( id_produto, id_fornecedor )
 );

ALTER TABLE fornecedor_produto ADD CONSTRAINT fk_fornecedor_produto FOREIGN KEY ( id_fornecedor ) REFERENCES fornecedor( id );

ALTER TABLE fornecedor_produto ADD CONSTRAINT fk_fornecedor_produto_produto FOREIGN KEY ( id_produto ) REFERENCES produto( id );

-- PEDIDO / ITEM_PEDIDO / CUPOM

CREATE  TABLE cupom ( 
	id                   serial  NOT NULL  ,
	data_inicio          date DEFAULT CURRENT_DATE   ,
	data_expiracao       date  NOT NULL  ,
	descricao            varchar(1000)  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	cliente_id           integer    ,
	CONSTRAINT pk_cupom PRIMARY KEY ( id ),
	CONSTRAINT unq_cupom_cliente UNIQUE ( cliente_id ) 
 );

ALTER TABLE cupom ADD CONSTRAINT fk_cupom_cliente FOREIGN KEY ( cliente_id ) REFERENCES cliente( id );


CREATE  TABLE pedido ( 
	id                   serial  NOT NULL  ,
	previsao_de_entrega  date  NOT NULL  ,
	meio_pagamento       varchar(100)  NOT NULL  ,
	status               varchar(100)  NOT NULL  ,
	data_criacao		 date  NOT NULL  ,
	id_cliente           integer  NOT NULL  ,
	id_cupom             integer    ,
	CONSTRAINT pk_pedido PRIMARY KEY ( id ),
	CONSTRAINT unq_pedido UNIQUE ( id_cupom ) 
 );

ALTER TABLE pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY ( id_cliente ) REFERENCES cliente( id );

ALTER TABLE pedido ADD CONSTRAINT fk_pedido_cupom FOREIGN KEY ( id_cupom ) REFERENCES cupom( id );

CREATE  TABLE item_pedido ( 
	id_pedido            integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	CONSTRAINT pk_item_pedido PRIMARY KEY ( id_pedido, id_produto )
 );

ALTER TABLE item_pedido ADD CONSTRAINT fk_item_pedido_pedido FOREIGN KEY ( id_pedido ) REFERENCES pedido( id );

ALTER TABLE item_pedido ADD CONSTRAINT fk_item_pedido_produto FOREIGN KEY ( id_produto ) REFERENCES produto( id );

-- CARRINHO / ITEM_CARRINHO

CREATE  TABLE carrinho ( 
	id                   serial  NOT NULL  ,
	id_cliente           integer  NOT NULL  ,
	CONSTRAINT pk_carrinho PRIMARY KEY ( id ),
	CONSTRAINT unq_carrinho_cliente UNIQUE ( id_cliente ) 
 );

ALTER TABLE carrinho ADD CONSTRAINT fk_carrinho_cliente FOREIGN KEY ( id_cliente ) REFERENCES cliente( id );

CREATE  TABLE item_carrinho ( 
	id                   serial  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	data_insercao        date DEFAULT CURRENT_DATE   ,
	id_carrinho          integer  NOT NULL  ,
	CONSTRAINT pk_item_carrinho PRIMARY KEY ( id ),
 );

ALTER TABLE item_carrinho ADD CONSTRAINT fk_item_carrinho_carrinho FOREIGN KEY ( id_carrinho ) REFERENCES carrinho( id );

ALTER TABLE item_carrinho ADD CONSTRAINT fk_item_carrinho_produto FOREIGN KEY ( id_produto ) REFERENCES produto( id );


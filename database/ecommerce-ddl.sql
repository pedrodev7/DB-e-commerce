CREATE  TABLE produto ( 
	id                   serial  NOT NULL  ,
	descricao            varchar(1000)  NOT NULL  ,
	codigo_barra         varchar(44)  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	CONSTRAINT pk_produto PRIMARY KEY ( id ),
	CONSTRAINT unq_produto_codigo_barra UNIQUE ( codigo_barra ) 
 );

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
	CONSTRAINT pk_cliente PRIMARY KEY ( id ),
	CONSTRAINT unq_cliente UNIQUE ( id_endereco ) 
 );

ALTER TABLE cliente ADD CONSTRAINT fk_cliente_endereco FOREIGN KEY ( id_endereco ) REFERENCES endereco( id );

CREATE  TABLE pedido ( 
	id                   serial  NOT NULL  ,
	previsao_de_entrega  date  NOT NULL  ,
	meio_pagamento       varchar(100)  NOT NULL  ,
	status               varchar(100)  NOT NULL  ,
	id_cliente           integer    ,
	CONSTRAINT pk_pedido PRIMARY KEY ( id )
 );

ALTER TABLE pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY ( id_cliente ) REFERENCES cliente( id );

CREATE  TABLE item_pedido ( 
	id_pedido            integer  NOT NULL  ,
	id_produto           integer  NOT NULL  ,
	quantidade           integer  NOT NULL  ,
	valor                numeric  NOT NULL  ,
	CONSTRAINT pk_item_pedido PRIMARY KEY ( id_pedido, id_produto )
 );

ALTER TABLE item_pedido ADD CONSTRAINT fk_item_pedido_pedido FOREIGN KEY ( id_pedido ) REFERENCES pedido( id );

ALTER TABLE item_pedido ADD CONSTRAINT fk_item_pedido_produto FOREIGN KEY ( id_produto ) REFERENCES produto( id );










CREATE TABLE prd_produtos
(
	prd_id SERIAL PRIMARY KEY,
    prd_nome VARCHAR(30) NOT NULL,
    prd_codigo VARCHAR(50) DEFAULT '-'
);

CREATE TABLE unm_unidades_medida
(
	unm_id SERIAL PRIMARY KEY,
    unm_nome VARCHAR(30),
    unm_sigla VARCHAR(5) NOT NULL
);

ALTER TABLE prd_produtos
ADD COLUMN unm_id INT NOT NULL;
/*Adicionar uma nova coluna que o valor inteiro não pode ser NULO como unm_id */

INSERT INTO unm_unidades_medida
(unm_nome, unm_sigla)
VALUES ('Quilograma','Kg');

SELECT * FROM unm_unidades_medida;

INSERT INTO prd_produtos
(prd_nome, prd_codigo)
VALUES ('Carne', '1234');
-- ERROR! (Porque falta inserir uma coluna 'unm_id', pois foi registrado alterado!)

SELECT * FROM prd_produtos;

INSERT INTO prd_produtos
(prd_nome, prd_codigo, unm_id)
VALUES ('Carne', '1234','1');
-- SUCESSO!

INSERT INTO prd_produtos
(prd_nome, prd_codigo, unm_id)
VALUES ('Bolacha', '3456A','2');
-- SUCESSO, mas isso é erro que o banco de dado não cumiriu sua finalidade, pois não existe 2 de unm_id enquanto existe apenas 1.

DELETE FROM prd_produtos WHERE prd_id = 2;
/*Remover toda uma linha de prd_id = 2 */

ALTER TABLE prd_produtos
ADD CONSTRAINT fk_prd_produtos__unm_unidades_medida_unm_id
FOREIGN KEY(unm_id) REFERENCES unm_unidades_medida(unm_id);
/* ELE NÃO PODE ADICIONAR A FOREIGN KEY, POIS ELAS PRECISAM TER O MESMO TIPO DE DADO ENTRE A COLUNA QUE FAZ REFERENCIA 
POR CAUSA (ADD COLUMN unm_id INT NOT NULL;) 
	+ A FOREIGN KEY restrição é usada para evitar ações que destruiriam links entre tabelas.
		A FOREIGN KEY é um campo (ou coleção de campos) em uma tabela, que se refere a PRIMARY KEY outra tabela. 
	+ REFERENCES é uma referência como uma forma de criar um link entre duas tabelas. */

ALTER TABLE prd_produtos CHANGE COLUMN unm_id unm_id BIGINT UNSIGNED NOT NULL; 
/*CHANGE COLUMN ==> MUDAR COLUNA
BIGINT ==> Deve ser usado quando valores inteiros podem exceder o intervalo.
UNSIGNED ==> Armazena apenas números positivos (ou zero). Por outro lado, assinado pode armazenar números negativos.*/

INSERT INTO prd_produtos
(prd_nome, prd_codigo, unm_id)
VALUES ('Bolacha', '3456A','2');
-- ERROR! Porque não existe 2 unm_id na tabela de unidades de medidas enquanto somente 1!

INSERT INTO unm_unidades_medida
(unm_nome, unm_sigla)
VALUES ('Pacote','pc');

UPDATE unm_unidades_medida
SET unm_sigla ='Pc'
WHERE unm_id = 2;

INSERT INTO prd_produtos
(prd_nome, prd_codigo, unm_id)
VALUES ('Bolacha', '3456A','2');
-- SUCESSO!

CREATE TABLE cmp_compras
(
	cmp_id SERIAL PRIMARY KEY,
    cmp_data_hora DATETIME NOT NULL DEFAULT NOW(),
    cmp_valor_pago DECIMAL(8,2) NOT NULL,
    cli_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (cli_id) REFERENCES cli_clientes(cli_id)
);
/*OBS: DATETIME NOT NULL DEFAULT NOW() ==> A DATA E A HORA DA COMPRA SÃO OBRIGATÓRIOS, SE NÃO ESPECIFICAR A DATA E HORA DA COMPRA, 
ELE VAI PEGAR A DATA E HORA ATUAIS!*/

CREATE TABLE cmp_prd_compras_produtos
(
	prd_id BIGINT UNSIGNED NOT NULL,
    cmp_id BIGINT UNSIGNED NOT NULL,
    cm_prd_quantidade INT NOT NULL,
    cmp_prd_preco DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (prd_id, cmp_id),
    FOREIGN KEY (prd_id) REFERENCES prd_produtos(prd_id),
	FOREIGN KEY (cmp_id) REFERENCES cmp_compras(cmp_id)
);
/*DECIMAL(8,2) ==> seja capaz de armazenar qualquer valor com 8 dígitos e duas casas decimais, assim valores que podem ser armazenados. */
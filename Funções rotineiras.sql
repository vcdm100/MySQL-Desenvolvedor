SELECT cli.cli_nome, SUM(cmp.cmp_valor_pago)
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
GROUP BY cli.cli_id;
/*SUM --> SOMA DO VALOR PAGO NAS COMPRAS VINCULADAS.
GROUP BY --> Cria um grupo para cada combinação de expressões de coluna. */

SELECT cli.cli_nome, 
		COALESCE(SUM(cmp.cmp_valor_pago),0),
        COUNT(*)
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
GROUP BY cli.cli_id;
/*COUNT() --> Função retorna o número de linhas que corresponde a um critério especificado.*/

SELECT cli.cli_nome, 
		COALESCE(SUM(cmp.cmp_valor_pago),0),
        COUNT(cmp.cmp_id)
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
GROUP BY cli.cli_id;
/*VAI APARECER APENAS 1 QUANDO FOR COMPRA VINCULADA! E SENAO SERÁ ZERO! --> COUNT(cmp.cmp_id) */

SELECT * FROM cmp_compras;
SELECT * FROM prd_produtos;
SELECT * FROM cmp_prd_compras_produtos;

DESC cmp_prd_compras_produtos;
/*DESC --> É usado para classificar os dados retornados em ordem decrescente, COMO INFORMAÇÕES DE DADOS. */

INSERT INTO cmp_prd_compras_produtos
(prd_id, cmp_id, cm_prd_quantidade, cmp_prd_preco)
VALUES (1,1,2,50);
-- SUCESSO!

INSERT INTO cmp_prd_compras_produtos
(prd_id, cmp_id, cm_prd_quantidade, cmp_prd_preco)
VALUES (5,3,9,30.5);
-- SUCESSO! APENAS FUNCIONA QUANDO FOR ENCONTRAR OS VALORES DE ID (prd_id ==> tabela mostrou apenas 1 ou 5 e cmp_id ==> tabela mostrou 1 ou 3).

INSERT INTO cmp_prd_compras_produtos
(prd_id, cmp_id, cm_prd_quantidade, cmp_prd_preco)
VALUES (1,3,1,50);
-- SUCESSO!

SELECT cli.cli_nome, 
		COALESCE(SUM(cmp.cmp_valor_pago),0),
        COUNT(cmp.cmp_id)
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
INNER JOIN cmp_prd_compras_produtos cmp_prd
	ON cmp.cmp_id = cmp_prd.cmp_id
INNER JOIN prd_produtos prd
	ON cmp_prd.prd_id = prd.prd_id
GROUP BY cli.cli_id;
-- SUCESSO! 

SELECT *
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
INNER JOIN cmp_prd_compras_produtos cmp_prd
	ON cmp.cmp_id = cmp_prd.cmp_id
INNER JOIN prd_produtos prd
	ON cmp_prd.prd_id = prd.prd_id;
-- SUCESSO! TODAS AS INFORMAÇÕES DA LINHA DE BRUNA COMO CLIENTE COMPROU!

SELECT cli.cli_nome, 
		COALESCE(SUM(cmp.cmp_valor_pago),0),
        COUNT(DISTINCT(cmp.cmp_id))
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
INNER JOIN cmp_prd_compras_produtos cmp_prd
	ON cmp.cmp_id = cmp_prd.cmp_id
INNER JOIN prd_produtos prd
	ON cmp_prd.prd_id = prd.prd_id
GROUP BY cli.cli_id;
-- SUCESSO!
/* DISTINCT() --> É ELIMINAR registros duplicados dependendo de TODOS os campos listados no respectivo SELECT. */

SELECT cli.cli_nome, 
		COALESCE(SUM(DISTINCT(cmp.cmp_valor_pago)),0),
        COUNT(DISTINCT(cmp.cmp_id)),
		AVG(cmp_prd.cm_prd_quantidade * cmp_prd.cmp_prd_preco)
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
INNER JOIN cmp_prd_compras_produtos cmp_prd
	ON cmp.cmp_id = cmp_prd.cmp_id
INNER JOIN prd_produtos prd
	ON cmp_prd.prd_id = prd.prd_id
GROUP BY cli.cli_id;
-- SUCESSO! AVG ==> Calcula a média aritmética de um conjunto de valores contidos em um campo especificado em uma consulta.

SELECT cli.cli_nome, 
		COALESCE(SUM(DISTINCT(cmp.cmp_valor_pago)),0) valor_pago,
        COUNT(DISTINCT(cmp.cmp_id)) quantidade_compras,
        AVG(cmp_prd.cm_prd_quantidade * cmp_prd.cmp_prd_preco) media_preco_produto
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
INNER JOIN cmp_prd_compras_produtos cmp_prd
	ON cmp.cmp_id = cmp_prd.cmp_id
INNER JOIN prd_produtos prd
	ON cmp_prd.prd_id = prd.prd_id
GROUP BY cli.cli_id;
-- SUCESSO! ==> os valores de valor_pago, quantidade_compras e media_preco_produto.

SELECT cli.cli_nome, 
		COALESCE(SUM(DISTINCT(cmp.cmp_valor_pago)),0) valor_pago,
        COUNT(DISTINCT(cmp.cmp_id)) quantidade_compras,
        AVG(cmp_prd.cm_prd_quantidade * cmp_prd.cmp_prd_preco) media_preco_produto
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
INNER JOIN cmp_prd_compras_produtos cmp_prd
	ON cmp.cmp_id = cmp_prd.cmp_id
INNER JOIN prd_produtos prd
	ON cmp_prd.prd_id = prd.prd_id
GROUP BY cli.cli_id
HAVING COUNT(cmp_prd.cmp_id) > 1;
-- SUCESSO! HAVING ==> para permitir a filtragem dos resultados da consulta com base em funções agregadas e agrupamentos, 
-- o que não pode ser alcançado usando a cláusula WHERE que é usada para filtrar linhas individuais.
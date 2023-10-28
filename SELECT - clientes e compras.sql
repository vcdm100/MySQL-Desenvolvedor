SELECT * FROM cli_clientes;
SELECT * FROM cmp_compras;

SELECT * 
FROM cli_clientes, cmp_compras;
/*JUNTOS AS DUAS TABELAS DE CLIENTES E DAS COMPRAS, MAS NÃO POSSUI NENHUMA INFORMAÇÕES*/

INSERT INTO cmp_compras
(cmp_data_hora, cmp_valor_pago, cli_id)
VALUES 
(NOW(), 150.0023,6);
/*ATENÇÃO (AMARELO) ==> Porque DECIMAL(8,2) como até duas casas decimais, o valor inserido 
mostrou as 4 casas decimais, por isso deu atenção, mas foi registrado!*/

INSERT INTO cmp_compras
(cmp_data_hora, cmp_valor_pago, cli_id)
VALUES 
(NOW(), 150.00,6);
-- SCUESSO!

DELETE FROM cmp_compras WHERE cmp_id = 2; 
/* Remover toda uma linha de cmp_id = 2 */

SELECT * 
FROM cli_clientes, cmp_compras
WHERE cli_clientes.cli_id = cmp_compras.cli_id;
/* Vai pegar apenas uma linha princpal ID de cliente como cli_id */

INSERT INTO cmp_compras
(cmp_data_hora, cmp_valor_pago, cli_id)
VALUES 
(NOW(), 75.00,1);
-- SUCESSO!

SELECT cli_clientes.cli_nome, cli_clientes.cli_cpf, cmp_compras.cmp_data_hora,
		cmp_compras.cmp_valor_pago
FROM cli_clientes, cmp_compras 
WHERE cli_clientes.cli_id = cmp_compras.cli_id;
/* Vai pegar apenas algumas colunas: nome, cpf, data_hora e valo_pago */

SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora, cmp.cmp_valor_pago
FROM cli_clientes AS cli, cmp_compras AS cmp 
WHERE cli.cli_id = cmp.cli_id;
/* AS ==> é para substituir uma palvra mais resuma como apelido
cli.clientes --> cli e cmp_compras --> cmp */

SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora, cmp.cmp_valor_pago
FROM cli_clientes cli, cmp_compras cmp 
WHERE cli.cli_id = cmp.cli_id;
/* O resultado é exatamante mesmo sem AS */

SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora, cmp.cmp_valor_pago
FROM cli_clientes cli
INNER JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
WHERE cmp.cmp_valor_pago > 100;
/*Vai pegar uma linha quando for o valor mais 100 (cmp_valor_pago), que vai aparecer!*/

SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora, cmp.cmp_valor_pago
FROM cli_clientes cli
INNER JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id;
/*Vai pegar os valores pagos somente inseridos na tabela*/

SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora, cmp.cmp_valor_pago
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id;
/* VAI APARECER OS VALORES PAGOS INSERIDOS E TAMBÉM NULL OU SEJA NENHUMA COMPRA */

SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora, COALESCE(cmp.cmp_valor_pago, 0)
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id;
/*COALESCE (qual coluna, qual valor será colcoado) ==> É utilizada quando um conjunto de campos for passado 
e deve ser retornado o primeiro não nulo. */

SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora, COALESCE(cmp.cmp_valor_pago, 0)
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
	ON cli.cli_id = cmp.cli_id
WHERE cmp.cmp_data_hora IS NULL;
/*VAI APARECER APENAS AS DATAS COM NULL*/

SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora, COALESCE(cmp.cmp_valor_pago, 0)
FROM cmp_compras cmp
RIGHT JOIN cli_clientes cli
	ON cli.cli_id = cmp.cli_id;
/*MESMO RESULTADO DE LEFT JOIN, MAS APENAS TROCAR, 
	FORM cli_clientes cli --> cmp_compras cmp  
    RIGHT JOIN cmp_compras cmp  --> cli_clientes cli */
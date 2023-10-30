CREATE OR REPLACE VIEW vw_relatorio_clientes AS
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

SELECT * FROM vw_relatorio_clientes
WHERE cli_nome LIKE '%C%';
-- SUCESSO!

DROP VIEW vw_relatorio_clientes;
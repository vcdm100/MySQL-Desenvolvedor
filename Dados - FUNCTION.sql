CREATE FUNCTION fn_ola() 
RETURNS VARCHAR(10) 
DETERMINISTIC
	RETURN 'Olá';

SELECT fn_ola();
SELECT NOW(); -- DATA E HORA ATUAL 
-- SUCESSO!

DROP FUNCTION fn_ola;
/* O COMANDO DROP ELE ESPERA O NOME DO OBJETO E OS PARÊNTESES NÃO FAZEM PARTE DA DEFINIÇÃO DO NOME DA FUNÇÃO*/

/* =========================================================================================================== */

-- DESC cmp_prd_compras_produtos;

DELIMITER $$ -- É usada para alterar temporariamente a característica de delimitação no MySQL.

CREATE FUNCTION fn_calcular_valor_compra(p_id_compra BIGINT) -- Esta linha inicia a definição de uma nova função chamada fn_calcular_valor_compra. Esta função aceita um parâmetro chamado p_id_comprado tipo BIGINT.
RETURNS DECIMAL(8,2)
DETERMINISTIC -- Esta é uma cláusula opcional que indica que a função produzirá o mesmo resultado para os mesmos argumentos de entrada. Isso significa que, dadas as mesmas entradas, a função sempre retornará o mesmo resultado.
BEGIN
	DECLARE v_valor_compra DECIMAL(8,2);
	SELECT SUM(cm_prd_quantidade * cmp_prd_preco)
    INTO v_valor_compra
		FROM cmp_prd_compras_produtos
        WHERE cmp_id = p_id_compra; -- Esta é uma consulta SQL que calcula o valor total da compra com base no p_id_comprafornecido como entrada. Ela multiplica a quantidade de cada produto pelo preço unitário e depois soma todos os produtos relacionados à compra especificada.
	RETURN v_valor_compra; -- Esta linha indica que o valor contido na variável v_valor_compraserá o valor de retorno da função.
END $$

DELIMITER ;
-- SUCESSO!

SELECT * FROM cmp_prd_compras_produtos;

SELECT fn_calcular_valor_compra(cmp_id)
FROM cmp_prd_compras_produtos;
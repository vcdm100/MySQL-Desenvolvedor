DELIMITER $$

CREATE PROCEDURE sp_registrar_compra(IN p_valor_pago DECIMAL,
									 IN p_cli_id BIGINT,
                                     IN p_prd_id BIGINT,
                                     IN p_quantidade INT,
                                     IN p_preco DECIMAL)
BEGIN
	DECLARE v_cmp_id BIGINT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
		ROLLBACK;
        SELECT 'Deu ruim'; 
    END;
	START TRANSACTION;
    INSERT INTO cmp_compras (cmp_data_hora, cmp_valor_pago, cli_id)
		VALUES (NOW(), p_valor_pago, p_cli_id);
	SET v_cmp_id = LAST_INSERT_ID();
    INSERT INTO cmp_prd_compras_produtos VALUES(p_prd_id, v_cmp_id, p_quantidade, p_preco);
    COMMIT;
    SELECT 'OK';
END $$

DELIMITER ;
-- SUCESSO!

DESC cmp_compras;
DESC cmp_prd_compras_produtos;

CALL sp_registrar_compra(200, 2, 1, 1, 150);
-- SUCESSO! --> OK

SELECT * FROM cmp_compras;
SELECT * FROM cmp_prd_compras_produtos;

CALL sp_registrar_compra(500, 4, 3, 7, 236.70);
-- SUCESSO! --> DEU RUIM PORQUE NÃO EXISTE 3 DE prd_id!

CALL sp_registrar_compra(500, 4, 5, 7, 236.70);
-- SUCESSO! --> OK PORQUE EXISTE 5 DE prd_id!

CALL sp_relatorio_clientes(@v_total_linhas);
SELECT @v_total_linhas;
SELECT * FROM dw_relatorio_clientes;

/*
- cmp_valor_pago
- cli_id
- prd_id
- cm_prd_quantidade
- cmp_prd_preco
*/

SELECT last_insert_id();
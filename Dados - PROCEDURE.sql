DELIMITER $$

CREATE PROCEDURE sp_ola(IN p_nome VARCHAR(100))
BEGIN 
	SELECT CONCAT('Olá, ', p_nome);
END $$

DELIMITER ;

DROP PROCEDURE sp_ola;

CALL sp_ola('Victor Cláudio');
-- SUCESSO!

/* =========================================================================================================== */
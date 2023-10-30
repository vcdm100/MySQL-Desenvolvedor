DELIMITER $$

CREATE TRIGGER tr_registro_compra AFTER INSERT ON cmp_compras
FOR EACH ROW -- Esta linha inicia a definição de um novo gatilho chamado tr_registro_compra. Este gatilho é acionado automaticamente após uma nova linha ser inserida na tabela cmp_compras.
BEGIN
	INSERT INTO log_logs(log_mensagem) -- Esta é uma instrução SQL que insere uma nova linha na tabela log_logs. Ela tem um valor para o campo log_mensagem.
    VALUES
    (CONCAT('Compra realizada em ', DATE_FORMAT(NEW.cmp_data_hora, '%d/%M/%Y %H:%m:%s'))); -- A mensagem é construída com a função CONCAT, que junta duas strings. A primeira parte é uma string fixa 'Compra realizada em '. A segunda parte é a data e hora da nova compra ( NEW.cmp_data_hora) formatada usando DATE_FORMATum formato específico ( '%d/%M/%Y %H:%m:%s').
END $$

DELIMITER ;
-- SUCESSO!

DROP TRIGGER tr_registro_compra;

CREATE TABLE log_logs
(
	log_id SERIAL PRIMARY KEY,
    log_mensagem VARCHAR(1000) NOT NULL
);

SELECT * FROM cmp_compras;

INSERT INTO cmp_compras(cmp_data_hora, cmp_valor_pago, cli_id)
VALUES 
(NOW(), 125.00, 1);

SELECT * FROM log_logs;
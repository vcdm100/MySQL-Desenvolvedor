DELIMITER $$ -- Defina o delimitador para $$ em vez do padrão;. Isso permite que o script SQL inclua comandos de múltiplas linhas.

CREATE PROCEDURE sp_relatorio_clientes(OUT p_linhas_processadas INT) -- Cria um procedimento armazenado chamado sp_relatorio_clientes que aceita um parâmetro de saída p_linhas_processadasdo tipo INT.
BEGIN -- É usada para iniciar um bloco de código que consiste em uma série de comandos SQL. Junto com END, ela delimita o início e o fim desse bloco de código.
    DECLARE v_nome_cliente VARCHAR(100);
    DECLARE v_valor_pago DECIMAL(8,2);
    DECLARE v_quantidade_compras INT;
    DECLARE v_media_preco_produto DECIMAL;
    DECLARE v_finalizado INTEGER DEFAULT 0; -- Declara uma variável chamada v_finalizadodo tipo INTEGER e inicializa com o valor 0.
    
    DECLARE cr_relatorio_clientes CURSOR FOR
        SELECT * FROM vw_relatorio_clientes; -- Declara um cursor chamado cr_relatorio_clientes para percorrer o conjunto de resultados da consulta SELECT * FROM vw_relatorio_clientes;.
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finalizado = 1; -- Defina um manipulador de exceção para o caso em que não há mais linhas para serem lidas no cursor. Nesse caso, ele define v_finalizadocomo 1.
    
    SET p_linhas_processadas = 0; -- Inicializa o parâmetro de saída p_linhas_processadascom o valor 0.
    
    DELETE FROM dw_relatorio_clientes; -- Execute um comando DELETE para limpar a tabela dw_relatorio_clientes.
    
    OPEN cr_relatorio_clientes; -- Abra o cursor cr_relatorio_clientespara começar a percorrer os resultados.
    
    loop_relatorio_clientes: LOOP -- Defina um rótulo loop_relatorio_clientespara o loop.
        FETCH cr_relatorio_clientes INTO v_nome_cliente, v_valor_pago, v_quantidade_compras, v_media_preco_produto;
        -- Leia os valores da próxima linha no cursor e os armazenamentos nas variáveis ​​declaradas.
        
        IF v_finalizado = 1 THEN
            LEAVE loop_relatorio_clientes;
        END IF;
        -- Se v_finalizadofor 1 (indicando que não há mais dados), o loop é interrompido.
        
        INSERT INTO dw_relatorio_clientes 
            VALUES (v_nome_cliente, v_valor_pago, v_quantidade_compras, v_media_preco_produto);
		-- Insira os valores lidos na tabela dw_relatorio_clientes.
        
        SET p_linhas_processadas = p_linhas_processadas + 1; -- Atualiza o parâmetro de saída p_linhas_processadaspara contar o número de linhas processadas.
    END LOOP loop_relatorio_clientes; -- Marca o fim do loop.
    
    CLOSE cr_relatorio_clientes; -- Perto do cursor.
END $$; -- Marca o fim do corpo do procedimento.

DELIMITER ; -- Restaurar o delimitador para o padrão (;).
-- SUCESSO!

SELECT * FROM vw_relatorio_clientes;

CREATE TABLE dw_relatorio_clientes
(
	cli_nome VARCHAR(100) NOT NULL,
    valor_pago DECIMAL(8,2) NOT NULL,
    quantidade_compras INT,
    media_preco_produto DECIMAL NOT NULL
);

-- DROP TABLE dw_relatorio_clientes;

CALL sp_relatorio_clientes(@v_linhas_processadas); -- Chama o procedimento armazenado sp_relatorio_clientese passa uma variável @v_linhas_processadaspara receber o número de linhas processadas.
-- SUCESSO!

SELECT * FROM dw_relatorio_clientes;
-- ID, Nome, Data de Nascimento, Logradouro

CREATE TABLE cli_clientes
(
	-- cli_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	cli_id SERIAL PRIMARY KEY, -- BIGINT NOT NULL AUTO_INCREMENT UNSIGNED UNIQUE
    cli_nome VARCHAR(50) NOT NULL,
    cli_data_nascimento DATE,
    cli_logradouro VARCHAR(200)
);

DROP TABLE cli_clientes;

INSERT INTO cli_clientes (cli_nome, cli_data_nascimento, cli_logradouro) 
VALUES ('Victor Cláudio','1998-11-04','Rua Primeiro Janeiro, n 100');
-- SUCESSO!

INSERT INTO cli_clientes (cli_data_nascimento, cli_logradouro) 
VALUES ('1998-11-04','Rua Primeiro Janeiro, n 100');
-- ERROR (Porque 'cli_nome' é obrigatório ==> NOT NULL)!

INSERT INTO cli_clientes (cli_nome) 
VALUES ('Victor Cláudio');
-- SUCESSO!

SELECT cli_id, cli_nome, cli_data_nascimento, cli_logradouro
FROM cli_clientes;
-- ou
SELECT *
FROM cli_clientes; /* '*' ==> Selecionar todas as colunas da tabela de clientes*/

SELECT cli_id, cli_nome
FROM cli_clientes; /*OBS: Somente com as colunas de ID e de nomes*/

SELECT *
FROM cli_clientes
WHERE cli_id = 1; /*É escolher para focar qual um de registros id = 1 ou = 2 */

SELECT *
FROM cli_clientes
WHERE cli_data_nascimento IS NULL; /*Sem IS, não funciona porque IS deve verificar
o campo possui NULL*/

ALTER TABLE cli_clientes
ADD COLUMN cli_cpf CHAR(14) NOT NULL DEFAULT 'Falta' AFTER cli_nome;
/*ADD COLUMN ==> Adicionar uma nova Coluna
(14) ==> 14 dígitos como '000.000.000-00'
DEFAULT ==> Quando CPF não for especificado, irá colocar 'Falta' no campo
AFTER ==> CPF vai ser colocada logo após a coluna de 'cli_nome' */

ALTER TABLE cli_clientes
DROP COLUMN cli_cpf;
/*DROP COLUMN ==> Remover uma nova Coluna*/

INSERT INTO cli_clientes
(cli_nome, cli_CPF, cli_data_nascimento, cli_logradouro)
VALUES ('Vinicius','064.456.987-83','1998-12-05','Rua Primeiro Janeiro, n 100');

INSERT INTO cli_clientes
(cli_nome, cli_data_nascimento, cli_logradouro)
VALUES ('Simone','1971-08-30','Rua Jose maria, n 1213');
/*CPF seria obrigatório mas se for a cláusula DEFAULT, vai assumir o valor 'Falta' */

UPDATE cli_clientes
SET cli_cpf='064.452.652-99'; 
-- ERROR (Porque 'cli_cpf' seria atualizar tudo na coluna de cpf, seria estranho algo)!

UPDATE cli_clientes
SET cli_cpf='064.452.652-99'
WHERE cli_id = 4; 
-- SUCESSO! Com WHERE!

SELECT * FROM cli_clientes;

UPDATE cli_clientes
SET cli_cpf='022.093.12-00', cli_logradouro = 'Avenida Teste Modificada'
WHERE cli_id = 4; 
/* cli_cpf '064.452.652-99' ==> alterar novo cpf ==> '022.093.12-00'
mesma coisa de cli_logradouro*/

ALTER TABLE cli_clientes
ADD CONSTRAINT UN_CLI_CLIENTES__CLICPF UNIQUE (cli_cpf);
/* ADD CONSTRAINT ==> ADICIONAR UMA CONSTANTE PARA VINCULAR UMA CONSTANTE 
DE VERIFICAÇÃO DE UNIDADE DO CPF*/

UPDATE cli_clientes
SET cli_cpf='004.998.781-50'
WHERE cli_id = 1; 
/* Porque ADD CONSTRAINT não conseguiu, pois há valores duplicados como Falta então
deve um cpf ser alterado! */

UPDATE cli_clientes
SET cli_cpf='111.222.333-44'
WHERE cli_id = 2; 
/*CPF deve ser alterado 'Falta" para esse novo número*/

ALTER TABLE cli_clientes
ADD CONSTRAINT UN_CLI_CLIENTES__CLICPF UNIQUE (cli_cpf);

UPDATE cli_clientes
SET cli_cpf='111.222.333-44'
WHERE cli_id = 3; 
-- ERROR (Porque após UNIQUE foi registrado, não perimiu valor cpf seria duplicado de cli_id 2)!

ALTER TABLE cli_clientes DROP INDEX UN_CLI_CLIENTES__CLICPF;
/* REMOVER UMA UMA CONSTANTE, PARA RETORNAR O RESULTADO ANTIGO, O VALOR PODE SER DUPLICADO*/

UPDATE cli_clientes
SET cli_cpf='234.678.009-11'
WHERE cli_id = 3; 
-- SUCESSO!

SELECT * 
FROM cli_clientes
WHERE cli_data_nascimento IS NULL OR cli_logradouro IS NULL;
/* ATENDE ESSE FILTRO QUANDO ELE NÃO TEM DATA DE NASCIMENTO ou TAMBÉM NÃO TEM LOGRADOURO, que
VAI APARECER dois IDS COM MESMO 'NULL'de cli_logradouro ou cli_data_nascimento */

UPDATE cli_clientes
SET cli_logradouro = NULL
WHERE cli_id = 4;
/* SER ALTERADO PARA NULL*/

SELECT * 
FROM cli_clientes
WHERE cli_data_nascimento IS NULL AND cli_logradouro IS NULL;
/* ATENDE ESSE FILTRO QUANDO ELE NÃO TEM DATA DE NASCIMENTO E SE TAMBÉM NÃO TEM LOGRADOURO, que
VAI APARECER disso */

SELECT * 
FROM cli_clientes
WHERE cli_data_nascimento IS NOT NULL AND cli_logradouro IS NULL;
/* ATENDE ESSE FILTRO QUANDO ELE TEM DATA DE NASCIMENTO (IS NOT NULL) E SE TAMBÉM NÃO TEM LOGRADOURO 
(IS NULL), que VAI APARECER! */

SELECT * 
FROM cli_clientes
WHERE cli_data_nascimento IS NOT NULL AND cli_logradouro IS NOT NULL;
/* ATENDE ESSE FILTRO QUANDO ELE TEM DATA DE NASCIMENTO (IS NOT NULL) E SE TAMBÉM TEM LOGRADOURO 
(IS NOT NULL), que VAI APARECER!*/

SELECT * 
FROM cli_clientes
WHERE cli_nome = 'V';
/* PORQUE NÃO TEM NINGUÉM COM O NOME V, QUE NENHUM REGISTRO FOI OBTIDO NO MOMENTO QUANDO EXECUTA 
NA CONSULTA*/

SELECT * 
FROM cli_clientes
WHERE cli_nome LIKE 'V%';
/* PORQUE LIKE 'V%' ==> APENAS ATENDE A PRIMEIRA LETRA DO NOME COMO V ==> '"V"ictor Cláudio' ou '"V"inicius' */

SELECT * 
FROM cli_clientes
WHERE cli_nome LIKE 'Vini%';
/* PORQUE LIKE 'Vini%' ==> APENAS ATENDE VINI DO NOME COMO Vini ==> '"Vini"cius' */

SELECT * 
FROM cli_clientes
WHERE cli_nome LIKE '%o';
/* PORQUE LIKE '%o' ==> APENAS ATENDE ÚLTIMA LETRA DO NOME COMO o ==> 'Victor Cláudi"o"' */

SELECT * 
FROM cli_clientes
WHERE cli_nome LIKE '%mo%';
/* PORQUE LIKE '%mo%' ==> APENAS ATENDE ONDE ACHAR DUAS LETRAS JUNTOS DO NOME QUALQUER COMO mo ==> 'Si"mo"ne' */

SELECT LOWER('VICTOR');
/* MAIÚSCULAS´PARA MINÚSCULAS */

SELECT UPPER('victor');
/* MINÚSCULAS para MAIÚSCULAS */

SELECT * 
FROM cli_clientes
WHERE LOWER(cli_nome) LIKE 's%';
/* PORQUE 's%' ==> PODE SER QUALQUER MAIÚSCULAS OU MINÚSCULAS, VAI ATENDER MESMO JEITO */

SELECT * 
FROM cli_clientes
WHERE UPPER(cli_nome) LIKE '%MO%';
/* PORQUE '%MO' ==> PODE SER QUALQUER MAIÚSCULAS OU MINÚSCULAS, VAI ATENDER MESMO JEITO */

INSERT INTO cli_clientes
(cli_nome, cli_CPF, cli_data_nascimento, cli_logradouro)
VALUES ('Bruna','112.307.098-12','1997-04-29','Rua francisco da cunha, n 342');

INSERT INTO cli_clientes
(cli_nome, cli_CPF, cli_data_nascimento, cli_logradouro)
VALUES ('Bruno','555.555.555-25','1985-01-30','Rua Teste 2');

INSERT INTO cli_clientes
(cli_nome, cli_CPF, cli_data_nascimento, cli_logradouro)
VALUES ('Brona','888.888.888-88','1989-07-26','Rua Teste 3');

SELECT * FROM cli_clientes;

SELECT * 
FROM cli_clientes
WHERE cli_nome = 'Bruna' OR cli_nome = 'Bruno' OR cli_nome = 'Brona';

SELECT * 
FROM cli_clientes
WHERE SOUNDEX(cli_nome) = SOUNDEX('Bruna');
/* Avalie a semelhança de duas strings e retorna um código de quatro caracteres, 
que vai APARECER como 'Br'una, 'Br'uno e 'Br'ona, isso são as fonéticas */

SELECT cli_nome, cli_data_nascimento, TIMESTAMPDIFF(YEAR, cli_data_nascimento, CURDATE())
FROM cli_clientes;
/* PARA OBTER A DIFERENÇA EM ANOS ENTRE A DATA ATUAL E A DATA DE NASCIMENTO!
A IDADE DE CADA UM DELES --> TIMESTAMPDIFF ==> retorna um valor após subtrair uma expressão de data e hora de outra
COMO SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, or YEAR. E CURDATE ==> Retorne a data atual! */
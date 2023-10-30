/* STORED PROCEDURES

São programas/procedimentos armazenados no servidor, pré-compilados, chamados de forma explícita 
para executar alguma lógica de manipulação de dados.

-- 	CREATE PROCEDURE proc_name([parameters, ...])[characteristics]
	[BEGIN]
		corpo_da_rotina;
	[END]

--> proc_name: o procedimento armazenado deve ter um nome para que seja possível invoca-lo;
--> parameters: nessa parte do procedimento, informam-se os parâmetros da seguinte forma: [IN | OUT | INOUT] 
nome_parametro tipo_dado. Sendo que:
		IN: parâmetro de entrada, ou seja: um parâmetro cujo valor será utilizado no interior do procedimento para produzir 
        algum resultado;
		OUT: este parâmetro retorna algo de dentro do procedimento para o lado externo, colocando os valores manipulados 
        disponíveis na memória ou no conjunto de resultados;
		INOUT: faz os dois trabalhos ao mesmo tempo;
--> characteristics: as características que o procedimento pode apresentar;
--> corpo_da_rotina: onde são definidos os comandos SQL que farão alguma manipulação e/ou defenderão alguma lógica, 
podendo retornar – ou não – algum resultado (através dos parâmetros de saída ou entrada/saída). Também podemos utilizar 
todos recursos que vimos para funções: variáveis, condicionais e estruturas de repetição.

======================================================================================================================================
** CURSORES

Um cursor sempre é vinculado a uma consulta. A partir do resultado desta consulta, podemos utilizar o cursor para navegar nos 
registros retornados.

Para criá-los, deve-se utilizar a cláusula DECLARE CURSOR, que possui a sintaxe:

-- DECLARE nome_cursor CURSOR
     FOR comando_select
     
OBS: Após a declaração do cursor, para ele ser percorrido, é necessário abri-lo com a cláusula OPEN:

-- OPEN nome_cursor

OBS: Ao final do seu uso, é importante fechá-lo com a cláusula CLOSE:

-- CLOSE nome_cursor

Caso a operação de fechamento não seja feita, o cursor será fechado automaticamente no final do bloco da procedure.

Após o cursor ser aberto, é possível manipular suas linhas com o comando FETCH, que possui a sintaxe:

-- FETCH [[NEXT] FROM] nome_cursor;

OBS: Neste caso, seremos direcionados à primeira linha da consulta. Com ele, também é possível atribuir o resultado da consulta às 
variáveis através da cláusula INTO:

-- FETCH [[NEXT] FROM] nome_cursor INTO @nome_variavel_1, @nome_variavel_2, etc;

OBS: É importante definir em INTO as variáveis para todas as colunas retornadas pelo cursor. Se estiver faltando variável para 
alguma coluna, ou uma variável possuir em um tipo diferente do dado da coluna retornada, o MySQL irá acusar um erro.

*/
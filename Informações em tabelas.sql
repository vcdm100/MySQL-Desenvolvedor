/*
==========================================================================================
** INSERINDO DADOS 

-- INSERT [INTO] nome_tabela (nome_coluna1, ...) VALUES (valor 1, ...);
OBS: Veja que na sintaxe, o comando into pode ser omitido, mas a sugestão é sempre colocá-lo.

-- INSERT [INTO] nome_tabela (nome_coluna1, ...) VALUES (valor linha 1, ...), (valor linha 2, ...);
OBS: Também é possível declarar os campos apenas uma vez e inserir várias linhas de uma vez.

-- INSERT INTO nome_tabela
	SET nome_coluna1 = valor1,
		nome_coluna2 = valor2,
		...
		nome_colunaN = valorN;

==========================================================================================
** EXIBINDO OS DADOS DE UMA TABELA

-- SELECT coluna1,coluna2,coluna3,... colunaN FROM nome_tabela [WHERE condição];
OBS: O comando responsável por realizar consultas em banco dados relacionais que usam SQL 
é o SELECT. Com ele, podemos recuperar as tuplas existentes em uma tabela.
	--> O WHERE permite que se defina um filtro para a pesquisa, 
    com isso refinando mais o seu resultado.

==========================================================================================
** OPERADORES DE COMPARAÇÃO

-- SELECT * FROM carro WHERE modelo = 'Celta';
OBS: Por exemplo: para verificarmos se um modelo de carro é igual a Celta, 
podemos utilizar o operador de igualdade.

-- SELECT * FROM carro WHERE modelo <> 'Celta';
OBS: Ou de diferença, se quisermos obter o resultado inverso da consulta.

==========================================================================================
** ALTERANDO DADOS
OBS: Para alterar os dados em uma tabela, podemos utilizar o comando UPDATE.

-- UPDATE nome_tabela
	SET nome_coluna1= novo_valor1,
		nome_coluna2 =  novo_valor2,
		...
		nome_colunaN = novo_valorN
	[WHERE condição];

	--> Note que a cláusula WHERE também está disponível no comando UPDATE. Mesmo que ela seja opcional, 
sempre deverá ser utilizada. Caso contrário, a alteração irá impactar todas as linhas da tabela.

==========================================================================================
** EXCLUINDO DADOS
OBS: O comando que permite excluir tuplas de uma tabela é o DELETE.

-- DELETE FROM nome_tabela [WHERE condição];

	--> a cláusula WHERE não é obrigatória para o comando DELETE. Mas, igualmente ao primeiro, 
    se você omiti-la, o comando irá afetar todos os registros, ou seja: irá apagar 
    todos os registros da sua tabela. Evite utilizar este comando sem a cláusula WHERE.

==========================================================================================
** ALIASES

-- SELECT CodFor AS 'Código do Fornecedor', RazSoc AS 'Razão Social' FROM Fornecedores;
OBS: Os nomes das colunas apresentados no resultado de uma consulta podem ser diferentes dos 
rótulos de colunas originais, definidos na fase de criação da tabela na qual a consulta 
foi realizada. Esses nomes diferentes são chamados de “alias” ("apelido") e são gerados usando 
a palavra-chave AS no enunciado que faz a consulta.

==========================================================================================
** DISTINCT

-- SELECT DISTINCT rua, cidade FROM fornecedores;
OBS: Se precisarmos obter os valores de uma coluna ignorando-se o que for duplicado, 
podemos utilizar uma cláusula adicional à clausula SELECT: a cláusula DISTINCT.
O DISTINCT deve ser informado após o SELECT, não importando quantas colunas forem definidas na consulta.

==========================================================================================
** ORDER BY: Ordenação de registros com a cláusula
OBS: A cláusula ORDER BY é usada para ordenar os valores do resultado de uma consulta. 
Ela deve ser colocada no final do comando.

-- ORDER BY critério_de_classificação [ASC | DESC];
OBS: As palavras-chave ASC e DESC especificam o tipo de classificação e são, 
respectivamente, abreviações das palavras em inglês ascending e descending, 
ou seja: classificação crescente (do menor para o maior) ou decrescente (do maior para o menor). 
A ordenação ascendente é tida como padrão quando não se especificar nenhum tipo.
EXEMPLO:
	--	SELECT DISTINCT estado, cidade FROM Fornecedores
		ORDER BY estado;

--> Caso fosse necessário ordenar de modo decrescente, o DESC deveria ser especificado:
	SELECT DISTINCT estado, cidade FROM fornecedores
	ORDER BY estado DESC;

--> A cláusula ORDER BY pode se referir a mais de uma coluna da tabela de origem. 
Para isso, basta separá-las por vírgula:
	SELECT * FROM tabela ORDER BY coluna1, coluna2 ... colunaN;

==========================================================================================
** EXPLORANDO A CLÁUSULA WHERE

*** Operador AND:

-- SELECT * FROM carro WHERE cod = 1 AND placa = 'asd0989';
OBS: A consulta só retornará dados se o campo cod for igual a 1 e se o campo placa for igual 
a “asd0989”. As duas condições precisam ser verdadeiras ao mesmo tempo.

*** Operador OR:

-- SELECT * FROM aluno WHERE nome = 'wagner' OR cod = 5;
OBS: Serão retornados os registros cujo nome é “Wagner” OU o cod é igual a 5. 
Se qualquer uma das condições for considerada verdadeira, a tupla já é retornada.

*** Operador NOT:

-- SELECT * FROM carro WHERE NOT cod = 2;
OBS: A consulta acima, irá retornar os registros onde cod não for 2.

** Condições IS NULL e IS NOT NULL:

-- 	SELECT * FROM fornecedores
	WHERE CEP = NULL;
OBS: Como o NULL é uma expressão especial, ele não pode ser utilizado em uma comparação. 
Ou seja: para obtermos os registros com valores nulos, não é possível realizar a consulta.

-- 	SELECT * FROM fornecedores
	WHERE CEP IS NULL;
OBS: o SQL também introduziu o operador IS NULL. Com ele é possível verificar se 
o campo possui valores NULL.

-- 	SELECT * FROM fornecedores
	WHERE CEP IS NOT NULL;
OBS: O operador IS NOT NULL realiza o filtro contrário, trazendo apenas os registros que NÃO são NULL.

*** Operador BETWEEN:

-- SELECT * FROM tabela WHERE campo BETWEEN valor_inicial AND valor_final;
OBS: Podemos também selecionar elementos que estejam dentro de um intervalo de valores 
com o operador BETWEEN.

-- SELECT * FROM fornecedores WHERE codigo BETWEEN 3 and 7;
OBS: o operador BETWEEN é utilizado para comparar um intervalo de datas, mas pode ser utilizado 
com qualquer tipo de dado. Por exemplo: para selecionarmos os fornecedores com código entre 3 e 7, 
a consulta poderia ser...

*** Operador IN:
OBS: Ele retorna apenas elementos que sejam iguais a um dos valores apresentados na lista.

-- SELECT * FROM fornecedores WHERE codigo IN (1, 5, 9);
OBS: Acima, são selecionados os registros com código igual a 1, 5 ou 9.

-- SELECT * FROM tabela WHERE campo IN (SELECT campo FROM tabela2);

*** Operador LIKE:

_ (sublinhado)  |   É válido para qualquer caractere nessa posição.

%               |   Qualquer cadeia de zero ou mais caracteres.

[]              |   Possibilita especificar um padrão para um caractere único, exemplo 
					[a-f], [0-9], [A-Z].

[^]             |   Caractere único que não pertença ao padrão especificado.

*/
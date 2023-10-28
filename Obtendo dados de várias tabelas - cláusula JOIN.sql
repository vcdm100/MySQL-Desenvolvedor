/*
========================================================================================================
** O que fazer quando as informações vêm de mais de uma tabela?

-- 	SELECT tab1.coluna1, tab1.coluna2, ..., tab1.colunaN, tab2.coluna1, tab2.coluna2, ..., tab2.colunaN
	FROM tabela1 tab1, tabela2 tab2
	WHERE tab1.codtab1 = tab2.codtab1;
OBS: Mas, o recomendo é utilizando junções.

========================================================================================================
** Junções
OBS: MySQL possui um recurso chamado junção (join) para facilitar e melhorar a sintaxe de consultas que 
precisam relacionar várias tabelas. Com esse recurso, não precisamos declarar a segunda tabela na 
cláusula FROM nem escrever a condição no WHERE.

==> INNER JOIN
OBS: é o tipo de junção mais usado no dia a dia. Ele retorna apenas os dados que estão relacionados 
entre a tabela declarada no FROM e a declarada no JOIN.

-- 	SELECT * FROM tabela1 apelido1
	INNER JOIN tabela2 apelido2
	ON (apelido1.campo1 = apelido2.campo2)

==> LEFT e RIGHT JOIN
OBS: A junção INNER JOIN realiza a união retornando apenas os registros que possuem dados relacionados, 
mas existem casos onde é necessário recuperar dados de registros que não estão relacionados. 
Por exemplo: em um relacionamento, pode ser necessário retornar todos os dados de um lado da relação, 
algo que não pode ser obtido com o INNER JOIN.

+ LEFT JOIN retorna todos os registros da tabela à esquerda da relação, mesmo que eles não possuam referência na segunda tabela.
	-- 	SELECT * FROM tabela_da_esquerda apelido
		LEFT JOIN tabela_da_direita apelido
		ON (condição)

+ RIGHT JOIN é o inverso do LEFT JOIN: ele retorna todos os registros da tabela à direita da relação, mesmo que 
eles não possuam referência na tabela à esquerda.
	-- 	SELECT * FROM tabela_da_esquerda apelido
		RIGHT JOIN tabela_da_direita apelido
		ON (condição)

========================================================================================================
** GROUP BY
OBS: é razoavelmente comum precisarmos agrupar as informações para a realização de uma contagem.
Para a realização desse agrupamento.

Veja um exemplo de como usar a cláusula GROUP BY para obter a contagem de fornecedores, 
agrupando-os por estado:
-- SELECT estado, COUNT(*) as 'Fornecedores' FROM fornecedores GROUP BY estado;

========================================================================================================
** HAVING
OBS: HAVING pode ser usado em conjunto com GROUP BY para definir condições de agrupamento. 
Ele funciona quase como o WHERE, só que como um filtro para funções de sumarização.

No HAVING, podemos utilizar os operadores de comparação e operadores lógicos.
-- SELECT cod_cliente, COUNT(*) as 'Fornecedores' FROM fornecedores GROUP BY cod_cliente HAVING COUNT(cod_fornecedor) > 5;
OBS: Na consulta acima, estamos pesquisando por todos os clientes que tenham mais de cinco fornecedores.

*/
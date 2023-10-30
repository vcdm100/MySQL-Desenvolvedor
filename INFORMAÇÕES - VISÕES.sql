/* VISÕES = VIEW

Uma view é um objeto que pertence a um banco de dados baseado em declarações SELECTs, retornando determinada visualização de dados de uma ou mais tabelas. 
Esses objetos são chamados, por vezes, de "virtual tables", formados a partir de outras tabelas que, por sua vez, são chamadas de “based tables”. 
Em alguns, casos as views são atualizáveis e podem ser alvos de declaração INSERT, UPDATE e DELETE que na verdade modificam suas "based tables".

Os benefícios da utilização de Views, além dos já salientados, são:

Podem ser utilizadas, por exemplo, para retornar um valor baseado em um identificador de registro;
Podem ser utilizadas para promover restrições em dados para aumentar-lhes a segurança e definir políticas de acesso em nível de tabela e coluna;
Podem ser configuradas para mostrar colunas diferentes para diferentes usuários do banco de dados;
Podem ser utilizadas com um conjunto de tabelas que podem ser unidas a outros conjuntos de tabelas com a utilização de JOINs ou UNION.

Para definir views em um banco de dados, utilize a declaração CREATE VIEW, que tem a seguinte sintaxe:

-- CREATE [OR REPLACE] [ALGORITHM = algorithm_type] VIEW view_name [(column_list)]
	AS select_statement [WITH [CASCADED | LOCAL] CHECK OPTION]

Onde:

- view_name: é o nome que se dá ao objeto criado;
- column_list: recurso que permite sobrescrever os nomes das colunas que serão recuperadas pela declaração SELECT;
- select_statement: é a declaração SELECT que indica a forma na qual se deseja que os dados sejam retornados. Podem ser utilizadas as funções JOINs e UNION, caso necessário. Também podem ser utilizadas quaisquer tabelas ou views contidas no servidor de bancos de dados MySQL;
- OR REPLACE: pode ser utilizada para substituir uma view de mesmo nome existente no banco de dados ao qual pertence;
- ALGORITHM: essa cláusula define qual algoritmo interno utilizar para processar a view quando esta for invocada. Ele podem ser UNDEFINED (cláusula em branco), MERGE ou TEMPTABLE;
- WITH CHECK OPTION: todas as declarações que tentarem modificar dados de uma view definida com essa cláusula serão revisadas para checar se as modificações respeitarão a condição WHERE, definida no SELECT da view.

** VIEWS ATUALIZÁVEIS

Como comentando anteriormente, as views podem ser atualizadas com os comandos INSERT, UPDATE e DELETE, mas para que isso funcione, 
é importante que a view respeite alguns critérios.

Uma View criada com funções agregadas (que aprenderemos à frente no curso), não poderá receber atualizações, 
pois os dados logicamente estão agregados (ou agrupados) e não haverá correspondência direta para exclusão ou atualização.

Caso a view contenha um JOIN, ela também não poderá ser atualizada. Pois, o MySQL não terá 
dificuldade em distinguir qual tabela deve ser afetada pela atualização.

Por fim, o registro que será alterado não pode ser afetado pelas cláusulas GROUP BY, HAVING ou DISTINCT. 
E caso haja uma cláusula WHERE na view, pode ser definido a opção WITH CHECK OPTION.

Atribuir esta opção, na criação de uma View, significa que atualizações emitidas terão que se encaixar 
às condições definidas na cláusula WHERE da consulta SELECT. Por exemplo:

--	CREATE VIEW v_maiorestoque AS SELECT id_produto, quantidade
	FROM estoque WHERE quantidade >= 100 WITH CHECK OPTION;

OBS: Com o WITH CHECK OPTION definido na view acima, as atualizações dela só terão efeito se o valor informado para quantidade for maior ou igual a 100.
*/
/* TRIGGERS
ou gatilho

É um objeto de banco de dados associado a uma tabela, definido para ser disparado, respondendo a um evento em particular. Tais eventos 
são os comandos da DML (Data Manipulation Language): INSERT, REPLACE, DELETE ou UPDATE. Podem-se definir inúmeros triggers em uma base de dados, 
baseados diretamente a um dos comandos acima para dispará-lo, sendo que; para cada um, pode-se definir apenas uma trigger.

Sintaxe geral de definição de um TRIGGER:
-- 	CREATE [DEFINER = { user | CURRENT_USER }]
	TRIGGER trigger_name trigger_time trigger_event
	ON tbl_name FOR EACH ROW trigger_stmt

--> DEFINER: Quando a trigger for disparada, esta opção será checada para verificar com quais privilégios ela será disparada. Serão utilizados 
os privilégios do usuário informado em user (‘treina’@’localhost’) ou os privilégios do usuário atual (CURRENT_USER). Caso essa sentença seja omitida, n
a criação do TRIGGER, o valor padrão da opção será CURRENT_USER;
--> trigger_name: define o nome da trigger;
--> trigger_time: define se o TRIGGER será ativado antes (BEFORE) ou depois (AFTER) do comando que o disparou;
--> trigger_event: define se o evento será INSERT, REPLACE, DELETE ou UPDATE;
--> tbl_name: nome da tabela onde o TRIGGER ficará "pendurado", aguardando o trigger_event;
--> trigger_stmt: definições do que o TRIGGER deverá fazer quando for disparado.

A implementação deste recurso atualmente, no MySQL tem algumas limitações:

Não se pode chamar diretamente um TRIGGER com CALL, como se faz com uma stored procedure;
Não é permitido iniciar ou finalizar transações em meio à trigger;
Não se pode criar uma trigger para uma tabela temporária;
Triggers ainda não podem ser implementados com a intenção de devolver mensagens de erros.

=========================================================================================================================================================
** Recuperando informações dos eventos dentro das triggers

Dentro das triggers existem duas tabelas virtuais que possibilitam acessar as colunas da tabela-alvo do comando DML: é possível acessar os 
valores que serão enviados para a tabela antes (BEFORE) ou depois (AFTER) de um comand. Tais tabelas recebem os nomes de OLD e NEW.

A tabela OLD contém os dados que serão removidos da tabela. A NEW contém os dados que serão inseridos.

Cada uma dessas tabelas está disponível dentro do trigger de acordo o evento definido para ele:

Tipo de evento ------- Tabela virtual

INSERT --------------- NEW

UPDATE --------------- NEW e OLD: uma operação de UPDATE é tratada como um DELETE seguido de um INSERT pelo banco de dados

DELETE --------------- OLD

REPLACE -------------- NEW e OLD

*/
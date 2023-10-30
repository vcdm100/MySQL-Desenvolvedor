/* TRANSAÇÕES

Como transferências de valores em instituições bancárias, DOCs, compras em comércio eletrônico, e outros serviços; utilizam transações.

Basicamente, uma transação começa quando uma operação BEGIN é executada e termina quando uma operação COMMIT ou ROLLBACK correspondente é executada. 
Desta forma, pode-se concluir que uma transação é formada caracteristicamente por esses comandos.

Pode-se dar consistência ao conceito de transação com um exemplo clássico: uma transferência bancária. Para efetuar uma transferência de valor 
entre contas, têm-se alguns comandos SQL que são executados todos de uma vez, formando a tal unidade lógica que, por sua vez, 
envolve diversas operações de bancos de dados, tais como INSERT e UPDATE. Transações também podem conter DELETE e SELECT mas, 
no caso da transferência, utiliza-se somente o UPDATE.

A agência tenha dois correntistas – A e B – e A resolve fazer uma transferência de R$ 50,00 para B. Essa transação será feita via internet, 
através de um sistema de internet banking. Então, A acessará sua conta e completará a operação. Do lado servidor, o banco de dados recebe 
o valor e a conta de destino; tal valor é subtraído da conta de origem e adicionado na conta de destino. Nesse momento há uma conferência por parte 
do SGBD: se "tudo correu bem" então a transação é finalizada com sucesso.

Uma transação é definida dentro de um bloco declarado a partir do START TRANSACTION, conforme a sintaxe:
-- 	START TRANSACTION
	BEGIN [WORK]
	--instruções
	COMMIT [WORK]
	ROLLBACK [WORK]

OBS: --> A transação/unidade lógica começa no comando BEGIN. 
--> O COMMIT é uma operação de confirmação de que correu tudo bem e que todos os comandos que fazem parte da unidade lógica, ou da transação, 
foram executados com sucesso e o banco de dados encontra-se em um estado consistente. 
--> Já o ROLLBACK retornará todos os comandos anteriores àquele onde houve um erro, ou seja: tudo será desfeito se houve um problema com algum comando dentro de uma transação.

Exemplo da transação bancária: suponha que, caso o primeiro comando fosse executado, mas na hora de creditar o valor na conta B houvesse um erro, 
precisaríamos de alguma maneira desfazer a subtração do valor da conta de A. Nesse caso, o SGBD se encarregaria de fazer o ROLLBACK dos comandos 
anteriores ao erro, retornando o banco de dados para o momento inicial. Assim, o valor seria devolvido para A, mantendo intacto o montante de saldo 
com o mesmo valor imediatamente anterior ao início da transação.

--> COMMIT: indica o término de uma transação bem-sucedida. Ela informa ao gerenciador de transações que uma unidade lógica de trabalho foi concluída com sucesso, 
o banco de dados já está novamente em um estado consistente e todas as atualizações feitas por essa unidade de trabalho já podem se tornar permanentes.
--> ROLLBACK: assinala o término de uma transação malsucedida. Ela informa ao gerenciador de transações que algo saiu errado, que o banco de dados pode estar em 
um estado inconsistente, e que todas as atualizações feitas pela unidade lógica de trabalho até agora devem ser desfeitas.

==============================================================================================================================================================================
** Propriedades ACID
Para usar essa engenharia toda, precisamos conhecer as propriedades ACID. As propriedades ACID são atributos necessários à toda transação para que não existam 
problemas durante a execução. ACID é uma sigla que significa:

--> Atomicidade: toda transação deverá ser atômica – o verdadeiro "tudo ou nada": ou as operações são 100% concluídas ou devem ser totalmente desfeitas;
--> Consistência: as transações devem preservar a consistência do banco de dados, ou seja: transforma um estado consistente do banco de dados em outro estado consistente, 
sem necessariamente preservar o estado de consistência em todos os pontos intermediários;
--> Isolamento: as transações são isoladas umas das outras, de acordo com o nível de isolamento definido no momento em que a transação se inicia, que no MySQL são: 
REPEATABLE READ, READ COMMITED, READ UNCOMMITED e SERIALIZABLE;
--> Durabilidade: uma vez comprometida a transação, suas atualizações sobrevivem no banco de dados mesmo que haja uma queda subsequente do sistema.

==============================================================================================================================================================================
** AUTOCOMMIT
Normalmente, em SGBDs como o SQL Server e o MySQL, têm-se transações implícitas que são estreladas pelos comandos SELECT, INSERT, UPDATE e DELETE; ou seja: 
comandos DML e transações explícitas que podem ser iniciadas por um BEGIN e finalizadas por um END.

As transações implícitas são aquelas que têm um COMMIT interno e tornam, quaisquer modificações nos dados, permanentes no(s) arquivo(s) de dados em disco. 
Transações explícitas são aquelas que têm início e fim explicitados pelo desenvolvedor. O MySQL utiliza o modo chamado AUTOCOMMIT para controlar a efetividade da
modificação de dados das transações no banco de dados, ou seja: se AUTOCOMMIT = 1, as transações implícitas sempre terão um COMMIT interno, enquanto que, 
se AUTOCOMMIT = 0, o SGBD esperará por um COMMIT explícito para tornar permanente as últimas manipulações nos dados.

*/
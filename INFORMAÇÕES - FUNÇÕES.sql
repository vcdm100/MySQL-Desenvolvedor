/* FUNÇÕES

O padrão SQL disponibiliza algumas funções, cuja sintaxe é constituída pelo nome da função seguido pelos argumentos entre parênteses.

Tais funções retornam um determinado valor, realizando uma operação específica (definida pela palavra-chave que identifica a própria função) 
com base em um valor indicado como argumento da função.

Não necessariamente todas as funções precisam de argumentos...Por exemplo: a função CURRENT_TIMESTAMP, que retorna a data e hora atual, 
não precisa de nenhum argumento, pois pega tais informações no relógio do sistema.

O padrão SQL oferece muitas funções, classificadas em dois grandes grupos:

--> Funções de agregação: operam em conjuntos de valores (uma coluna inteira, por exemplo) e retornam um único valor.
--> Funções escalares: trabalham em um só valor (o argumento) e retornam um valor baseado nele.

Para criarmos uma user function, utilizarmos o comando abaixo:

-- 	CREATE FUNCTION nome ([parâmetros[...]])
		RETURNS tipo
		Instruções da função

No MySQL, o delimitador padrão de comandos é o ponto-e-vírgula (;). Sempre que ele é encontrado, o MySQL termina a execução de um comando. 
O problema é que a criação de objetos personalizados, como as user functions (e outros que veremos à frente), podem conter ponto-e-vírgula 
no meio do comando de criação. Quando isso ocorre, o MySQL considerará o término do comando, o que não é o comportamento esperado quando estamos 
criando as user functions...

Para resolver isso, podemos utilizar a cláusula DELIMITER antes da declaração da function e assim alterar o delimitador de instruções da linguagem. 
Nesta situação, a sintaxe da user function mudaria para:

-- 	DELIMITER $$
	CREATE FUNCTION nome ([parâmetros[...]])
		RETURNS tipo
		Instruções da função
	$$
	DELIMITER ;

OBS: Acima, o delimitador é alterado para $$ (pode ser definido qualquer delimitador):

-- DELIMITER $$

OBS: A função é criada, e finalizada com o delimitador definido. E por fim, o antigo delimitador, o ponto e vírgula, é redefinido:

-- DELIMITER ;

OBS: Voltando à sintaxe da função, seus parâmetros podem ser separados por vírgula e devem ter a sintaxe:

-- parametro tipo, parametro2 tipo, ... parametroN tipo

o retorno pode ser:
	--> VARCHAR, para caracteres;
	--> INTEGER, para tipos inteiros;
	--> REAL, ponto flutuante com até 24 casas;
	--> DECIMAL, ponto flutuante com até 65 casas.

======================================================================================================================================
** VARIÁVEIS

Durante os passos lógicos de uma função pode ser necessário o uso de um recurso que armazene informações na memória temporária do computador. 
Esse recurso é chamado variável e pode ser declarado em uma função através da cláusula DECLARE:

-- DECLARE nome_variavel tipo_dado

OBS: O tipo de dado da variável pode ser qualquer tipo que seja válido para uma coluna.
Para atribuir um valor para a variável, pode se utilizar a cláusula SET:

-- SET nome_variavel = valor

*/
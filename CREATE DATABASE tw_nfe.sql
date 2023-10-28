CREATE DATABASE tw_nfe;
USE tw_nfe;

SELECT DATABASE();

/* (COMENTÁRIO)
NOME | ENDERECO | DATA DE NASCIMENTO [...]
------------------------------------------
TW   | Rua XPTO | 01/01/2008
Ze   | Rua XPTZ | 01/01/2008

10.001 ----- DECIMAL (5,3)
	- Precisão (p) = 5; (Quantidade de cada um Dígito suportado para total)
	- Escala (e) = 3;  (Quantidade para representar a parte DECIMAL)
    
==========================================================================================
** PONTOS FLUTUANTES

- DECIMAL(p,e): DEC - precisão = 65, escala = 30. 
	+ VALOR PADRÃO: Precisão = 10, escala = 0.
	+ A cada 9 dígitos da parte interna do seu decimal = 4 bytes,
são necessários e utilizados para fazer o armazenamento.
	Exemplo: 
		- 0 = 0 bytes;
		- 1 a 2 = 1 byte;
        - 3 a 4 = 2 bytes;
        - 5 a 6 = 3 bytes;

- FLOAT(p,e):
		-3.40E+38 a -1.17E-38  |   0   |  1.17E-38 a 3.40E+38
OBS: PADRÃO: Máximo suportado pelo SO/Hardware.
	+ 0 <= p <= 24 ---- 4 bytes;
    + 25 <= p <= 53 --- 8 bytes;

- DOUBLE (p,e): (E) = ELEVADO
		-1.79E + 308 a -2.23E-308  |  0  |  2.23E-308 a 1.79E + 308
OBS: PADRÃO: Máximo suportado pelo SO/Hardware, mas e = 15 --> 8 bytes.
A PRECISÃO É O MÁXIMO SUPORTADO PELO SISTEMA OPERACIONAL ASSIM COMO FLOAT MAS A PADRÃO 
A ESCALA ELA É DEFINIDA DE MANEIRA DIFERENTE ELA É DEFINIDA COM 15 DÍGITOS POR DEFINIÇÃO 
ENTÃO SE VOCÊ COLOCA DOUBLE OU SEM DEFINIR PRECISÃO ESCALA A PRECISÃO VAI SER ESCALADA 
PARA O MÁXIMO SUPORTADO PELO SISTEMA OPERACIONAL MAS A ESCALA VAI SUPORTAR AÍ 15 DÍGITO 
CERTO E O ARMAZENAMENTO DELE DO TIPOS POR DEFINIÇÃO ENTÃO VOCÊ VAI PRECISAR DE OITO BITES
PARA ARMAZENAR CADA UM DOS VALORES.

- FLOAT(b) => b = Quantidade de bits.
 
==========================================================================================
** NÚMEROS INTEIROS

- BIT(t): de 1 até 64 números inteiros.
Padrao: t = 1 (t= tamanho)
	t + 7 = 8 (é a fórmula de quantos bytes serão necessários para armazenamento dessa informação.)
    Então aquele dado vai ocupar um byte

- TYNINT(t) - SIGNED: 
1 byte				- 128 a 127 / UNSIGNED: 0 a 255 
OBS: Se ele suportar nùmeros negativos vai de menos 128 a 127, se ele não suportar dígitos
negativos, vai acabar tendo a faixa de zero a 255. 

- SMALLINT(t) - SIGNED:
2 bytes				-32768 a -32767 / UNSIGNED: 0 a 65535

- MEDIUMINT(t) - SIGNED:
3 bytes					-8388608 a 8388607 / UNSIGNED: 0 a 16777215

- INT(t), INTEGER - SIGNED:
4 bytes 				-2147483648 a 2147483647 / UNSIGNED: 0 a 4294967295

- BIGINT(t): 
8 bytes

==========================================================================================
** DATA E HORA

- DATE: 1000-01-01 a 9999-12-31
3 bytes

- DATETIME(f): 1000-01-01 00:00:00.000000 a 9999-12-31.999999
5 bytes + fracão

- TIMESTAMP(f): 1970-01-01 00:00:00 a 2038-01-19 03:14:07.999999
4 bytes + fração

- YEAR: 1901 a 2155
1 byte

-- Fração: 	(0) = 0 bytes;
			(1,2) = 1 byte;
            (3,4) = 2 bytes;
            (5,6) = 3 bytes;

==========================================================================================
** CADEIAS DE CARACTERES

- CHAR(t): 0 a 255 (são quantidade de caracteres)
Fórmula: t * M
	t = é tamanho o comprimento.
	M = é quantidade de bytes que são requeridos para guardar a maior cadeia.
> 768 bytes: passar a ser um VARCHAR

CHAR(4) = ABC_
OBS: 4 caracteres

- VARCHAR(t): 0 a 65535 caracteres
OBS: Se precisa guardar um texto que tenha até 65.575 caracteres é a quantidade máxima.
t + 1 byte, t <= 255 caracteres. Maior do que isso: t + 2 bytes

VARCHAR(4) = ABC

==========================================================================================
** OUTROS TIPOS DE DADOS

OBS: ZERO = FALSO e UM = VERDADEIRO
- BOOL = TYNINT(1)
- JSON 
OBS: é a versão mais nova do MySQL que serve para criar colunas que guardem informações
no formato JSON.

*/
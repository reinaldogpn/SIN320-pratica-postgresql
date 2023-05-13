-- 1. Abrir a interface PgAdmin ou Psql do SGBD PostgreSQL. Crie um banco de
-- dados qualquer e execute o script chamado scriptPratica06.sql para criar a
-- estrutura e povoar o banco de dados.

CREATE DATABASE aula07;

-- 2. Crie uma function que liste todos os clientes cadastrados. Depois execute.

CREATE OR REPLACE FUNCTION listar_clientes() 
	RETURNS SETOF cliente AS $$ 
	SELECT * FROM cliente 
	$$ LANGUAGE SQL;

SELECT * FROM listar_clientes();

-- 3. Crie uma function que receba um determinado valor como parâmetro e
-- retorne os produtos que são mais baratos que o valor passado. Em seguida
-- execute a function criada passando o valor R$ 3,00 como parâmetro.

CREATE OR REPLACE FUNCTION compara_valor(REAL)
    RETURNS SETOF produto AS $$
    SELECT * FROM produto WHERE precounitario < $1
    $$ LANGUAGE SQL;

SELECT * FROM compara_valor(3.00);

-- 4. Crie uma function que receba o código do produto e informe seu volume total
-- de vendas em R$. Em seguida execute a function criada passando como
-- parâmetro o código de um produto qualquer.

CREATE OR REPLACE FUNCTION vol_vendas(INTEGER)
    RETURNS REAL AS $$
    SELECT SUM(quantidade * precounitario) 
    FROM itemdopedido 
    WHERE codigoproduto = $1
    $$ LANGUAGE SQL;

SELECT * FROM vol_vendas(31);
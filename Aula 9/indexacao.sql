-- 1. Abrir o SGBD PostgreSQL (usar a interface PgAdmin) e criar um banco de 
-- dados chamado praticaindexacao.

DROP DATABASE IF EXISTS praticaindexacao;
CREATE DATABASE praticaindexacao;

-- 2. Crie uma tabela chamada exemplo1 com as seguintes características. OBS: 
-- Não é para criar chave primária.
-- C1 Integer Not Null
-- C2 Integer
-- C3 Integer
-- C4 Integer

CREATE TABLE exemplo1 (
    C1 INTEGER NOT NULL,
    C2 INTEGER,
    C3 INTEGER,
    C4 INTEGER
);

-- 3. Crie uma função (aula de stored procedure) que insira registros na tabela 
-- exemplo1 até o valor passado como parâmetro. Exemplo: Se você passar 
-- como parâmetro o número 5 a tabela exemplo1 ficará como a tabela abaixo:
-- C1 C2 C3 C4
-- 2 2 2 2
-- 1 1 1 1
-- 3 3 3 3
-- 4 4 4 4
-- 5 5 5 5

CREATE OR REPLACE FUNCTION insere_exemplo1 (valor INTEGER)
RETURNS VOID AS $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= valor LOOP
        INSERT INTO exemplo1 VALUES (i, i, i, i);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- 4. Execute a função criada anteriormente para povoar a tabela exemplo1 com 
-- 600.000 registros. Dê um SELECT na tabela para verificar se os dados foram 
-- criados corretamente.

SELECT insere_exemplo1(600000);
SELECT * FROM exemplo1;

-- 5. Execute a seguinte consulta e marque o tempo de execução. 
-- SELECT * FROM exemplo1 WHERE c3 = 400000 AND c1 = 400000;

SELECT * FROM exemplo1 WHERE c3 = 400000 AND c1 = 400000;

-- 6. Crie um índice no campo c3 (idxc3) e um índice no campo c1 (idxc1) na 
-- tabela exemplo1. Depois execute o comando ANALYSE para atualizar as 
-- estatísticas do banco de dados.

CREATE INDEX idxc3 ON exemplo1 (c3);
CREATE INDEX idxc1 ON exemplo1 (c1);
ANALYSE exemplo1;

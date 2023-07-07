-- 1. Abra o Pgadmin e crie um banco de dados chamado revisaoP2. 

CREATE DATABASE revisaoP2;

-- 2. Execute o script disponibilizado no PVANet (scriptRevisaoP2.sql) para criar
-- as tabelas e povoar o banco de dados criado anteriormente.

-- 3. Verifique se as tabelas foram criadas corretamente.

-- 4. Crie uma function que receba uma string e retorne todos os nomes de
-- autores que comecem com a string passada como parâmetro.

CREATE OR REPLACE FUNCTION autores_por_nome (nome TEXT)
RETURNS TABLE (autores AUTOR.NOME_AUTOR%TYPE) AS $$
    BEGIN
        RETURN QUERY SELECT NOME_AUTOR FROM AUTOR WHERE NOME_AUTOR LIKE nome || '%';
    END;
$$ LANGUAGE plpgsql;

-- 5. Crie uma function que atualize o preço de venda da tabela CD de uma
-- determinada gravadora. A function deverá receber como parâmetro o nome da
-- gravadora e o novo preço de venda dos CDs.

CREATE OR REPLACE FUNCTION atualizar_preco_cd (gravadora_nome TEXT, novo_preco DECIMAL)
RETURNS VOID AS $$
    BEGIN
        UPDATE CD 
        SET PRECO_VENDA = novo_preco 
        WHERE CODIGO_GRAVADORA = (SELECT CODIGO_GRAVADORA
                                  FROM GRAVADORA
                                  WHERE NOME_GRAVADORA = gravadora_nome);
    END;
$$ LANGUAGE plpgsql;

-- 6. Crie uma function que receba o nome da gravadora e retorne o nome de
-- todos os CDs pertencentes a ela.

CREATE OR REPLACE FUNCTION cds_por_gravadora (gravadora_nome TEXT)
RETURNS SETOF CD AS $$
    BEGIN
        RETURN QUERY SELECT * FROM CD WHERE CODIGO_GRAVADORA = (SELECT CODIGO_GRAVADORA
                                                                FROM GRAVADORA
                                                                WHERE NOME_GRAVADORA = gravadora_nome);
    END;
$$ LANGUAGE plpgsql;

-- 7. Crie uma function que receba o codigo do CD e retorne as músicas que
-- fazem parte dele.

CREATE OR REPLACE FUNCTION musicas_por_cd (codigo INTEGER)
RETURNS SETOF MUSICA AS $$
    BEGIN
        RETURN QUERY SELECT MUSICA.CODIGO_MUSICA, MUSICA.NOME_MUSICA, MUSICA.DURACAO 
                     FROM MUSICA JOIN FAIXA ON MUSICA.CODIGO_MUSICA = FAIXA.CODIGO_MUSICA
                     WHERE FAIXA.CODIGO_CD = codigo;
    END;
$$ LANGUAGE plpgsql;

-- 8. Crie um índice para cada uma das chaves primárias (PK) e estrangeiras (FK)
-- do banco de dados criado

CREATE INDEX idx_gravadora_pk
ON GRAVADORA (CODIGO_GRAVADORA);

CREATE INDEX idx_cd_pk
ON CD (CODIGO_CD);

CREATE INDEX idx_cd_fk
ON CD (CODIGO_GRAVADORA);

CREATE INDEX idx_musica_pk
ON MUSICA (CODIGO_MUSICA);

CREATE INDEX idx_faixa_pk1
ON FAIXA (NUMERO_FAIXA);

CREATE INDEX idx_faixa_pk2
ON FAIXA (CODIGO_CD);

CREATE INDEX idx_faixa_fk1
ON FAIXA (CODIGO_CD);

CREATE INDEX idx_faixa_fk2
ON FAIXA (CODIGO_MUSICA);

CREATE INDEX idx_autor_pk
ON AUTOR (CODIGO_AUTOR);

CREATE INDEX idx_musica_autor_pk1
ON MUSICA_AUTOR (CODIGO_MUSICA);

CREATE INDEX idx_musica_autor_pk2
ON MUSICA_AUTOR (CODIGO_AUTOR);

CREATE INDEX idx_musica_autor_fk1
ON MUSICA_AUTOR (CODIGO_MUSICA);

CREATE INDEX idx_musica_autor_fk2
ON MUSICA_AUTOR (CODIGO_AUTOR);

-- 9. Apresente o plano de execução da consulta que retorna o nome da música e
-- do seu respectivo autor.

EXPLAIN SELECT NOME_MUSICA, NOME_AUTOR
FROM MUSICA JOIN MUSICA_AUTOR ON MUSICA.CODIGO_MUSICA = MUSICA_AUTOR.CODIGO_MUSICA
            JOIN AUTOR ON MUSICA_AUTOR.CODIGO_AUTOR = AUTOR.CODIGO_AUTOR
WHERE NOME_MUSICA = 'Será'; 

-- 10. Crie um usuário (role login) chamado mendes que possa criar banco de
-- dados. A senha deste usuário será ‘asdfg’.

CREATE ROLE mendes WITH CREATEDB LOGIN PASSWORD 'asdfg';

-- 11. Altere a senha do usuário mendes para ‘123456’.

ALTER ROLE mendes PASSWORD '123456';

-- 12. Conceda os privilégios de SELECT e INSERT na tabela GRAVADORA para
-- o usuário mendes.

GRANT SELECT, INSERT ON GRAVADORA TO mendes;

-- 13. Retire as permissões dadas anteriormente para o usuário mendes.

REVOKE SELECT, INSERT ON GRAVADORA FROM mendes;

-- 14. Faça um backup do banco de dados revisaoP2 com as seguintes
-- características:
-- Backup apenas dos dados
-- Nome do arquivo de saída: revisaoP2_05072023.backup
-- Formato do arquivo de saída: Binário comprimido
-- Incluir os blobs

-- (COLA)
-- -f Envia a saída para o arquivo específico após o –f (caminho absoluto)
-- -F[t|c|p] Especifica o formato de saída:
--      Binário: c (comprimido) e t (tar)
--      Texto: p (padrão)
-- -v Imprime as mensagens
-- -a Somente os dados
-- -s Somente a estrutura
-- -b Inclui os BLOBs
-- -t Somente a tabela específica

pg_dump -U postgres -Fc -ab revisaop2 > C:\postgres_bkp\revisaoP2_05072023.backup

-- 15. Faça um backup apenas da tabela GRAVADORA do banco de dados
-- revisaoP2.

pg_dump -U postgres -Fc -ab -t GRAVADORA revisaop2 > C:\postgres_bkp\tbl_GRAVADORA_05072023.backup

-- 16. Restaure os dois backups criados nos exercícios anteriores. OBS: Não
-- esqueça de criar os bancos de dados vazios.

-- Fazendo backup da estrutura do bd:

pg_dump -U postgres -Fc -s revisaop2 > C:\postgres_bkp\revisaoP2_estrutura_05072023.backup

-- Criando os bds vazios

CREATE DATABASE bd_revisaop2_01;
CREATE DATABASE bd_revisaop2_02;

-- Restaurando a estrutura do primeiro bd

pg_restore -U postgres -Fc -d bd_revisaop2_01 C:\postgres_bkp\revisaoP2_estrutura_05072023.backup

-- Fazendo as restaurações que foram pedidas:

-- 1: Restaura somente os dados no primeiro bd criado
pg_restore -U postgres -Fc -d bd_revisaop2_01 C:\postgres_bkp\revisaoP2_05072023.backup

-- 2: Restaura a estrutura e os dados somente da tabela GRAVADORA no segundo bd criado 
pg_restore -U postgres -Fc -d bd_revisaop2_02 C:\postgres_bkp\tbl_GRAVADORA_05072023.backup

-- 3. Crie uma view chamada view_musica_autor que apresente o nome de todas
-- as músicas (em letras maiúsculas) e o seu respectivo autor. Em seguida
-- visualize os registros da view criada.

CREATE VIEW view_musica_autor (NOME, AUTOR) AS 
SELECT UPPER(nome_musica), nome_autor
FROM musica JOIN musica_autor ON musica.codigo_musica = musica_autor.codigo_musica 
            JOIN autor ON musica_autor.codigo_autor = autor.codigo_autor;
			
SELECT * FROM view_musica_autor;

-- 4. Crie uma View que apresente o número de CDs por gravadora. A view
-- deverá retornar o nome da gravadora e o número de cds que ela possui.

CREATE VIEW cds_gravadora (GRAVADORA, QTD_CD) AS
SELECT nome_gravadora, COUNT(*)
FROM gravadora, cd
WHERE gravadora.codigo_gravadora = cd.codigo_gravadora
GROUP BY nome_gravadora;

SELECT * FROM cds_gravadora;

-- 5. Crie uma tabela chamada “CDLOG” com as seguintes características:

CREATE TABLE cdlog (
    codigo_log SERIAL PRIMARY KEY,
    codigo_cd INT,
    comando VARCHAR(15),
    datahora TIMESTAMP,
    usuario VARCHAR(20)
);

-- 6. Crie uma regra (rule) na tabela CD chamada “rl_update_CD” que insira
-- registros na tabela CDLOG automaticamente toda vez que dados do CD forem
-- modificados. PS: O atributo COMANDO será a palavra “UPDATE”. Em seguida
-- atualize um registro qualquer da tabela CD e verifique se a tabela CDLOG foi
-- modificada.

CREATE OR REPLACE RULE rl_update_cd AS ON UPDATE
    TO cd
    DO INSERT INTO cdlog (codigo_cd, comando, datahora, usuario)
    VALUES (old.codigo_cd, 'UPDATE', current_timestamp, current_user);

UPDATE cd SET preco_venda = 18
	WHERE codigo_cd = 1;
	
SELECT * FROM cdlog;

-- 7. Crie uma regra (rule) na tabela CD chamada “rl_delete_cd” que preencha a
-- tabela CDLOG depois que algum dado da tabela CD for deletado

CREATE OR REPLACE RULE rl_delete_cd AS ON DELETE
    TO cd
    DO INSERT INTO cdlog (codigo_cd, comando, datahora, usuario)
    VALUES (old.codigo_cd, 'DELETE', current_timestamp, current_user);

-- 8. Crie uma regra (rule) na tabela gravadora que não faça nada se o usuário
-- deletar os dados da tabela.

CREATE OR REPLACE RULE rl_delete_gravadora AS ON DELETE
    TO gravadora
    DO INSTEAD NOTHING;

-- 9. Crie uma View que retorne o código, nome e telefone das gravadoras.
-- Depois crie uma regra (rule) para fazer com que a View criada anteriormente
-- seja editável para o comando INSERT.

CREATE VIEW info_gravadoras (codigo, nome, telefone) AS
    SELECT codigo_gravadora, nome_gravadora, telefone
    FROM gravadora;

CREATE OR REPLACE RULE rl_view_info_gravadoras AS ON INSERT 
    TO info_gravadoras 
    DO INSTEAD INSERT INTO gravadora (codigo_gravadora, nome_gravadora, telefone) 
    VALUES (new.codigo, new.nome, new.telefone);

-- 10. Crie uma tabela chamada “CAPA_CD” com as seguintes características:

CREATE TABLE capa_cd (
    codigo SERIAL PRIMARY KEY,
    codigo_cd INT,
    oid_dados OID,
    FOREIGN KEY (codigo_cd) REFERENCES cd(codigo_cd)
);

-- 11. Escolha um dos cds cadastrados e insira a imagem de uma capa para ele
-- na tabela criada anteriormente (capa_cd).

INSERT INTO capa_cd (codigo_cd, oid_dados)
    VALUES (1, lo_import('C:\Users\Public\Pictures\legiaourbana_maisdomesmo.jpg'));

-- 12. Recupere a capa de cd que você inseriu na imagem anterior. Use a função
-- lo_export para exportar a imagem.

SELECT lo_export(capa_cd.oid_dados, 'C:\tmp\capa.jpg') FROM capa_cd
    WHERE codigo_cd = 1;

-- 13. Crie uma sequência com as seguintes informações:
-- nome: cd_seq
-- valor mínimo: 10
-- valor máximo: 1000
-- incremento: 2
-- usar ciclo.

CREATE SEQUENCE "cd_seq"
    INCREMENT 2 MINVALUE 10 MAXVALUE 1000 CYCLE;

-- 14. Inicialize a sequência criada anteriormente.

SELECT NEXTVAL ('cd_seq');
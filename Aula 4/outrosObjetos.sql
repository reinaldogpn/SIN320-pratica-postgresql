-- 1. Usando funções:

    -- A. Apresente seu primeiro nome 20 vezes.
    SELECT repeat('Reinaldo - ', 20);

    -- B. Apresente o usuário logado no servidor de banco de dados;
    SELECT current_user;

    -- C. Apresente a raiz quadrada de 49;
    SELECT sqrt(49);

    -- D. Apresente a data e hora atual;
    SELECT current_timestamp;

-- 2. Crie uma sequência com as seguintes informações:
-- nome: seq_10
-- valor mínimo: 1
-- valor máximo: 100
-- incremento: 10
-- não usar ciclo.

CREATE SEQUENCE "seq_10"
INCREMENT 10 MINVALUE 1 MAXVALUE 100;

-- 3. Depois da sequência criada faça:

    -- A. Inicialize a sequência criada.
    SELECT NEXTVAL ('seq_10');

    -- B. Apresente o próximo valor da sequência ('minha_seq').
    SELECT NEXTVAL ('seq_10');

    -- C. Mude o valor da sequência ('minha_seq') para 50
    SELECT SETVAL('seq_10', 50);

    -- D. Apresente os próximos valores da sequência até dar um erro
    SELECT NEXTVAL ('seq_10');

    -- E. Altere a sequência para que ela passe a ser cíclica e reinicie a
    -- sequência com valor 1.
    ALTER SEQUENCE "seq_10" RESTART WITH 1 CYCLE;

    -- F. Faça testes e verifique se a sequência irá retornar à 1 quando chegar
    -- ao valor 100.
    SELECT NEXTVAL ('seq_10');

-- 4. Crie uma tabela chamada dados_multimidia de acordo com as informações
-- mostradas a seguir:

CREATE TABLE dados_multimidia (
codigo SERIAL PRIMARY KEY,
nome VARCHAR(30),
tipo VARCHAR (20),
oid_dados OID);

-- 5. Pegue uma imagem e importe para a tabela dados_multimidia criada
-- anteriormente.

INSERT INTO dados_multimidia (nome, tipo, oid_dados) VALUES
('Castle', 'imagem', lo_import('C:\Users\Public\Pictures\hogwarts-legacy.jpg'));

-- 6. Visualize os dados na tabela dados_multimidia e na tabela pg_largeobject
-- para verificar se a imagem foi importada corretamente para o banco de dados.

SELECT * FROM dados_multimidia;
SELECT * FROM pg_largeobject;

-- 7. Recupere a imagem armazenada no banco de dados com o nome
-- nova_imagem.jpg. Verifique se a imagem foi exportada corretamente.

SELECT lo_export(oid_dados, 'D:/nova_imagem.jpg')
FROM dados_multimidia
WHERE nome = 'Castle';

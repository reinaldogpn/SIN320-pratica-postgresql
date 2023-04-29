-- 1. Abrir o SGBD PostgreSQL (usar a interface PgAdmin) e criar um banco de
-- dados chamado escola. OBS: Se você já tiver o banco de dados criado em seu
-- servidor, não precisa criar novamente, pois este script já foi utilizado em aulas
-- anteriores.

-- Database: escola

DROP DATABASE IF EXISTS escola;
CREATE DATABASE escola;

-- 2. Executar o script chamado scriptEscola.sql (disponível no PVANet Moodle)
-- para criar a estrutura e povoar o banco de dados.

-- 3.Crie uma tabela chamada “log_funcionario” seguindo as características da
-- tabela abaixo. OBS: não é para criar chave primária.

CREATE TABLE log_funcionario (
    cpf_func VARCHAR(15)
    novo_salario REAL
    usuario VARCHAR(20)
    data_hora TIMESTAMP
);

-- 4. Crie uma regra (rule) na tabela funcionário chamada “rl_log_funcionario” que
-- insira registros na tabela log_funcionario automaticamente toda vez que o
-- salário do funcionário for modificado.

CREATE OR REPLACE RULE rl_log_funcionario AS
ON UPDATE TO funcionario
WHERE new.salario <> old.salario DO
INSERT INTO log_funcionario VALUES (old.cpf, new.salario, current_user, current_date);

-- 5. Atualize a tabela funcionário com um novo salário e verifique se a tabela
-- log_funcionario foi modificada.

UPDATE funcionario SET salario = 1200 WHERE salario = 1000;

-- 6. Crie uma regra (rule) na tabela professor_disciplina chamada
-- “rl_no_delete_profdisc” que não faça nada se o usuário deletar dados na
-- tabela. Depois exclua registros da tabela professor_disciplina para verificar o
-- que acontece.

CREATE OR REPLACE RULE rl_no_delete_profdisc AS
ON DELETE TO professor_disciplina DO INSTEAD NOTHING;

DELETE FROM professor_disciplina WHERE cpf_func = '0987654321';

-- 7. Crie uma tabela chamada “professor_disciplina_auditoria” com as
-- características da tabela abaixo. Não precisa criar chave primária.

CREATE TABLE professor_disciplina_auditoria (
    codigo_disc INT,
    cpf_func VARCHAR(15),
    dt_exclusao DATE,
    usuario VARCHAR(20)
);

-- 8. Crie uma rule na tabela professor_disciplina chamada “rl_delete_prof_disc”
-- que preencha a tabela professor_disciplina_auditoria quando os dados da
-- tabela professor_disciplina forem deletados.

CREATE OR REPLACE RULE rl_delete_prof_disc AS
ON DELETE TO professor_disciplina DO
INSERT INTO professor_disciplina_auditoria VALUES (old.codigo_disc, old.cpf_func, current_date, current_user);

-- 9. Delete todos os dados da tabela professor_disciplina e verifique se a tabela
-- professor_disciplina_auditoria foi povoada.

DELETE FROM professor_disciplina * ;
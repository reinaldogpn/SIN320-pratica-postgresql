-- 1. Abrir o SGBD PostgreSQL (usar a interface PgAdmin) e criar um banco de
-- dados chamado escola.

CREATE DATABASE escola;

-- 2. Executar o script chamado scriptEscola.sql (disponível no PVANetMoodle)
-- para criar a estrutura e povoar o banco de dados.
-- OBS: As respostas devem ser postadas no PVANetMoodle até o final da aula.
-- matricula.sql

-- 3. Crie uma view de nome “estudantes_portugues” que apresente o nome e a
-- matrícula de todos os estudantes que cursam a disciplina de português.

CREATE VIEW estudantes_portugues (nome, matricula) AS
SELECT nome, matricula
FROM estudante JOIN cursa ON matricula = matricula_est JOIN disciplina ON cod_disc = codigo
WHERE descricao = 'Portugues';

-- 4. Visualize os registros da view criada anteriormente.

SELECT * FROM estudantes_portugues;

-- 5. Modifique a View criada no número 3 para que também apresente o RG dos alunos

CREATE OR REPLACE VIEW estudantes_portugues (nome, matricula, RG) AS
SELECT nome, matricula, rg
FROM estudante JOIN cursa ON matricula = matricula_est JOIN disciplina ON cod_disc = codigo
WHERE descricao = 'Portugues';

-- 6. Crie uma view de nome “numero_estudante_turma” que apresente o número
-- de estudantes existentes por turma. A view deverá apresentar a série da turma
-- e o número de estudantes respectivamente.

CREATE VIEW numero_estudante_turma (serie, estudantes) AS
SELECT serie, COUNT(*)
FROM turma, estudante
GROUP BY serie;

-- 7. Visualize os registros da view criada anteriormente.

SELECT * FROM numero_estudante_turma;

-- 8. Exclua a View criada no número 6.

DROP VIEW numero_estudante_turma;

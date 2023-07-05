-- 1. Crie um usuário (role login) chamado miguel que possa criar banco de
-- dados e criar outras roles. A senha deste usuário será ‘123456’

psql -U postgres -h localhost -d postgres

CREATE ROLE miguel WITH CREATEDB CREATEROLE LOGIN PASSWORD '123456';

-- 2. Crie um usuário (role login) com as seguintes características:
-- nome: seu primeiro nome
-- senha: seu número de matrícula
-- opções: superusuário

CREATE ROLE reinaldo WITH SUPERUSER LOGIN PASSWORD '7627';

-- 3. Altere a senha do usuário miguel para ‘987654321’

ALTER ROLE miguel PASSWORD '987654321';

-- 4. Conecte no banco de dados postgres com o usuário do seu nome e crie um
-- banco de dados chamado pratica10.

\q
psql -U reinaldo -h localhost -d postgres

CREATE DATABASE pratica10;

-- 5. Conecte no banco de dados pratica10 com o usuário do seu nome e execute
-- o scriptAula10.sql (disponível no PVANet moodle) para povoar o banco criado.
-- Verifique se as tabelas e dados foram criados corretamente.

\c pratica10;
\i C:/Users/reina/Downloads/ScriptAulaPratica10.sql

-- 6. Conecte no banco de dados postgres com o usuário postgres e crie um
-- grupo (role conteiner) chamado ufv.

psql -U postgres -h localhost -d postgres

CREATE ROLE ufv;

-- 7. Inclua os usuários miguel e o usuário com seu nome no grupo ufv.

GRANT ufv TO miguel, reinaldo;

-- 8. Usando o dicionário de dados crie uma consulta que visualize os membros
-- dos grupos criados.

SELECT cr.rolname, lr.oid, lr.rolname FROM pg_auth_members, pg_authid cr, pg_authid lr WHERE roleid = cr.oid AND member = lr.oid;

-- 9. Usando o comando GRANT conceda o privilégio de SELECT para a tabela
-- turma (banco de dados pratica10) para o usuário miguel. Você precisa estar
-- conectado com o banco de dados para dar permissão. Teste se a permissão foi
-- dada corretamente.

GRANT select ON turma TO miguel;

-- 10. Conceda o privilégio de DELETE e SELECT para a tabela disciplina (banco
-- de dados pratica10) para o usuário miguel. Teste se as permissões foram
-- dadas corretamente.

GRANT delete, select ON disciplina TO miguel;

-- 11. Retire as permissões dadas anteriormente (número 9 e 10).

REVOKE select ON turma FROM miguel;
REVOKE delete, select ON disciplina FROM miguel;
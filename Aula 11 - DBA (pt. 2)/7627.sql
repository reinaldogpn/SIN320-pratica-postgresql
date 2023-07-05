-- 1. Abra o PgAdmin e crie um banco de dados chamado loja_cds. Importe o
-- ScriptPratica11.sql para criar a estrutura e povoar o banco de dados.

DROP DATABASE IF EXISTS loja_cds;
CREATE DATABASE loja_cds;

-- 2. Faça um backup do banco de dados loja_cds com as seguintes
-- características:
-- Nome do arquivo de saída: bkp_loja_cds_16_06_2023.backup
-- Formato do arquivo de saída: Binário tar

pg_dump -U postgres -Ft loja_cds > C:\postgres_bkp\bkp_loja_cds_16_06_2023.backup

-- 3. Crie um banco de dados vazio chamado bd_cd1 e restaure o backup criado
-- anteriormente. Use o pg_restore.

CREATE DATABASE bd_cd1;

pg_restore -U postgres -d bd_cd1 C:\postgres_bkp\bkp_loja_cds_16_06_2023.backup

-- 4. Depois de restaurar o backup confira se o banco de dados foi restaurado
-- corretamente usando a interface PgAdmin.

-- Ok!

-- 5. Faça um novo backup no banco de dados loja_cds com as seguintes
-- características:
-- Backup apenas da estrutura do banco de dados sem os dados
-- Nome do arquivo de saída: backup_estrutura_loja_cds.dump
-- Formato do arquivo de saída: Texto padrão

pg_dump -U postgres -Fp -s loja_cds > C:\postgres_bkp\backup_estrutura_loja_cds.dump

-- 6. Crie um banco de dados vazio chamado cd_estrutura e restaure o backup
-- criado no exercício 5. Após a restauração verifique o resultado através do
-- pg_admin. PS: Use o psql para restaurar o backup.

CREATE DATABASE cd_estrutura;

psql -U postgres cd_estrutura < C:\postgres_bkp\backup_estrutura_loja_cds.dump

-- Ok!

-- 7. Descubra o tamanho do banco de dados loja_cds. Depois verifique se o seu
-- backup (bd_cd1) tem o mesmo tamanho

SELECT pg_size_pretty(pg_database_size ('loja_cds'));

SELECT pg_size_pretty(pg_database_size ('bd_cd1'));

-- 8. Nós vimos na aula teórica que o mais "caro" computacionalmente são as
-- operações de entrada e saída. Sendo assim a definição do tamanho da
-- memória cache do SGBD é muito importante no processo de tuning. Para
-- verificar se a memória usada pelo SGBD está ideal, utilize a consulta abaixo.
-- Se o resultado for acima de 80 significa que o tamanho da memória cache do
-- SGBD foi configurado corretamente.

SELECT (SUM(blks_hit)/SUM(blks_read+blks_hit) * 100)::int
AS taxa FROM pg_stat_database

-- Saída: 99
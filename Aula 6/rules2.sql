-- 1. Abrir o SGBD PostgreSQL (usar a interface PgAdmin) e criar um banco de
-- dados chamado venda.

DROP DATABASE IF EXISTS venda;
CREATE DATABASE venda;

-- 2. Executar o script chamado scriptBDVenda.sql (disponível no PVANet
-- Moodle) para criar a estrutura e povoar o banco de dados.

-- 3. Crie uma regra (rule) na tabela itemdopedido chamada “rl_baixar_estoque”
-- para baixar o estoque de um PRODUTO quando ele for vendido. OBS: A regra
-- deve atualizar (subtrair a quantidade vendida) o campo estoque na tabela
-- produto.

CREATE OR REPLACE RULE rl_baixar_estoque AS
ON INSERT TO itemdopedido DO
UPDATE produto SET estoque = estoque - new.quantidade;

-- 4. Crie uma regra (rule) para retornar à quantidade em estoque de um
-- itemdopedido que foi removido. OBS: A mesma ideia da regra anterior, só que
-- neste caso deve-se somar a quantidade removida do estoque (produto).

CREATE OR REPLACE RULE rl_retornar_estoque AS
ON DELETE TO itemdopedido DO
UPDATE produto SET estoque = estoque + old.quantidade;

-- 5. Crie uma tabela de log (logvendas) com os seguintes campos:
-- Coluna Tipo OBS
-- Código Serial PK
-- Data Date
-- Usuário chactere varying(20)
-- descricao chactere varying(255) Descrição do log cadastrado.

CREATE TABLE logvendas (
	codigo SERIAL PRIMARY KEY,
	data DATE,
	usuario VARCHAR(20),
	descricao VARCHAR(255)
);

-- 6. Crie uma regra (rule) para criar um log quando algum produto for atualizado.
-- OBS: Neste caso a descrição na tabela logvendas deverá constar o texto
-- “produto atualizado”. Depois de criar a regra, atualize um produto e verifique se
-- a tabela logvendas foi preenchida.

CREATE OR REPLACE RULE rl_produto_update AS
ON UPDATE TO produto DO
INSERT INTO logvendas (data, usuario, descricao) VALUES (current_date, current_user, 'Produto atualizado.');

-- Consultando produtos...
SELECT * FROM produto;

-- Atualizando preço do produto Queijo...
UPDATE produto SET precounitario = 0.98
WHERE codigoproduto = 25;

-- Verificando a rule...
SELECT * FROM logvendas;

-- 7. Crie uma regra (rule) para criar um log quando um cliente for removido. OBS:
-- Neste caso a descrição na tabela logvendas deverá constar o texto “cliente
-- removido”. Depois de criar a regra, remova um cliente e verifique se a tabela
-- logvendas foi preenchida.

CREATE OR REPLACE RULE rl_cliente_removed AS
ON DELETE TO cliente DO
INSERT INTO logvendas (data, usuario, descricao) VALUES (current_date, current_user, 'Cliente removido.');

-- Consultando clientes...
SELECT * FROM cliente;

-- Removendo cliente Ana...
DELETE FROM cliente WHERE codigocliente = 720;

-- Verificando a rule...
SELECT * FROM logvendas;

-- 8. Crie uma regra (rule) para excluir os itens (tabela itemdopedido)
-- relacionados a um pedido (tabela pedido) quando este for removido do banco
-- de dados.

CREATE OR REPLACE RULE rl_delete_itens AS
ON DELETE TO pedido DO
DELETE FROM itemdopedido WHERE old.numpedido = itemdopedido.numpedido;

-- 9. Crie uma view que retorne o codigo, o nome e a cidade dos clientes. Depois
-- crie uma regra (rule) para tornar esta View atualizável para o comando
-- INSERT, ou seja, para dar a sensação para o usuário que ele poderá inserir na
-- View criada.

CREATE VIEW info_clientes (codigo, nome, cidade) AS
SELECT codigocliente, nomecliente, cidade FROM cliente;

CREATE OR REPLACE RULE rl_view_info_clientes AS ON
INSERT TO info_clientes DO INSTEAD
INSERT INTO cliente (codigocliente, nomecliente, cidade) 
VALUES (new.codigo, new.nome, new.cidade);

-- 1. Abrir o Prompt de comando CMD no Windows. Ao final da aula, poste as
-- respostas no PVANetMoodle. O arquivo deverá ter como nome seu número de
-- matrícula e a extensão .sql. DICA: Você pode copiar os códigos do terminal e
-- colar em um arquivo de texto.

-- 2. Digite psql -U postgres para entrar na interface de linha de comando do
-- SGBD PostgreSQL.

psql -U postgres

-- 3. Crie um banco de dados chamado aulapratica02.

create database aulapratica02;

-- 4. Crie todas as tabelas de acordo com o modelo apresentado acima. Não
-- esqueça de criar as chaves primárias (PK) e estrangeiras (FK). OBS: A ordem
-- de criação é muito importante. Você precisa ter uma tabela criada para
-- referenciá-la na chave estrangeira. OBS2: Após a criação das tabelas use o
-- comando \dt para verificar se as tabelas foram criadas corretamente.

create table empresa (codigo integer PRIMARY KEY, nome varchar(60), rua varchar(40), cidade varchar(20), estado char(2));

create table empregado(codigo integer primary key, codigo_empresa integer, foreign key(codigo_empresa) references empresa(codigo), codigo_gerente int, foreign key(codigo_gerente) references empregado(codigo), nome varchar(60), rua varchar(20), cidade varchar(20), estado char(2), sexo char(1), salario float);

create table projeto(codigo int primary key, nome varchar(30));

create table trabalha_em(codigo_empregado int primary key, foreign key (codigo_empregado) references empregado(codigo), codigo_projeto int, foreign key (codigo_projeto) references projeto(codigo), horas int);

insert into empresa(codigo, nome, rua, cidade, estado) values (1, 'intel', 'a', 'rio_paranaiba', 'mg');

insert into empresa(codigo, nome, rua, cidade, estado) values (2, 'amd', 'b', 'rio_paranaiba', 'mg');

insert into empresa(codigo, nome, rua, cidade, estado) values (3, 'nvidia', 'c', 'rio_paranaiba', 'mg');
                                                               
insert into empregado(codigo, codigo_empresa, codigo_gerente, nome, rua, cidade, estado, sexo, salario) values (1, 1, null, 'reinaldo', 'Y', 'rio_paranaiba', 'mg', 'M', 3000);

insert into empregado(codigo, codigo_empresa, codigo_gerente, nome, rua, cidade, estado, sexo, salario) values (2, 1, 1, 'joao', 'd', 'rio_paranaiba', 'mg', 'M', 2000);

insert into empregado(codigo, codigo_empresa, codigo_gerente, nome, rua, cidade, estado, sexo, salario) values (3, 2, null, 'adriana', 'd', 'rio_paranaiba', 'mg', 'F', 3000);

insert into empregado(codigo, codigo_empresa, codigo_gerente, nome, rua, cidade, estado, sexo, salario) values (4, 2, 3, 'juliana', 'd', 'rio_paranaiba', 'mg', 'F', 2000);

insert into empregado(codigo, codigo_empresa, codigo_gerente, nome, rua, cidade, estado, sexo, salario) values (5, 3, null, 'pedro', 'd', 'rio_paranaiba', 'mg', 'M', 3000);

insert into empregado(codigo, codigo_empresa, codigo_gerente, nome, rua, cidade, estado, sexo, salario) values (6, 3, 5, 'jose', 'd', 'rio_paranaiba', 'mg', 'M', 2000);

insert into projeto(codigo, nome) values (1, 'banco_de_dados');

insert into projeto(codigo, nome) values (2, 'programacao');

insert into projeto(codigo, nome) values (3, 'web');

insert into trabalha_em(codigo_empregado, codigo_projeto, horas) values (2, 1, 20);

insert into trabalha_em(codigo_empregado, codigo_projeto, horas) values (4, 2, 30);

insert into trabalha_em(codigo_empregado, codigo_projeto, horas) values (6, 3, 35);

-- 6. Crie e execute as seguintes consultas:

-- A. Para cada empregado, recupere o nome, salário e nome da empresa para
-- qual trabalha.

select empregado.nome, empregado.salario, empresa.nome from empregado as empregado, empresa as empresa where empregado.codigo_empresa = empresa.codigo;

-- B. Selecione o salário médio de todos os empregados do sexo feminino da
-- empresa <amd>.

select avg(salario) from empregado as f join empresa as e on f.codigo_empresa = e.codigo where sexo = 'F' and e.nome = 'amd';

-- C. Obter a quantidade de empregados de todas as empresas. O resultado deverá
-- ser o nome da empresa e a quantidade de empregados que trabalham nela,
-- respectivamente.

select e.nome, count(*) from empregado as f join empresa as e on f.codigo_empresa = e.codigo group by e.nome;

-- D. Encontre todos os empregados que moram na mesma cidade que seus
-- gerentes.

select f.nome from empregado as f join empregado as s on f.codigo_gerente = s.codigo and f.cidade = s.cidade;

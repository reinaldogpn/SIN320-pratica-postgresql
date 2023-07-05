CREATE TABLE funcionario (
        cpf VARCHAR(15) NOT NULL,
        pnome VARCHAR(45),
        minicial CHAR(1),
        unome VARCHAR(30),
        dataNasc DATE,
        endereco VARCHAR(90),
        sexo CHAR(1),
        salario NUMERIC(10,2),
        cpfsuperv VARCHAR(15),
        numdept INTEGER,
        PRIMARY KEY (cpf),
        FOREIGN KEY (cpfsuperv) REFERENCES funcionario (cpf)
);

CREATE TABLE departamento (
        dnumero INTEGER NOT NULL,
        dnome VARCHAR(45),
        cpfgerente VARCHAR(15),
        dataInicio DATE,
        PRIMARY KEY (dnumero),
        FOREIGN KEY (cpfgerente) REFERENCES funcionario(cpf)
);

CREATE TABLE projeto (
        projnumero INTEGER NOT NULL,
        projnome VARCHAR(45),
        projlocal VARCHAR(30),
        dnum INTEGER,
        PRIMARY KEY (projnumero),
        FOREIGN KEY (dnum)REFERENCES departamento (dnumero)
);

CREATE TABLE trabalhaem (
	fcpf VARCHAR(15) NOT NULL,
        projnumero INTEGER NOT NULL,
        horas INTEGER,
        PRIMARY KEY (projnumero,fcpf),
        FOREIGN KEY (projnumero) REFERENCES projeto (projNumero),
        FOREIGN KEY (fcpf) REFERENCES funcionario (cpf)
);

CREATE TABLE dependente (
        fcpf VARCHAR(15) NOT NULL,
        nomedependente VARCHAR(45),
        sexo CHAR(1),
        dataNasc DATE,
        parentesco VARCHAR(20),
        PRIMARY KEY (fcpf,nomeDependente),
        FOREIGN KEY (fcpf) REFERENCES funcionario (cpf)

);


ALTER TABLE funcionario ADD CONSTRAINT empregado_depto_fk FOREIGN KEY (numDept) REFERENCES departamento(dnumero);

INSERT INTO departamento VALUES (5,'Pesquisa',NULL,'1988-05-22');
INSERT INTO departamento VALUES (4,'Administracao',NULL,'1985-01-01');
INSERT INTO departamento VALUES (1,'Direcao',NULL,'1981-06-19');

INSERT INTO funcionario VALUES ('0123456789','Joao','B','Silva','1955-01-09','Rua dos Camelos, 23','M',30000,NULL,5);
INSERT INTO funcionario VALUES ('0987654321','Horacio',NULL,'Bagual','1970-10-10','Av. dos Tapejaras, 90','M',40000,'0123456789',5);
INSERT INTO funcionario VALUES ('1230984567','Ana',NULL,'Bacana','1980-06-20','Av. Atacama, 10 apto 22','F',25000,'0123456789',4);
INSERT INTO funcionario VALUES ('0981234567','Antonio',NULL,'Pestana','1990-04-13','Rod. Imigrantes, 1940','M',45000,'0987654321',4);
INSERT INTO funcionario VALUES ('1029384756','Maria','A','Real','1982-11-14','Rua Petropolis, 13','F',38000,'0123456789',5);
INSERT INTO funcionario VALUES ('0192837465','Ada','M','Lovelace','1965-10-15','Rua dos Ingleses, 1020','F',25000,'0123456789',5);
INSERT INTO funcionario VALUES ('1234555555','Joaquina',NULL,'Pasqualini','1968-08-17','Rua dos Ingleses, 1010','F',25000,'0123456789',4);
INSERT INTO funcionario VALUES ('0987655555','Jaime',NULL,'Bonde','1958-01-01','Rua dos Ingleses, 1010','M',70000,'0123456789',1);

UPDATE departamento set cpfgerente = '1230984567' where dnumero = 5;
UPDATE departamento set cpfgerente = '1029384756' where dnumero = 4;
UPDATE departamento set cpfgerente = '1234555555' where dnumero = 1;

INSERT INTO projeto VALUES (1,'Transmogrifador','São Paulo',5);
INSERT INTO projeto VALUES (2,'Cama Hiperbarica','Porto Alegre',5);
INSERT INTO projeto VALUES (3,'Emissor de Raios Z','Rio de Janeiro',5);
INSERT INTO projeto VALUES (10,'Gestao dos 80/20','Rio Paranaíba',4);
INSERT INTO projeto VALUES (20,'Business Inteligence','São Paulo',1);
INSERT INTO projeto VALUES (30,'Bonus para Inventores','Natal',4);

INSERT INTO trabalhaem VALUES ('0123456789',1,32);
INSERT INTO trabalhaem VALUES ('0123456789',2,7.5);
INSERT INTO trabalhaem VALUES ('1029384756',3,40);
INSERT INTO trabalhaem VALUES ('0192837465',1,20);
INSERT INTO trabalhaem VALUES ('0192837465',2,20);
INSERT INTO trabalhaem VALUES ('0987654321',2,10);
INSERT INTO trabalhaem VALUES ('0987654321',3,10);
INSERT INTO trabalhaem VALUES ('0987654321',10,10);
INSERT INTO trabalhaem VALUES ('0987654321',20,10);
INSERT INTO trabalhaem VALUES ('1230984567',30,30);
INSERT INTO trabalhaem VALUES ('1230984567',10,10);
INSERT INTO trabalhaem VALUES ('0987655555',10,35);
INSERT INTO trabalhaem VALUES ('0987655555',30,5);
INSERT INTO trabalhaem VALUES ('0981234567',30,20);
INSERT INTO trabalhaem VALUES ('0981234567',20,15);
INSERT INTO trabalhaem VALUES ('1234555555',20,0);
INSERT INTO trabalhaem VALUES ('0123456789',3,15);

INSERT INTO dependente VALUES ('0987654321','Joana Bagual','F','1986-05-05','Filha');
INSERT INTO dependente VALUES ('0987654321','Pedro Bagual','M','1983-10-25','Filho');
INSERT INTO dependente VALUES ('0987654321','Alice Bagual','F','1958-05-03','Esposa');
INSERT INTO dependente VALUES ('1230984567','Maximo Bacana','M','1942-02-28','Esposo');
INSERT INTO dependente VALUES ('0123456789','Jagunco da Silva','M','1978-01-01','Filho');
INSERT INTO dependente VALUES ('0123456789','Jaqueline da Silva','F','1978-12-31','Filha');
INSERT INTO dependente VALUES ('0123456789','Joana da Silva','F','1957-05-05','Esposa');
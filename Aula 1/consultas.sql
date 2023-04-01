-- A. Obter o nome completo dos funcionários com salário maior que R$30000.

SELECT pnome, unome 
FROM funcionario
WHERE salario > 30000;

-- B. Obter o primeiro nome e endereço de todos os funcionários que
-- trabalham no departamento Administração. Use INNER JOIN para esta
-- consulta.

SELECT pnome, endereco
FROM funcionario JOIN departamento ON numdept = dnumero
WHERE dnome = 'Administracao';

-- C. Listar o último nome e as horas dos funcionários que trabalham no projeto
-- de código 3. Apresentar o resultado em ordem decrescente de horas
-- trabalhadas.

SELECT unome, horas
FROM funcionario, trabalhaem
WHERE projnumero = 3
ORDER BY horas DESC;

-- D. Listar o nome completo dos funcionários que trabalham no projeto
-- chamado “Transmogrifador”. Use INNER JOIN para esta consulta.

SELECT DISTINCT pnome, unome
FROM funcionario, trabalhaem AS T JOIN projeto AS P ON T.projnumero = P.projnumero
WHERE projnome = 'Transmogrifador';

-- E. Selecione o primeiro nome e o sobrenome dos funcionários e seus
-- respectivos supervisores. Mostre também os funcionários que não possuem
-- supervisores.

SELECT F.pnome AS NOME_FUNC, F.unome AS SOBRENOME_FUNC, S.pnome AS NOME_SUPERV, S.unome AS SOBRENOME_SUPERV
FROM funcionario AS F LEFT JOIN funcionario AS S ON F.cpfsuperv = S.cpf;

-- F. Apresente o número de projetos cadastrados

SELECT COUNT (*) AS QTD_PROJETOS
FROM projeto;

-- G. Obter, a partir da tabela Trabalha_em, os números mínimos, máximo e
-- médio de horas trabalhadas em cada projeto. O resultado deve possuir 4
-- colunas nomeadas: projeto, mínimo, máximo e média. DICA: Use o comando
-- AS para renomear as colunas.

SELECT projnome AS PROJETO, MIN(T.horas) AS MINIMO, MAX(T.horas) AS MAXIMO, AVG(T.horas) AS MEDIA
FROM projeto AS P JOIN trabalhaem AS T ON P.projnumero = T.projnumero
GROUP BY projnome;

-- H. Para cada departamento cujo salário médio do funcionário seja maior do
-- que R$33000, recupere o nome do departamento e o número de
-- funcionários que trabalham nele.

SELECT dnome AS PROJETO, COUNT(cpf) AS QTD_FUNCIONARIO
FROM departamento JOIN funcionario ON dnumero = numdept
GROUP BY dnome HAVING AVG(salario) > 33000;

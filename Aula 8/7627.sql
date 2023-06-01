-- 3. Crie uma function para inserir registros na tabela produto. O procedimento
-- deve receber o código do produto, a unidade, a descrição do produto, o preço
-- unitário, a quantidade em estoque e a categoria. Deve retornar uma mensagem
-- (NOTICE) se os valores não forem passados.

CREATE FUNCTION insere_produto(codigoproduto integer, unidade character(3), descricaoproduto varchar(30), precounitario real, estoque real, categoria varchar(30)) 
RETURNS void AS $$
BEGIN
    IF codigoproduto IS NULL THEN
        RAISE NOTICE 'Código do produto não informado';
        RETURN;
    END IF;
    IF unidade IS NULL THEN
        RAISE NOTICE 'Unidade não informada';
        RETURN;
    END IF;
    IF descricaoproduto IS NULL THEN
        RAISE NOTICE 'Descrição do produto não informada';
        RETURN;
    END IF;
    IF precounitario IS NULL THEN
        RAISE NOTICE 'Preço unitário não informado';
        RETURN;
    END IF;
    IF estoque IS NULL THEN
        RAISE NOTICE 'Estoque não informado';
        RETURN;
    END IF;
    IF categoria IS NULL THEN
        RAISE NOTICE 'Categoria não informada';
        RETURN;
    END IF;
    INSERT INTO produto VALUES (codigoproduto, unidade, descricaoproduto, precounitario, estoque, categoria);
    RAISE NOTICE 'Produto inserido com sucesso';
END;
$$ LANGUAGE plpgsql;

-- TESTE

SELECT insere_produto(111, 'Kg', 'Cebola Roxa', 0.30, 50, 'Alimento');

-- 4. Crie uma function que apresente o nome e o endereço de todos os clientes
-- de uma cidade passada por parâmetro de entrada na função.

CREATE FUNCTION clientes_por_cidade(nomecidade varchar(15))
RETURNS TABLE (nomecliente_ varchar(20), endereco_ varchar(30)) AS $$
BEGIN
    RETURN QUERY SELECT nomecliente, endereco FROM cliente WHERE cidade = nomecidade;
END;
$$ LANGUAGE plpgsql;

-- TESTE

SELECT clientes_por_cidade('Belo Horizonte');

-- 5. Crie uma function que retorne todos os itens de um determinado pedido
-- passado como parâmetro de entrada. A saída será o nome do produto, a
-- quantidade vendida, o preço unitário e o desconto.

CREATE FUNCTION itens_por_pedido(numpedido_ integer)
RETURNS TABLE (descricaoproduto_ varchar(30), quantidade_ integer, precounitario_ real, desconto_ real) AS $$
BEGIN
    RETURN QUERY SELECT produto.descricaoproduto, itemdopedido.quantidade, itemdopedido.precounitario, itemdopedido.desconto FROM itemdopedido INNER JOIN produto ON itemdopedido.codigoproduto = produto.codigoproduto WHERE numpedido = numpedido_;
END;
$$ LANGUAGE plpgsql;

-- TESTE

SELECT itens_por_pedido (121);

-- 6. Crie uma function que receba como parâmetro uma string que será usada
-- como chave de busca parcial pelo nome (descrição) de um produto. Se existir
-- apenas um produto, a função deverá retornar o código do produto encontrado
-- como parâmetro de saída. Caso a consulta encontre mais de um produto, a
-- função deverá retornar -1. Caso nenhum produto seja encontrado, o código
-- retornado deverá ser 0. OBS: Em todos os casos, a função deverá enviar uma
-- mensagem (NOTICE) para o usuário.

CREATE OR REPLACE FUNCTION busca_produto(descricaoproduto_ varchar(30), codigoproduto_ integer)
RETURNS integer AS $$
BEGIN
    SELECT codigoproduto INTO codigoproduto_ FROM produto WHERE descricaoproduto LIKE '%' || descricaoproduto_ || '%';
    IF codigoproduto_ IS NULL THEN
        RAISE NOTICE 'Nenhum produto encontrado';
        RETURN 0;
    END IF;
    IF (SELECT COUNT(*) FROM produto WHERE descricaoproduto LIKE '%' || descricaoproduto_ || '%') > 1 THEN
        RAISE NOTICE 'Mais de um produto encontrado';
        RETURN -1;
    END IF;
    RAISE NOTICE 'Produto encontrado';
    RETURN codigoproduto_;
END;
$$ LANGUAGE plpgsql;

-- TESTE

SELECT busca_produto('Cebola Roxa', 112);

-- 7. Crie uma function para gerar um relatório que mostre o nome do vendedor e
-- o resultado de um aumento de salário de X% para os vendedores que estão na
-- faixa de comissão Y. Onde X (porcentagem de aumento - do tipo integer) e Y
-- (faixa de comissão - do tipo char(1)) serão passados como parâmetro.

CREATE FUNCTION relatorio_aumento_salario(porcentagem integer, faixacomissao_ char(1))
RETURNS TABLE (nomevendedor_ varchar(20), salario_ real) AS $$
BEGIN
    RETURN QUERY SELECT nomevendedor, salariofixo FROM vendedor WHERE faixacomissao = faixacomissao_;
END;
$$ LANGUAGE plpgsql;

-- TESTE

SELECT relatorio_aumento_salario(5, 'C');

-- 8. Crie um trigger na tabela itemdopedido chamada “tg_baixar_estoque” para
-- baixar o estoque de um PRODUTO quando ele for vendido e que emita uma
-- mensagem para o usuário se o estoque estiver abaixo de 5. OBS: Você deverá
-- criar uma function que faça a baixa no estoque e envie a mensagem para o
-- usuário e deverá chamá-la no código do trigger.

CREATE OR REPLACE FUNCTION baixa_estoque()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE produto SET estoque = estoque - NEW.quantidade WHERE codigoproduto = NEW.codigoproduto;
    IF (SELECT estoque FROM produto WHERE codigoproduto = NEW.codigoproduto) < 5 THEN
        RAISE NOTICE 'Estoque abaixo de 5';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_baixar_estoque
AFTER INSERT ON itemdopedido
FOR EACH ROW
EXECUTE FUNCTION baixa_estoque();

-- TESTE

SELECT * FROM produto;

INSERT INTO pedido(numpedido, codigovendedor, codigocliente, prazoentrega)
VALUES (333, 111, 110, 15);

INSERT INTO itemdopedido (codigoproduto, numpedido, quantidade, precounitario, desconto) 
VALUES (53, 333, 6, 3.8, 0.1);
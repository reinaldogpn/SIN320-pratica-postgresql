-- 1. Abra a interface Pgadmin4 e crie um banco de dados espacial chamado
-- praticabdgeo (usar o postgis_22_sample como template).

CREATE DATABASE praticabdgeo TEMPLATE postgis_22_sample;

-- 2. Dentro do banco de dados praticadbgeo, crie uma tabela chamada
-- tblpontos_rp com as seguintes características.
-- Nome campo Tipo
-- Nome varchar(30)
-- Geom geometry POINT SRID 4326

CREATE TABLE tblpontos_rp (
	nome VARCHAR(30),
	geom GEOMETRY (POINT, 4326)
);

-- 3. Procure pontos de estabelecimentos do município de Rio Paranaíba no
-- Google Maps e insira na tabela criada anteriormente. Insira no mínimo 5 pontos
-- e entre os pontos selecionados insira um ponto para UFV e outro ponto para a
-- AABB.

INSERT INTO tblpontos_rp (nome, geom) VALUES ('Supermercado São Francisco', st_GeomFromText('POINT(-19.196041231984044 -46.23876163657561)')),
											 ('House Burger', st_GeomFromText('POINT(-19.19727731591336 -46.23678487057449)')),
											 ('Posto 2000', st_GeomFromText('POINT(-19.199096752608078 -46.235508989753654)')),
											 ('UFV', st_GeomFromText('POINT(-19.216781319916507 -46.221980176537684)')),
											 ('AABB', st_GeomFromText('POINT(-19.186466041425756 -46.25244821032255)'));
			
-- 4. Usando o carregador shp2pgsql, importe o shape Cidade.shp
-- (disponibilizado no PVANetMoodle) para o banco de dados praticabdgeo. A
-- importação deve ser feita na tabela chamada tblmunicipios no esquema
-- public. PS: Use o SRID 4326.

shp2pgsql -s 4326 "%USERPROFILE%\Downloads\shapecidade\shapecidade\Cidade.shp" public.tblmunicipios > "%USERPROFILE%\Downloads\shapecidade\shapecidade\Cidade.sql"

psql -U postgres -d praticabdgeo -f "%USERPROFILE%\Downloads\shapecidade\shapecidade\Cidade.sql"

-- 5. Crie um índice espacial para a tabela tblpontos_rp. PS: A coluna espacial é a
-- geom.

CREATE INDEX idx_tblpontos_rp ON tblpontos_rp USING GIST (geom);

-- 6. Realize as seguintes consultas geográficas no banco de dados criado
-- a) Selecione a área do município de Rio Paranaíba. DICA: Os municípios estão
-- armazenados em graus (lat, lng), para transformar em metros use a função
-- st_transform(geometria, 31983)

SELECT st_transform(geom, 4326) FROM tblmunicipios WHERE name = 'Rio Paranaiba';

-- b) Apresente a distância em km entre a UFV e a AABB.

SELECT st_distance(st_transform(geom, 4326), (SELECT geom FROM tblpontos_rp WHERE nome = 'UFV')) / 1000 FROM tblpontos_rp WHERE nome = 'AABB';

-- INSERT SCRIPT

INSERT INTO usuarios (email, senha, nome, telefone, cpf, endereco, numero_cartao, avatar)
VALUES
    ('reinaldo@example.com', 'senha123', 'Reinaldo Gonçalves', '123456789', '123.456.789-01', 'Endereço 1', '1234567890123456', lo_import('C:\exemplos\avatar_exemplo.png')),
    ('adriana@example.com', 'senha456', 'Adriana da Silva', '987654321', '987.654.321-01', 'Endereço 2', '6543210987654321', lo_import('C:\exemplos\avatar_exemplo.png')),
    ('juliana@example.com', 'senha789', 'Juliana Gonçalves', '555555555', '555.555.555-01', 'Endereço 3', '1111111111111111', lo_import('C:\exemplos\avatar_exemplo.png'));

INSERT INTO faturas (usuario_id, mes, ano, valor, pago)
VALUES
    (1, 6, 2023, 50.00, true),
    (2, 6, 2023, 50.00, false),
    (3, 6, 2023, 50.00, false);

INSERT INTO videos (categoria, imagem, arquivo)
VALUES
    ('filmes', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv')),
    ('filmes', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv')),
    ('filmes', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv')),
    ('series', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv')),
    ('series', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv')),
    ('series', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv')),
    ('documentarios', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv')),
    ('documentarios', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv')),
    ('documentarios', lo_import('C:\exemplos\header_exemplo.png'), lo_import('C:\exemplos\video_exemplo.mkv'));

INSERT INTO generos (nome)
VALUES
    ('Drama'),
    ('Fantasia'),
    ('Ficção Científica');

INSERT INTO filmes (video_id, titulo, ano, minutos, genero)
VALUES
    (1, 'O Poderoso Chefão', 1972, 175, 1),
    (2, 'Central do Brasil', 1998, 110, 1),
    (3, 'A Origem', 2010, 148, 3);

INSERT INTO series (titulo, temporadas, genero)
VALUES
    ('Game of Thrones', 8, 2),
    ('The Walking Dead', 11, 3),
    ('Black Mirror', 6, 3);

INSERT INTO episodios (video_id, serie_id, titulo, ano, minutos, temporada, numero_ep, proximo_ep)
VALUES
    (4, 1, 'Winter Is Coming', 2011, 62, 1, 1, 2),
    (5, 2, 'What Comes After', 2018, 45, 9, 5, 6),
    (6, 3, 'The Entire History of You', 2011, 49, 1, 3, null);

INSERT INTO documentarios (video_id, titulo, ano, minutos, produtora, genero)
VALUES
    (7, 'Documentário 1', 2022, 60, 'Produtora 1', 1),
    (8, 'Documentário 2', 2023, 75, 'Produtora 2', 2),
    (9, 'Documentário 3', 2021, 50, 'Produtora 3', 3);

INSERT INTO atores (nome, data_nascimento, local_nascimento)
VALUES
    ('Al Pacino', '1990-01-01', 'Local 1'),
    ('Fernanda Montenegro', '1985-05-10', 'Brasil'),
    ('Leonardo di Caprio', '1995-12-25', 'Local 3'),
    ('Kit Harrington', '1990-01-01', 'Local 1'),
    ('Andrew Lincoln', '1985-05-10', 'Local 2'),
    ('Toby Kebbell', '1995-12-25', 'Local 3'),
    ('Ator 1', '1990-01-01', 'Local 1'),
    ('Ator 2', '1985-05-10', 'Local 2'),
    ('Ator 3', '1995-12-25', 'Local 3');

INSERT INTO videos_atores (video_id, ator_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9);

INSERT INTO avaliacoes (usuario_id, video_id, nota, comentario)
VALUES
    (1, 1, 4, 'Bom filme!'),
    (2, 2, 3, 'Engraçado!'),
    (3, 3, 5, 'Excelente filme!'),
    (1, 4, 8, 'Como tudo começou!'),
    (1, 5, 10, 'Triste, mas é muito bom!'),
    (1, 6, 10, 'Melhor episódio da série!');

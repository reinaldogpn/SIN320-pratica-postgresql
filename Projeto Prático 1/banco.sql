-- Create db

DROP DATABASE IF EXISTS streamberrydb;

CREATE DATABASE streamberrydb;

-- Create tables

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    cpf VARCHAR(14) NOT NULL UNIQUE,
    endereco TEXT,
    numero_cartao VARCHAR(20) NOT NULL,
    avatar OID,
    bloqueado BOOLEAN DEFAULT FALSE
);

CREATE TABLE faturas (
    id SERIAL PRIMARY KEY,
    usuario_id INT,
    mes INT,
    ano INT,
    valor DECIMAL(10, 2),
    pago BOOLEAN,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE videos (
    id SERIAL PRIMARY KEY,
    categoria VARCHAR(45),
    imagem OID,
    arquivo OID
);

CREATE TABLE generos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE filmes (
    id SERIAL PRIMARY KEY,
    video_id INT,
    titulo VARCHAR(255) NOT NULL,
    ano INT,
    minutos INT,
    genero INT,
    FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE,
    FOREIGN KEY (genero) REFERENCES generos(id)
);

CREATE TABLE series (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    temporadas INT,
    genero INT,
    FOREIGN KEY (genero) REFERENCES generos(id)
);

CREATE TABLE episodios (
    id SERIAL PRIMARY KEY,
    video_id INT,
    serie_id INT,
    titulo VARCHAR(255) NOT NULL,
    ano INT,
    minutos INT,
    temporada INT,
    numero_ep INT,
    proximo_ep INT,
    FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE,
    FOREIGN KEY (serie_id) REFERENCES series(id) ON DELETE CASCADE
);

CREATE TABLE documentarios (
    id SERIAL PRIMARY KEY,
    video_id INT,
    titulo VARCHAR(255) NOT NULL,
    ano INT,
    minutos INT,
    produtora VARCHAR(255) NOT NULL,
    genero INT,
    FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE,
    FOREIGN KEY (genero) REFERENCES generos(id)
);

CREATE TABLE atores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    local_nascimento TEXT
);

CREATE TABLE videos_atores (
    video_id INT,
    ator_id INT,
    FOREIGN KEY (video_id) REFERENCES videos (id) ON DELETE CASCADE,
    FOREIGN KEY (ator_id) REFERENCES atores (id) ON DELETE CASCADE
);

CREATE TABLE avaliacoes (
    usuario_id INT,
    video_id INT,
    nota INT,
    comentario TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE,
    FOREIGN KEY (video_id) REFERENCES videos (id) ON DELETE CASCADE
);

-- Create log tables

CREATE TABLE log_usuarios (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    cpf_usuario VARCHAR(14),
    operacao VARCHAR(20)
);

CREATE TABLE log_faturas (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);

CREATE TABLE log_videos (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);

CREATE TABLE log_generos (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);

CREATE TABLE log_filmes (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);

CREATE TABLE log_series (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);

CREATE TABLE log_episodios (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);

CREATE TABLE log_documentarios (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);

CREATE TABLE log_atores (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);

CREATE TABLE log_videos_atores (
    id SERIAL PRIMARY KEY,
    data_hora TIMESTAMP,
    autor VARCHAR(255),
    operacao VARCHAR(20)
);
-- CREATE STORED PROCEDURES SCRIPT

-- Function 1: Verificar mensalidades pendentes

CREATE OR REPLACE FUNCTION verificar_pendencias() 
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM faturas WHERE usuario_id = NEW.usuario_id AND pago = false) >= 2 THEN
        UPDATE usuarios SET bloqueado = true WHERE id = NEW.usuario_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger (executar sempre que uma nova fatura for criada para o usuário)

CREATE TRIGGER verificar_pendencias_trigger
AFTER INSERT ON faturas
FOR EACH ROW
EXECUTE FUNCTION verificar_pendencias();

-- Function 2: Avaliar video

CREATE OR REPLACE FUNCTION avaliar_video(usuario_id INT, video_id INT, nota INT, comentario TEXT) 
RETURNS VOID AS $$
BEGIN
    IF nota >= 0 AND nota <= 10 THEN
        INSERT INTO avaliacoes (usuario_id, video_id, nota, comentario)
        VALUES (usuario_id, video_id, nota, comentario);
    ELSE
        RAISE EXCEPTION 'Nota inválida! A nota deve ser um valor de 0 a 10.';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Function 3: Retornar todos os vídeos disponíveis a partir do nome de um ator ou atriz

CREATE OR REPLACE FUNCTION buscar_videos_por_ator(ator_nome VARCHAR(255))
RETURNS TABLE (
    video_id INT, 
    categoria VARCHAR(20), 
    titulo VARCHAR(255),
    serie VARCHAR(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.id AS video_id,
        v.categoria,
        CASE
            WHEN v.categoria = 'filmes' THEN f.titulo
            WHEN v.categoria = 'series' THEN e.titulo
            WHEN v.categoria = 'documentarios' THEN d.titulo
            ELSE NULL
        END AS titulo,
        CASE
            WHEN v.categoria = 'filmes' THEN NULL
            WHEN v.categoria = 'series' THEN s.titulo
            WHEN v.categoria = 'documentarios' THEN NULL
            ELSE NULL
        END AS serie
    FROM
        videos AS v
        LEFT JOIN filmes AS f ON v.id = f.video_id
        LEFT JOIN documentarios AS d ON v.id = d.video_id
        LEFT JOIN episodios AS e ON v.id = e.video_id
        LEFT JOIN series AS s ON e.serie_id = s.id
        LEFT JOIN videos_atores AS va ON v.id = va.video_id
        LEFT JOIN atores AS a ON va.ator_id = a.id
    WHERE
        a.nome ILIKE '%' || ator_nome || '%';
END;
$$ LANGUAGE plpgsql;

-- Function 4: Retornar todos os vídeos disponíveis a partir do nome de um ator ou atriz

CREATE OR REPLACE FUNCTION buscar_videos_por_titulo(titulo_video VARCHAR(255))
RETURNS TABLE (
    video_id INT, 
    categoria VARCHAR(20), 
    titulo VARCHAR(255),
    serie VARCHAR(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.id AS video_id,
        v.categoria,
        CASE
            WHEN v.categoria = 'filmes' THEN f.titulo
            WHEN v.categoria = 'series' THEN e.titulo
            WHEN v.categoria = 'documentarios' THEN d.titulo
            ELSE NULL
        END AS titulo,
        CASE
            WHEN v.categoria = 'filmes' THEN NULL
            WHEN v.categoria = 'series' THEN s.titulo
            WHEN v.categoria = 'documentarios' THEN NULL
            ELSE NULL
        END AS serie
    FROM
        videos AS v
        LEFT JOIN filmes AS f ON v.id = f.video_id
        LEFT JOIN episodios AS e ON v.id = e.video_id
        LEFT JOIN series AS s ON e.serie_id = s.id
        LEFT JOIN documentarios AS d ON v.id = d.video_id
    WHERE
        CASE
            WHEN v.categoria = 'filmes' THEN f.titulo ILIKE titulo_video || '%'
            WHEN v.categoria = 'series' THEN e.titulo ILIKE titulo_video || '%'
            WHEN v.categoria = 'documentarios' THEN d.titulo ILIKE titulo_video || '%'
            ELSE NULL
        END;
END;
$$ LANGUAGE plpgsql;

-- Function 5: Retornar todos os vídeos disponíveis de acordo com o tipo passado como parâmetro (filme, série ou documentário).

CREATE OR REPLACE FUNCTION buscar_videos_por_categoria(cat_video VARCHAR(255))
RETURNS TABLE (
    video_id INT, 
    categoria VARCHAR(20), 
    titulo VARCHAR(255),
    serie VARCHAR(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.id AS video_id,
        v.categoria,
        CASE
            WHEN v.categoria = 'filmes' THEN f.titulo
            WHEN v.categoria = 'series' THEN e.titulo
            WHEN v.categoria = 'documentarios' THEN d.titulo
            ELSE NULL
        END AS titulo,
        CASE
            WHEN v.categoria = 'filmes' THEN NULL
            WHEN v.categoria = 'series' THEN s.titulo
            WHEN v.categoria = 'documentarios' THEN NULL
            ELSE NULL
        END AS serie
    FROM
        videos AS v
        LEFT JOIN filmes AS f ON v.id = f.video_id
        LEFT JOIN episodios AS e ON v.id = e.video_id
        LEFT JOIN series AS s ON e.serie_id = s.id
        LEFT JOIN documentarios AS d ON v.id = d.video_id
    WHERE
        v.categoria ILIKE '%' || cat_video || '%';
END;
$$ LANGUAGE plpgsql;
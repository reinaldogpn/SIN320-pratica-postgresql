-- CREATE RULES SCRIPT

-- Delete/update rules

CREATE OR REPLACE RULE rl_delete_usuarios AS ON DELETE
    TO usuarios
    DO INSERT INTO log_usuarios (data_hora, autor, cpf_usuario, operacao)
    VALUES (current_timestamp, current_user, old.cpf, 'DELETE');

CREATE OR REPLACE RULE rl_update_usuarios AS ON UPDATE
    TO usuarios
    DO INSERT INTO log_usuarios (data_hora, autor, cpf_usuario, operacao)
    VALUES (current_timestamp, current_user, old.cpf, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_faturas AS ON DELETE
    TO faturas
    DO INSERT INTO log_faturas (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_faturas AS ON UPDATE
    TO faturas
    DO INSERT INTO log_faturas (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_videos AS ON DELETE
    TO videos
    DO INSERT INTO log_videos (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_videos AS ON UPDATE
    TO videos
    DO INSERT INTO log_videos (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_generos AS ON DELETE
    TO generos
    DO INSERT INTO log_generos (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_generos AS ON UPDATE
    TO generos
    DO INSERT INTO log_generos (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_filmes AS ON DELETE
    TO filmes
    DO INSERT INTO log_filmes (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_filmes AS ON UPDATE
    TO filmes
    DO INSERT INTO log_filmes (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_series AS ON DELETE
    TO series
    DO INSERT INTO log_series (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_series AS ON UPDATE
    TO series
    DO INSERT INTO log_series (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_episodios AS ON DELETE
    TO episodios
    DO INSERT INTO log_episodios (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_episodios AS ON UPDATE
    TO episodios
    DO INSERT INTO log_episodios (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_documentarios AS ON DELETE
    TO documentarios
    DO INSERT INTO log_documentarios (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_documentarios AS ON UPDATE
    TO documentarios
    DO INSERT INTO log_documentarios (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_atores AS ON DELETE
    TO atores
    DO INSERT INTO log_atores (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_atores AS ON UPDATE
    TO atores
    DO INSERT INTO log_atores (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

CREATE OR REPLACE RULE rl_delete_videos_atores AS ON DELETE
    TO videos_atores
    DO INSERT INTO log_videos_atores (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'DELETE');

CREATE OR REPLACE RULE rl_update_videos_atores AS ON UPDATE
    TO videos_atores
    DO INSERT INTO log_videos_atores (data_hora, autor, operacao)
    VALUES (current_timestamp, current_user, 'UPDATE');

-- User blob delete rule

CREATE OR REPLACE RULE rl_delete_blob_usuarios AS ON DELETE
    TO usuarios
    DO SELECT lo_unlink(OLD.avatar);

-- Video blobs delete rule

CREATE OR REPLACE RULE rl_delete_blob_videos AS ON DELETE
    TO videos
    DO SELECT lo_unlink(OLD.imagem), lo_unlink(OLD.arquivo);

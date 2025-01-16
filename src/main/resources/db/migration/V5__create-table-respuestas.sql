CREATE TABLE respuestas (
    id BIGSERIAL NOT NULL,
    mensaje VARCHAR(1500) NOT NULL,
    topico_id BIGINT NOT NULL,
    fecha TIMESTAMP NOT NULL,
    usuario_id BIGINT NOT NULL,
    solucion SMALLINT,

    PRIMARY KEY (id),
    CONSTRAINT fk_respuestas_topico_id FOREIGN KEY (topico_id) REFERENCES topicos(id),
    CONSTRAINT fk_respuestas_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

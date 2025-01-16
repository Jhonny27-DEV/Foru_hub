CREATE TABLE topicos (
    id BIGSERIAL NOT NULL,
    titulo VARCHAR(100) NOT NULL UNIQUE,
    mensaje VARCHAR(1500) NOT NULL,
    fecha TIMESTAMP NOT NULL,
    status SMALLINT NOT NULL,
    usuario_id BIGINT NOT NULL,
    curso_id BIGINT NOT NULL,
    respuestas INTEGER,

    PRIMARY KEY (id),
    CONSTRAINT fk_topicos_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    CONSTRAINT fk_topicos_curso_id FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

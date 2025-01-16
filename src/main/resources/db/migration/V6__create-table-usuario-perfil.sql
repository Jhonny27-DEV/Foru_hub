CREATE TABLE usuario_perfil (
    id BIGSERIAL NOT NULL,
    usuario_id BIGINT NOT NULL,
    perfil_id BIGINT NOT NULL,

    PRIMARY KEY (id),
    CONSTRAINT fk_usuario_perfil_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    CONSTRAINT fk_usuario_perfil_perfil_id FOREIGN KEY (perfil_id) REFERENCES perfiles(id)
);

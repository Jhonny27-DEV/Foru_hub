CREATE TABLE cursos (
    id BIGSERIAL NOT NULL,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    categoria VARCHAR(100) NOT NULL,

    PRIMARY KEY (id)
);
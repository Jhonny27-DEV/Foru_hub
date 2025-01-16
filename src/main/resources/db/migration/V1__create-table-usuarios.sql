CREATE TABLE usuarios (
    id BIGSERIAL NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(300) NOT NULL,

    PRIMARY KEY (id)
);

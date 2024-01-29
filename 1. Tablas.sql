use AnimeOddyssey;

/*CREATE SEQUENCE s_id_usuario
    START WITH 1000
    INCREMENT BY 1;
CREATE SEQUENCE s_id_anime
    START WITH 1000
    INCREMENT BY 1;
CREATE SEQUENCE s_id_comunidad
    START WITH 1000
    INCREMENT BY 1;
CREATE SEQUENCE s_id_publicacion
    START WITH 1000
    INCREMENT BY 1;
CREATE SEQUENCE s_id_lista
    START WITH 1000
    INCREMENT BY 1;
CREATE SEQUENCE s_id_comentario
    START WITH 1000
    INCREMENT BY 1;*/

CREATE TABLE Usuarios
(
    ID_Usuario INTEGER AUTO_INCREMENT,
    Nombre     NVARCHAR(30)       NOT NULL,
    Apellido   NVARCHAR(30)       NOT NULL,
    Fecha_Nac  DATE               NOT NULL,
    Username   VARCHAR(20) UNIQUE NOT NULL,
    Correo     VARCHAR(50) UNIQUE NOT NULL,
    Contra     INTEGER            NOT NULL,
    CONSTRAINT pk_id_usuario PRIMARY KEY (ID_Usuario)
);

CREATE TABLE Admins
(
    ID_Admin INTEGER,
    CONSTRAINT fk_id_admin FOREIGN KEY (ID_Admin) REFERENCES Usuarios (ID_Usuario),
    CONSTRAINT pk_id_admin PRIMARY KEY (ID_Admin)
);

CREATE TABLE Normales
(
    ID_Normal INTEGER,
    CONSTRAINT fk_id_normal FOREIGN KEY (ID_Normal) REFERENCES Usuarios (ID_Usuario),
    CONSTRAINT pk_id_normal PRIMARY KEY (ID_Normal)
);

CREATE TABLE Animes
(
    ID_Anime    INTEGER             NOT NULL AUTO_INCREMENT,
    Nombre      NVARCHAR(50) UNIQUE NOT NULL,
    Creador     VARCHAR(50)         NOT NULL,
    Sinopsis    NVARCHAR(1000)      NOT NULL,
    Cant_Ep     INTEGER DEFAULT 0,
    Año_emisión INTEGER(4)          NOT NULL,
    Tipo        VARCHAR(15)         NOT NULL,
    Genero      VARCHAR(15)         NOT NULL,
    Añadido_Por INTEGER             NOT NULL,
    CONSTRAINT pk_id_anime PRIMARY KEY (ID_Anime),
    CONSTRAINT fk_añadido_por FOREIGN KEY (Añadido_Por) REFERENCES Admins (ID_Admin)
);

CREATE TABLE Comunidades
(
    ID_Comunidad INTEGER NOT NULL AUTO_INCREMENT,
    co_ID_Anime  INTEGER NOT NULL,
    CONSTRAINT fk_id_anime FOREIGN KEY (co_ID_Anime) REFERENCES Animes (ID_Anime),
    CONSTRAINT pk_id_comunidad PRIMARY KEY (ID_Comunidad)
);

CREATE TABLE Normal_Comunidad
(
    ID_Comunidad INTEGER NOT NULL,
    ID_Usuario   INTEGER NOT NULL,
    CONSTRAINT pk_normal_comunidad PRIMARY KEY (ID_Comunidad, ID_Usuario),
    CONSTRAINT fk_id_usuario FOREIGN KEY (ID_Usuario) REFERENCES Normales (ID_Normal),
    CONSTRAINT fk_id_comunidad FOREIGN KEY (ID_Comunidad) REFERENCES Comunidades (ID_Comunidad)
);

CREATE TABLE Publicaciones
(
    ID_Publicacion    INTEGER AUTO_INCREMENT,
    pb_ID_Comunidad   INTEGER       NOT NULL,
    pb_ID_Normal      INTEGER       NOT NULL,
    Contenido         NVARCHAR(255) NOT NULL,
    Fecha_Publicación DATE          NOT NULL,
    CONSTRAINT pd_id_publicacion PRIMARY KEY (ID_Publicacion),
    CONSTRAINT fk_pb_id_normal FOREIGN KEY (pb_ID_Normal) REFERENCES Normales (ID_Normal),
    CONSTRAINT fk_pb_id_comunidad FOREIGN KEY (pb_ID_Comunidad) REFERENCES Comunidades (ID_Comunidad)
);

CREATE TABLE Comentarios
(
    ID_Comentario     INTEGER AUTO_INCREMENT,
    co_ID_Publicacion INTEGER      NOT NULL,
    co_ID_Normal      INTEGER      NOT NULL,
    Fecha_Comentario  DATE         NOT NULL,
    Contenido         VARCHAR(255) NOT NULL,
    CONSTRAINT pk_id_comentario PRIMARY KEY (ID_Comentario),
    CONSTRAINT fk_co_id_publicacion FOREIGN KEY (co_ID_Publicacion) REFERENCES Publicaciones (ID_Publicacion),
    CONSTRAINT fk_co_id_normal FOREIGN KEY (co_ID_Normal) REFERENCES Normales (ID_Normal)
);

CREATE TABLE Listas
(
    ID_Lista     INTEGER AUTO_INCREMENT,
    Nombre       VARCHAR(50) NOT NULL,
    li_ID_Normal INTEGER     NOT NULL,
    CONSTRAINT fk_li_id_normal FOREIGN KEY (li_ID_Normal) REFERENCES Normales (ID_Normal),
    CONSTRAINT pk_id_lista PRIMARY KEY (ID_Lista)
);
CREATE UNIQUE INDEX lista_unica ON Listas (Nombre, li_ID_Normal);

CREATE TABLE Lista_Anime
(
    ID_Lista    INTEGER NOT NULL,
    la_ID_Anime INTEGER NOT NULL,
    CONSTRAINT fk_la_id_lista FOREIGN KEY (ID_Lista) REFERENCES Listas (ID_Lista),
    CONSTRAINT fk_la_id_anime FOREIGN KEY (la_ID_Anime) REFERENCES Animes (ID_Anime),
    CONSTRAINT pk_lista_anime PRIMARY KEY (ID_Lista, la_ID_Anime)
);

CREATE TABLE Comparte
(
    ID_Usuario1  INTEGER NOT NULL,
    ID_Usuario2  INTEGER NOT NULL,
    cpt_ID_Lista INTEGER NOT NULL,
    CONSTRAINT fk_id_usuario1 FOREIGN KEY (ID_Usuario1) REFERENCES Normales (ID_Normal),
    CONSTRAINT fk_id_usuario2 FOREIGN KEY (ID_Usuario2) REFERENCES Normales (ID_Normal),
    CONSTRAINT fk_cpt_id_lista FOREIGN KEY (cpt_ID_Lista) REFERENCES Listas (ID_Lista)
);

-- Tablas de auditoría

CREATE TABLE Aud_Anime
(
    aa_id_anime     INTEGER                        NOT NULL,
    nombre_anime    NVARCHAR(50)                   NOT NULL,
    aa_agregado_por INTEGER                        NOT NULL,
    operacion       CHAR                           NOT NULL,
    fecha_creacion  DATE         DEFAULT NOW() NOT NULL,/*
    username        VARCHAR(128) DEFAULT  SESSION_USER()    NOT NULL,*/
    CONSTRAINT chk_operacion CHECK (operacion IN ('I', 'U', 'D'))
);
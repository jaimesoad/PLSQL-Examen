use AnimeOddyssey;

-- Funciones

drop function if exists CalcularEdad;
CREATE FUNCTION CalcularEdad(
    p_edad_fecha DATE
) RETURNS INTEGER deterministic
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_edad_fecha, CURDATE());
END;

-- Procedimientos

drop procedure if exists NuevoNormal;
CREATE PROCEDURE NuevoNormal(
    IN p_nombre varchar(30),
    IN p_apellido varchar(30),
    IN p_fechaNac date,
    IN p_username varchar(20),
    IN p_correo varchar(50),
    IN p_contra integer
)
BEGIN
    declare v_idUsuario integer;

    INSERT INTO Usuarios
    VALUES (v_idUsuario, p_nombre, p_apellido, p_fechaNac, p_username, p_correo, p_contra);

    set v_idUsuario = last_insert_id();

    INSERT INTO Normales(ID_NORMAL)
    VALUES (v_idUsuario);
    COMMIT;
END;

drop procedure if exists NuevoAdmin;
CREATE PROCEDURE NuevoAdmin(
    IN p_nombre varchar(30),
    IN p_apellido varchar(30),
    IN p_fechaNac date,
    IN p_username varchar(20),
    IN p_correo varchar(50),
    IN p_contra integer
)
BEGIN
    declare v_idAdmin integer;

    INSERT INTO Usuarios
    VALUES (v_idAdmin, p_nombre, p_apellido, p_fechaNac, p_username, p_correo, p_contra);

    set v_idAdmin = last_insert_id();

    INSERT INTO Admins(ID_ADMIN)
    VALUES (v_idAdmin);
    COMMIT;
END;

drop procedure if exists NuevoAnime;
CREATE PROCEDURE NuevoAnime(
    IN p_nombre varchar(50),
    IN p_creador varchar(50),
    IN p_sinopsis varchar(1000),
    IN p_cant_ep integer,
    IN p_emision integer,
    IN p_tipo varchar(15),
    IN p_genero varchar(15),
    IN p_agregado_por varchar(50)
)
BEGIN
    declare v_id_admin integer;

    SELECT ID_ADMIN
    INTO v_id_admin
    FROM Usuarios,
         Admins
    WHERE USERNAME = p_agregado_por
      AND ID_USUARIO = ID_ADMIN;

    INSERT INTO Animes(Nombre, Creador, Sinopsis, Cant_Ep, Año_emisión, Tipo, Genero, Añadido_Por)
    VALUES (p_nombre, p_creador, p_sinopsis, p_cant_ep, p_emision, p_tipo, p_genero, v_id_admin);
    COMMIT;
END;

drop procedure if exists NuevaPublicacion;
CREATE PROCEDURE NuevaPublicacion(
    IN p_nombre_anime varchar(50),
    IN p_username varchar(20),
    IN p_contenido varchar(255)
)
BEGIN
    declare v_id_usuario varchar(50);
    declare v_id_comunidad integer;
    declare c_datos CURSOR for
        SELECT ID_USUARIO, ID_COMUNIDAD
        FROM Usuarios,
             Animes,
             Comunidades
        WHERE USERNAME = p_username
          AND Animes.NOMBRE = p_nombre_anime
          AND CO_ID_ANIME = ID_ANIME;

    OPEN c_datos;
    FETCH c_datos INTO v_id_usuario, v_id_comunidad;

    INSERT INTO Publicaciones (pb_ID_Comunidad, pb_ID_Normal, Contenido, Fecha_Publicación)
    VALUES (v_id_comunidad, v_id_usuario, p_contenido, curdate());

    CLOSE c_datos;
    COMMIT;
END;

drop procedure if exists CrearLista;
CREATE PROCEDURE CrearLista(
    IN p_nombre varchar(50),
    IN p_username varchar(20)
)
BEGIN
    declare v_id_usuario integer;
    SELECT ID_NORMAL
    INTO v_id_usuario
    FROM Usuarios,
         Normales
    WHERE USERNAME = p_username
      AND ID_NORMAL = ID_USUARIO;

    INSERT INTO Listas (Nombre, li_ID_Normal)
    VALUES (p_nombre, v_id_usuario);
    COMMIT;
END;

CREATE PROCEDURE AgregarALista(
    IN p_nombre_anime ANIMES.NOMBRE%TYPE,
    IN p_username USUARIOS.USERNAME%TYPE,
    IN p_nombre_lista LISTAS.NOMBRE%TYPE
) AS
    v_id_lista LISTA_ANIME.ID_LISTA%TYPE;
v_id_anime LISTA_ANIME.LA_ID_ANIME%TYPE;
CURSOR c_datos IS
SELECT LISTAS.ID_LISTA, ID_ANIME
FROM LISTAS,
     ANIMES,
     USUARIOS
WHERE LISTAS.NOMBRE = p_nombre_lista
  AND USERNAME = p_username
  AND ID_USUARIO = LI_ID_NORMAL
  AND ANIMES.NOMBRE = p_nombre_anime;
BEGIN OPEN c_datos;
FETCH c_datos INTO v_id_lista, v_id_anime;

INSERT INTO LISTA_ANIME
VALUES (v_id_lista, v_id_anime);

CLOSE c_datos;
COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(':(');
DBMS_OUTPUT.PUT_LINE('Se ha producido un problema.');
END AgregarALista;
/

CREATE OR
REPLACE PROCEDURE UnirseAComunidad(
    p_username USUARIOS.USERNAME%TYPE,
    p_nombre_anime ANIMES.NOMBRE%TYPE
) AS
    v_idNormal    NORMALES.ID_NORMAL%TYPE;
v_idComunidad COMUNIDADES.ID_COMUNIDAD%TYPE;
CURSOR c_datos IS
SELECT ID_NORMAL, ID_COMUNIDAD
FROM USUARIOS,
     NORMALES,
     ANIMES,
     COMUNIDADES
WHERE USERNAME = p_username
  AND USUARIOS.ID_USUARIO = NORMALES.ID_NORMAL
  AND ANIMES.NOMBRE = p_nombre_anime
  AND ID_ANIME = CO_ID_ANIME;
BEGIN OPEN c_datos;
FETCH c_datos INTO v_idNormal, v_idComunidad;

INSERT INTO NORMAL_COMUNIDAD
VALUES (v_idComunidad, v_idNormal);

CLOSE c_datos;
COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Usuario o comunidad no encontrada.');
END UnirseAComunidad;
/

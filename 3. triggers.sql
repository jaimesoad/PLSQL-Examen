USE AnimeOddyssey;

CREATE TRIGGER VerificarEdad
    BEFORE INSERT OR UPDATE
    ON USUARIOS
    FOR EACH ROW
DECLARE
    v_edad number;
BEGIN
    v_edad := CALCULAREDAD(:new.FECHA_NAC);

    IF v_edad NOT BETWEEN 13 AND 100 THEN
        RAISE_APPLICATION_ERROR(20001, 'La edad ingresada está fuera de los límites.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER AgregarComunidad
    AFTER INSERT
    ON ANIMES
    FOR EACH ROW
BEGIN
    INSERT INTO COMUNIDADES
    VALUES (S_ID_COMUNIDAD.nextval, :new.ID_ANIME);
END;
/

CREATE OR REPLACE TRIGGER AuditoriaAnimes
    AFTER INSERT OR UPDATE OR DELETE
    ON ANIMES
    FOR EACH ROW
DECLARE
    v_operacion AUD_ANIME.operacion%TYPE;
BEGIN
    IF INSERTING THEN
        v_operacion := 'I';
    ELSIF UPDATING THEN
        v_operacion := 'U';
    ELSE
        v_operacion := 'D';
    END IF;

    INSERT INTO AUD_ANIME (AA_ID_ANIME, NOMBRE_ANIME, AA_AGREGADO_POR, OPERACION)
    VALUES (:new.ID_ANIME, :new.NOMBRE, :new.AÑADIDO_POR, v_operacion);
END;
/
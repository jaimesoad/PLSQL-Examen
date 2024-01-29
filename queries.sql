----Introducir datos----
INSERT INTO Usuarios (ID_Usuario, Nombre, Apellido, Fecha_Nac, Username, Correo, Contra)
VALUES(11, 'Pablo', 'Paladino', CONVERT(DATE, '20-05-1999', 105), 'ppablo', 'pablo.paladino@gmail.com', 12344321)

INSERT INTO Normales VALUES (11)


INSERT INTO Publicaciones (ID_Publicacion, ID_Comunidad, ID_Normal, Contenido, Fecha_Publicación)
    VALUES (7, 6, 11, 'El final me pareció una basura.', GETDATE())

----Consultas simples----

SELECT ID_Usuario,
       Nombre + ' ' + Apellido 'Nombre_Completo',
       CONVERT(INT, DATEDIFF(YEAR, Fecha_Nac, GETDATE())) 'Edad',
       Username
FROM Usuarios
WHERE CONVERT(INT, DATEDIFF(YEAR, Fecha_Nac, GETDATE())) >= 21

SELECT *
FROM Usuarios
WHERE Nombre like 'B%'

SELECT ID_Anime, Nombre, Creador, Cant_Ep, Tipo, Genero
FROM Animes
WHERE Cant_Ep <= 25
ORDER BY Nombre DESC

Select Username, Contra
	FROM Usuarios
		WHERE Username = 'Administrador'

--3. Select all usernames
--(VerNombresUsuarios)
SELECT Username
	FROM Usuarios

--4. Devolver Todo tabla usuario usando el username
--(VerInfoUsuario)
SELECT *
	FROM Usuarios
		WHERE ID_Usuario = 8

--5. solicitar ultimo id usuario
--(ObtenerIdUltimoUser)
SELECT TOP 1 ID_Usuario
	FROM Usuarios
		ORDER BY ID_Usuario DESC

--10. Segun, ID_Anime, devolver:
--	ID_Anime,
--	Portada,
--	fecha,
--	genero,
--	Creador,
--	Episodios,
--	Sinopsis
--(VerInfoAnime)
SELECT *
	FROM Animes
		WHERE ID_Anime = 4

--11. solicitar ultimo id anime
--(ObtenerIdUltimoAnime)
SELECT TOP 1 ID_Anime
	FROM Animes
		ORDER BY ID_Anime DESC



--19. Segun ID_Anime == ID_Comunidad, devolver:
--	Todas las publicaciones de su comunidad:
--		ID_Publicacion
--		Contenido
--		Usuario que comento
--		Fecha
--(VerPublicaciones)
SELECT ID_Publicacion, Contenido, ID_Normal, Fecha_Publicación
	FROM Publicaciones
	WHERE ID_Comunidad = 2

--20. solocitar Ultimo id publicacion
--(ObtenerIdUltimaPub)
SELECT TOP 1 ID_Publicacion
	FROM Publicaciones
		ORDER BY ID_Publicacion DESC

--24. Segun ID_Publicacion, devolver tods los comentarios:
--	ID_Comentario,
--	ID_Usuario,
--	Contenido,
--	Fecha
--(VerComentarios)
SELECT ID_Comentario, Contenido, ID_Normal, Fecha_Comentario
	FROM Comentarios
	WHERE ID_Publicacion = 2

--25. solicitar ultimo id comentario
--(ObtenerIdUltimoComen)
SELECT TOP 1 ID_Comentario
	FROM Comentarios
		ORDER BY ID_Comentario DESC

--28. Segun ID_Usuario, nombre lista
--(ObtenerIdLista)
SELECT ID_Lista
	FROM Listas
	WHERE ID_Normal = 5 AND Nombre = 'Por ver'

----Consultas multitablas----
SELECT t3.Nombre 'Nombre_Anime', t2.Username, t1.Contenido
FROM Publicaciones t1, Usuarios t2, Animes t3, Comunidades t4
WHERE t1.ID_Comunidad = t4.ID_Comunidad AND
       t1.ID_Normal = t2.ID_Usuario AND
       t3.ID_Anime = t4.ID_Anime
ORDER BY t2.Username

SELECT t3.Nombre 'Nombre_Anime', t2.Username, t1.Contenido
FROM Publicaciones t1 JOIN Usuarios t2
        ON t1.ID_Normal = t2.ID_Usuario
    JOIN Comunidades t4
        ON t1.ID_Comunidad = t4.ID_Comunidad
    JOIN Animes t3 ON
        t3.ID_Anime = t4.ID_Anime
ORDER BY t2.Username

SELECT t3.Username, t1.Nombre 'Nombre_Lista', COUNT(t2.ID_Anime) 'Cantidad_Animes'
FROM Listas t1, Lista_Anime t2, Usuarios t3
WHERE t1.ID_Normal = t3.ID_Usuario AND
      t1.ID_Lista = t2.ID_Lista
GROUP BY Username, t1.Nombre

SELECT t3.Username 'Usuario1', t4.Username 'Usuario2', t2.Nombre 'Nombre_Anime'
FROM Comparte t1, Listas t2, Usuarios t3, Usuarios t4
WHERE t1.ID_Usuario1 = t3.ID_Usuario AND
      t1.ID_Usuario2 = t4.ID_Usuario AND
      t1.ID_Lista = t2.ID_Lista

--15. Segun ID Lista, devolver ID anime y portada
--(VerLista)
SELECT AN.ID_Anime, An.Nombre
FROM Animes AS AN
LEFT OUTER JOIN Lista_Anime AS LA
ON An.ID_Anime = LA.ID_Anime
WHERE LA.ID_Lista = 3

--16. Segun ID_Usuario y ID_Anime, devolver:
--	username,
--	nombre lista
--(VerAnimeEnLista)


SELECT ID_Normal, Nombre
	FROM Listas
	WHERE ID_Lista = (
			SELECT ID_Lista
				FROM Lista_Anime
				WHERE ID_Anime = 6)
			AND ID_Normal = 7

----Actualizar datos----
SELECT *
FROM Publicaciones

UPDATE Usuarios
SET Correo = 'jaime.acosta3@utp.ac.pa'
WHERE Username = 'jaimesoad'

UPDATE Usuarios
SET Apellido = 'Del Cid'
WHERE ID_Usuario = 1

UPDATE Publicaciones
SET Contenido = 'El final me pareció bastante interesante.'
WHERE ID_Normal = 11

----Eliminar datos----

DELETE FROM Publicaciones
WHERE ID_Normal = 11

DELETE FROM Normales
WHERE ID_Normal = 11

DELETE FROM Usuarios
WHERE Username = 'ppablo'

SELECT *
FROM Usuarios
WHERE Username = 'ppablo'

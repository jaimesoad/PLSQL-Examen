--alter session set current_schema = PROYECTOFINAL;

BEGIN
	NuevoAdmin('Kylee', 'Cortez', to_date('25-10-1992', 'dd-MM-yyyy'), 'kyleecortez', 'Kylee.Cortez@gmail.com', '31981051');
	NuevoNormal('Angelina', 'Smith', to_date('29-8-1994', 'dd-MM-yyyy'), 'angelinasmith', 'Angelina.Smith@gmail.com', '34617924');
	NuevoNormal('Jonathan', 'Knight', to_date('20-2-1999', 'dd-MM-yyyy'), 'jonathanknight', 'Jonathan.Knight@gmail.com', '47987375');
	NuevoAdmin('Anton', 'Austin', to_date('15-8-1995', 'dd-MM-yyyy'), 'antonaustin', 'Anton.Austin@gmail.com', '78674168');
	NuevoAdmin('Kasen', 'Andrews', to_date('21-5-1975', 'dd-MM-yyyy'), 'kasenandrews', 'Kasen.Andrews@gmail.com', '86588757');
	NuevoNormal('Kaitlin', 'Barrera', to_date('27-4-1996', 'dd-MM-yyyy'), 'kaitlinbarrera', 'Kaitlin.Barrera@gmail.com', '46897775');
	NuevoAdmin('Camila', 'Herrera', to_date('6-1-2007', 'dd-MM-yyyy'), 'camilaherrera', 'Camila.Herrera@gmail.com', '16091516');
	NuevoAdmin('Noel', 'Mcbride', to_date('1-12-2000', 'dd-MM-yyyy'), 'noelmcbride', 'Noel.Mcbride@gmail.com', '79094820');
	NuevoAdmin('Maxim', 'Patel', to_date('30-3-1987', 'dd-MM-yyyy'), 'maximpatel', 'Maxim.Patel@gmail.com', '56925088');
	NuevoNormal('Lamar', 'Hutchinson', to_date('7-3-1974', 'dd-MM-yyyy'), 'lamarhutchinson', 'Lamar.Hutchinson@gmail.com', '82450247');
	NuevoNormal('Bryson', 'Floyd', to_date('15-6-1974', 'dd-MM-yyyy'), 'brysonfloyd', 'Bryson.Floyd@gmail.com', '82381192');
	NuevoNormal('Neil', 'Bush', to_date('15-7-2000', 'dd-MM-yyyy'), 'neilbush', 'Neil.Bush@gmail.com', '45004478');
	NuevoNormal('Isabel', 'Norton', to_date('15-4-1973', 'dd-MM-yyyy'), 'isabelnorton', 'Isabel.Norton@gmail.com', '76707538');
	NuevoNormal('Adonis', 'Gomez', to_date('6-8-1996', 'dd-MM-yyyy'), 'adonisgomez', 'Adonis.Gomez@gmail.com', '55196524');
	NuevoAdmin('Natasha', 'Baker', to_date('16-1-1992', 'dd-MM-yyyy'), 'natashabaker', 'Natasha.Baker@gmail.com', '64554158');
	NuevoNormal('Jayce', 'Lucero', to_date('23-11-1978', 'dd-MM-yyyy'), 'jaycelucero', 'Jayce.Lucero@gmail.com', '17753036');
	NuevoNormal('Emerson', 'Yu', to_date('5-11-1993', 'dd-MM-yyyy'), 'emersonyu', 'Emerson.Yu@gmail.com', '95649890');
	NuevoNormal('Madeleine', 'Cook', to_date('9-6-2006', 'dd-MM-yyyy'), 'madeleinecook', 'Madeleine.Cook@gmail.com', '45191949');
	NuevoNormal('Cullen', 'Flynn', to_date('4-4-1988', 'dd-MM-yyyy'), 'cullenflynn', 'Cullen.Flynn@gmail.com', '13357919');
	NuevoAdmin('Cristina', 'Levine', to_date('2-12-2008', 'dd-MM-yyyy'), 'cristinalevine', 'Cristina.Levine@gmail.com', '56436084');

	NuevoAnime('One Punch Man', 'ONE, Yusuke Murata', 'El mundo se ve invadido por extraños monstruos que aparecen misteriosamente y que causan numerosos desastres a la población. Saitama es un poderoso superhéroe calvo que derrota fácilmente a los monstruos u otros villanos con un único golpe de su puño.', 24, 2009, 'Manga', 'Shonen', 'maximpatel');
	NuevoAnime('One piece', 'Eiichiro Oda', ' ', 1038, 1999, 'Manga', 'Accion', 'cristinalevine');
	NuevoAnime('Pokémon', 'Satoshi Tajiri', 'La serie sigue las aventuras de un impetuoso y joven entrenador llamado Ash Ketchum, y de Pikachu, su compañero Pokémon, mientras viajan por el mundo Pokémon visitando destinos exóticos, conociendo a montones de personas y Pokémon nuevos e interesantes, y viviendo muchas y emocionantes aventuras.', 1219, 1997, 'Serie', 'Aventura', 'kyleecortez');
	NuevoAnime('Hunter x Hunter', 'Yoshihiro Togashi', 'Para alcanzar su sueño de convertirse en un cazador legendario como su padre, un joven debe pasar un riguroso examen y encontrar a su padre, que está desaparecido.', 148, 2011, 'Serie', 'Aventura', 'cristinalevine');
	NuevoAnime('Dragon Ball Z', 'Akira Toriyama', ' ', 291, 1989, 'Anime', 'Accion', 'natashabaker');

	UnirseAComunidad('brysonfloyd', 'One Punch Man');
	UnirseAComunidad('angelinasmith', 'One piece');
	UnirseAComunidad('emersonyu', 'One Punch Man');
	UnirseAComunidad('emersonyu', 'One piece');
	UnirseAComunidad('adonisgomez', 'Hunter x Hunter');

	CrearLista('Mis Favoritas', 'angelinasmith');
	CrearLista('Viendo', 'lamarhutchinson');
	CrearLista('Por ver', 'emersonyu');
	CrearLista('Vistas', 'emersonyu');

	AGREGARALISTA('One Punch Man', 'emersonyu', 'Vistas');
	AGREGARALISTA('Hunter x Hunter', 'lamarhutchinson', 'Viendo');
	AGREGARALISTA('Dragon Ball Z', 'emersonyu', 'Por ver');
	AGREGARALISTA('Pokémon', 'emersonyu', 'Vistas');
	AGREGARALISTA('One Punch Man', 'angelinasmith', 'Mis Favoritas');

    NUEVAPUBLICACION('One piece', 'neilbush', 'Este anime es demasiado largo, ya me estoy aburriendo.');
    NUEVAPUBLICACION('One Punch Man', 'jaycelucero', 'La última temporada fue gloriosa.');
    NUEVAPUBLICACION('Hunter x Hunter', 'adonisgomez', 'El final me hizo llorar.');
    NUEVAPUBLICACION('Dragon Ball Z', 'cullenflynn', 'Saben? La verdad es que nadie le ganaría a Gokú en ninguna pelea.');
    NUEVAPUBLICACION('One Punch Man', 'emersonyu', 'De verdad van a sacar una cuarta temporada?.');
END;
/

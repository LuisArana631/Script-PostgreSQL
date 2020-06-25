INSERT INTO PAIS (cod_pais, nombre) VALUES 
(1, 'Guatemala'),
(2, 'Francia'),
(3, 'Argentina'),
(4, 'Alemania'),
(5, 'Italia'),
(6, 'Brasil'),
(7, 'Estados Unidos');

INSERT INTO PROFESION (cod_prof, nombre) VALUES
(1, 'Médico'),
(2, 'Arquitecto'),
(3, 'Ingeniero'),
(4, 'Secretaria'),
(5, 'Auditor');

INSERT INTO MIEMBRO (cod_miembro, nombre, apellido , edad, telefono, residencia, pais_cod_pais, profesion_cod_prof) VALUES
(1, 'Scott', 'Mitchell', 32, null, '1092 Highland Drive Manitowoc, WI 54220', 7, 3),
(2, 'Fanette', 'Poulin', 25, 25075853, '49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY', 2, 4),
(3, 'Laura', 'Cunha Silva', 55, null, 'Rua Onze, 86 Uberaba-MG', 6, 5),
(4, 'Juan José', 'López', 38, 36985247, '26 calle 4-10 zona 11', 1, 2),
(5, 'Arcangel', 'Panicucci', 39, 391664921, 'Via Santa Teresa, 114 90010-Geraci Siculo PA', 5, 1),
(6, 'Jeuel', 'Villalpando', 31, null, 'Acuña de Figeroa 6106 80101 Playa Pascual', 3, 5);

INSERT INTO DISCIPLINA (cod_disciplina, nombre, descripcion) VALUES
(1, 'Atletismo', 'Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martilo, jabalina y disco.'),
(2, 'Bádminton', null),
(3, 'Ciclismo', null),
(4, 'Judo', 'Es un arte marcial que se originó en Japón alrededor de 1880'),
(5, 'Lucha', null),
(6, 'Tenis de Mesa', null),
(7, 'Boxeo', null),
(8, 'Natación', 'Está presente como deporte en los juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.'),
(9, 'Esgrima', null),
(10, 'Vela', null);

INSERT INTO TIPO_MEDALLA (cod_tipo, medalla) VALUES
(1, 'Oro'),
(2, 'Plata'),
(3, 'Bronce'),
(4, 'Platino');

INSERT INTO CATEGORIA (cod_categoria, categoria) VALUES
(1, 'Clasificatorio'),
(2, 'Eliminatorio'),
(3, 'Final');

INSERT INTO TIPO_PARTICIPACION (cod_participacion, tipo_participacion) VALUES
(1, 'Individuales'),
(2, 'Parejas'),
(3, 'Equipos');

INSERT INTO MEDALLERO (pais_cod_pais, tipo_medalla_cod_tipo, cantidad_medallas) VALUES
(5, 1, 3),
(2, 1, 5),
(6, 3, 4),
(4, 4, 3),
(7, 3, 10),
(3, 2, 8),
(1, 1, 2),
(1, 4, 5),
(5, 2, 7);

INSERT INTO EVENTO (cod_evento, fecha, ubicacion, hora, disciplina_cod_disciplina, tipo_participacion_cod_participacion, categoria_cod_categoria) VALUES
(1, '24/06/2020', 'Gimnasio Nacional Yoyogi', '11:00:00', 2, 2, 1),
(2, '26/06/2020', 'Gimnasio Metropolitano de Tokio', '10:30:00', 6, 1, 3),
(3, '30/06/2020', 'Estadio Olímpico', '18:45:00', 7, 1, 2),
(4, '01/08/2020', 'Jardín del Palacio Imperial de Tokio', '12:15:00', 1, 1, 1),
(5, '08/08/2020', 'Nippon Budokan', '19:35:00', 10, 3, 1);
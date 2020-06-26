--Generar el script que crea cada una de las tablas que conforman la base de
--datos propuesta por el Comité Olímpico.

CREATE TABLE PROFESION(
	cod_prof int NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT pk_profesion PRIMARY KEY(cod_prof),
	UNIQUE(nombre)
);

CREATE TABLE PAIS(
	cod_pais int NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT pk_pais PRIMARY KEY (cod_pais),
	UNIQUE(nombre)
);

CREATE TABLE PUESTO(
	cod_puesto int NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT pk_puesto PRIMARY KEY (cod_puesto),
	UNIQUE(nombre)
);

CREATE TABLE DEPARTAMENTO(
	cod_depto int NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT pk_departamento PRIMARY KEY(cod_depto),
	UNIQUE(nombre)
);

CREATE TABLE MIEMBRO(
	cod_miembro int NOT NULL,
	nombre varchar(100) NOT NULL,
	apellido varchar(100) NOT NULL,
	edad int NOT NULL,
	telefono int,
	residencia varchar(100),
	PAIS_cod_pais int NOT NULL,
	PROFESION_cod_prof int NOT NULL,
	CONSTRAINT pk_miembro PRIMARY KEY(cod_miembro)
);

ALTER TABLE MIEMBRO
ADD CONSTRAINT fk_PAIS_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais),
ADD CONSTRAINT fk_PROFESION_cod_prof FOREIGN KEY (PROFESION_cod_prof) REFERENCES PROFESION(cod_prof);

CREATE TABLE PUESTO_MIEMBRO(
	MIEMBRO_cod_miembro int NOT NULL,
	PUESTO_cod_puesto int NOT NULL,
	DEPARTAMENTO_cod_depto int NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date,
	CONSTRAINT pk_puesto_miembro PRIMARY KEY(MIEMBRO_cod_miembro, PUESTO_cod_puesto, DEPARTAMENTO_cod_depto)
);

ALTER TABLE PUESTO_MIEMBRO
ADD CONSTRAINT fk_MIEMBRO_cod_miembro FOREIGN KEY (MIEMBRO_cod_miembro) REFERENCES MIEMBRO(cod_miembro),
ADD CONSTRAINT fk_PUESTO_cod_puesto FOREIGN KEY (PUESTO_cod_puesto) REFERENCES PUESTO(cod_puesto),
ADD CONSTRAINT fk_DEPARTAMENTO_cod_depto FOREIGN KEY (DEPARTAMENTO_cod_depto) REFERENCES DEPARTAMENTO(cod_depto);

CREATE TABLE TIPO_MEDALLA(
	cod_tipo int NOT NULL,
	medalla varchar(20) NOT NULL,
	CONSTRAINT pk_tipo_medalla PRIMARY KEY (cod_tipo),
	UNIQUE(medalla)
);

CREATE TABLE MEDALLERO(
	PAIS_cod_pais int NOT NULL,
	cantidad_medallas int NOT NULL,
	TIPO_MEDALLA_cod_tipo int NOT NULL,
	CONSTRAINT pk_medallero PRIMARY KEY (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo)
);

ALTER TABLE MEDALLERO
ADD CONSTRAINT fk_PAIS_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais),
ADD CONSTRAINT fk_TIPO_MEDALLA_cod_tipo FOREIGN KEY (TIPO_MEDALLA_cod_tipo) REFERENCES TIPO_MEDALLA(cod_tipo) ON DELETE CASCADE;

CREATE TABLE DISCIPLINA(
	cod_disciplina int NOT NULL,
	nombre varchar(50) NOT NULL,
	descripcion varchar(150),
	CONSTRAINT pk_disciplina PRIMARY KEY (cod_disciplina)
);

CREATE TABLE ATLETA(
	cod_atleta int NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	edad int NOT NULL,
	participaciones varchar(100) NOT NULL,
	DISCIPLINA_cod_disciplina int NOT NULL,
	PAIS_cod_pais int NOT NULL,
	CONSTRAINT pk_atleta PRIMARY KEY (cod_atleta)
);

ALTER TABLE ATLETA
ADD CONSTRAINT fk_DISCIPLINA_cod_disciplina FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA(cod_disciplina),
ADD CONSTRAINT fk_PAIS_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais);

CREATE TABLE CATEGORIA(
	cod_categoria int NOT NULL,
	categoria varchar(50) NOT NULL,
	CONSTRAINT pk_categoria PRIMARY KEY (cod_categoria)
);

CREATE TABLE TIPO_PARTICIPACION(
	cod_participacion int NOT NULL,
	tipo_participacion varchar(100) NOT NULL,
	CONSTRAINT pk_tipo_participacion PRIMARY KEY (cod_participacion)
);

CREATE TABLE EVENTO(
	cod_evento int NOT NULL,
	fecha date NOT NULL,
	ubicacion varchar(50) NOT NULL,
	hora time NOT NULL,
	DISCIPLINA_cod_disciplina int NOT NULL,
	TIPO_PARTICIPACION_cod_participacion int NOT NULL,
	CATEGORIA_cod_categoria int NOT NULL,
	CONSTRAINT pk_evento PRIMARY KEY (cod_evento)
);

ALTER TABLE EVENTO
ADD CONSTRAINT fk_DISCIPLINA_cod_disciplina FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA(cod_disciplina) ON DELETE CASCADE,
ADD CONSTRAINT fk_TIPO_PARTICIPACION_cod_participacion FOREIGN KEY (TIPO_PARTICIPACION_cod_participacion) REFERENCES TIPO_PARTICIPACION(cod_participacion),
ADD CONSTRAINT fk_CATEGORIA_cod_categoria FOREIGN KEY (CATEGORIA_cod_categoria) REFERENCES CATEGORIA(cod_categoria);

CREATE TABLE EVENTO_ATLETA(
	ATLETA_cod_atleta int NOT NULL,
	EVENTO_cod_evento int NOT NULL,
	CONSTRAINT pk_evento_atleta PRIMARY KEY (ATLETA_cod_atleta, EVENTO_cod_evento)
);

ALTER TABLE EVENTO_ATLETA
ADD CONSTRAINT fk_ATLETA_cod_atleta FOREIGN KEY (ATLETA_cod_atleta) REFERENCES ATLETA(cod_atleta),
ADD CONSTRAINT fk_EVENTO_cod_evento FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO(cod_evento);

CREATE TABLE TELEVISORA(
	cod_televisora int NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT pk_televisora PRIMARY KEY (cod_televisora)
);

CREATE TABLE COSTO_EVENTO(
	EVENTO_cod_evento int NOT NULL,
	TELEVISORA_cod_televisora int NOT NULL,
	tarifa numeric NOT NULL,
	CONSTRAINT pk_costo_evento PRIMARY KEY (EVENTO_cod_evento, TELEVISORA_cod_televisora)
);

ALTER TABLE COSTO_EVENTO
ADD CONSTRAINT fk_EVENTO_cod_evento FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO(cod_evento),
ADD CONSTRAINT fk_TELEVISORA_cod_televisora FOREIGN KEY (TELEVISORA_cod_televisora) REFERENCES TELEVISORA(cod_televisora);

--En la tabla “Evento” se decidió que la fecha y hora se trabajaría en 
--una sola columna.

ALTER TABLE EVENTO 
DROP COLUMN fecha,
DROP COLUMN hora,
ADD COLUMN fechahora timestamp;

--Todos los eventos de las olimpiadas deben ser programados del 24 de julio
--de 2020 a partir de las 9:00:00 hasta el 09 de agosto de 2020 hasta las
--20:00:00.

ALTER TABLE EVENTO
ADD CONSTRAINT ck_fecha_evento CHECK (fechahora BETWEEN '2020/07/24 9:00:00' AND '2020/08/09 20:00:00');

--Se decidió que las ubicación de los eventos se registrarán previamente en
--una tabla y que en la tabla “Evento” sólo se almacenara la llave foránea
--según el código del registro de la ubicación, para esto debe realizar lo
--siguiente

CREATE TABLE SEDE(
	codigo int NOT NULL,
	sede varchar(50) NOT NULL,
	CONSTRAINT pk_sede PRIMARY KEY (codigo)
);

ALTER TABLE EVENTO
ALTER COLUMN ubicacion SET DATA TYPE int USING ubicacion::int,
ALTER COLUMN ubicacion SET NOT NULL,
ADD CONSTRAINT fk_SEDE_ubicacion FOREIGN KEY (ubicacion) REFERENCES SEDE(codigo);

--Se revisó la información de los miembros que se tienen actualmente y antes
--de que se ingresen a la base de datos el Comité desea que a los miembros
--que no tengan número telefónico se le ingrese el número por Default 0 al
--momento de ser cargados a la base de datos.

ALTER TABLE MIEMBRO
ALTER COLUMN telefono SET DEFAULT 0;

--Generar el script necesario para hacer la inserción de datos a las tablas
--requeridas.

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

INSERT INTO SEDE (codigo, sede) VALUES
(1, 'Gimnasio Metropolitano de Tokio'),
(2, 'Jardín del Palacio Imperial de Tokio'),
(3, 'Gimnasio Nacional Yoyogi'),
(4, 'Nippon Budokan'),
(5, 'Estadio Olímpico');

INSERT INTO EVENTO (cod_evento, fechahora, ubicacion, disciplina_cod_disciplina, tipo_participacion_cod_participacion, categoria_cod_categoria) VALUES
(1, '2020/07/24 11:00:00', 3, 2, 2, 1),
(2, '2020/07/26 10:30:00', 1, 6, 1, 3),
(3, '2020/07/30 18:45:00', 5, 7, 1, 2),
(4, '2020/08/01 12:15:00', 2, 1, 1, 1),
(5, '2020/08/08 19:35:00', 4, 10, 3, 1);

--Después de que se implementó el script el cuál creó todas las tablas de las
--bases de datos, el Comité Olímpico Internacional tomó la decisión de
--eliminar la restricción “UNIQUE” de las siguientes tablas

ALTER TABLE PAIS
DROP CONSTRAINT pais_nombre_key;

ALTER TABLE TIPO_MEDALLA
DROP CONSTRAINT tipo_medalla_medalla_key;

ALTER TABLE DEPARTAMENTO
DROP CONSTRAINT departamento_nombre_key;

--Después de un análisis más profundo se decidió que los Atletas pueden
--participar en varias disciplinas y no sólo en una como está reflejado
--actualmente en las tablas, por lo que se pide que realice lo siguiente

ALTER TABLE ATLETA
DROP CONSTRAINT fk_disciplina_cod_disciplina,
DROP COLUMN disciplina_cod_disciplina;

CREATE TABLE DISCIPLINA_ATLETA(
	cod_atleta int NOT NULL,
	cod_disciplina int NOT NULL,
	CONSTRAINT pk_disciplina_atleta PRIMARY KEY (cod_atleta, cod_disciplina)
);

ALTER TABLE DISCIPLINA_ATLETA
ADD CONSTRAINT fk_cod_atleta FOREIGN KEY (cod_atleta) REFERENCES ATLETA(cod_atleta),
ADD CONSTRAINT fk_cod_disciplina FOREIGN KEY (cod_disciplina) REFERENCES DISCIPLINA(cod_disciplina);

--En la tabla “Costo_Evento” se determinó que la columna “tarifa” no debe
--ser entero sino un decimal con 2 cifras de precisión.

ALTER TABLE COSTO_EVENTO
ALTER COLUMN tarifa SET DATA TYPE numeric(20, 2);

--Generar el Script que borre de la tabla “Tipo_Medalla”, el registro siguiente

DELETE FROM TIPO_MEDALLA WHERE cod_tipo = 4;

--La fecha de las olimpiadas está cerca y los preparativos siguen, pero de
--último momento se dieron problemas con las televisoras encargadas de
--transmitir los eventos, ya que no hay tiempo de solucionar los problemas
--que se dieron, se decidió no transmitir el evento a través de las televisoras
--por lo que el Comité Olímpico pide generar el script que elimine la tabla
--“TELEVISORAS” y “COSTO_EVENTO”.

DROP TABLE COSTO_EVENTO;
DROP TABLE TELEVISORA;

--El comité olímpico quiere replantear las disciplinas que van a llevarse a cabo,
--por lo cual pide generar el script que elimine todos los registros contenidos
--en la tabla “DISCIPLINA”

DELETE FROM DISCIPLINA;

--Los miembros que no tenían registrado su número de teléfono en sus
--perfiles fueron notificados, por lo que se acercaron a las instalaciones de
--Comité para actualizar sus datos.

UPDATE MIEMBRO SET telefono = 55464601 WHERE nombre = 'Laura' AND apellido = 'Cunha Silva';
UPDATE MIEMBRO SET telefono = 91514243 WHERE nombre = 'Jeuel' AND apellido = 'Villalpando';
UPDATE MIEMBRO SET telefono = 92068667 WHERE nombre = 'Scott' AND apellido = 'Mitchell';

--El Comité decidió que necesita la fotografía en la información de los atletas
--para su perfil, por lo que se debe agregar la columna “Fotografía” a la tabla
--Atleta, debido a que es un cambio de última hora este campo deberá ser
--opcional.

ALTER TABLE ATLETA ADD fotografia bytea NULL;

--Todos los atletas que se registren deben cumplir con ser menores a 25 años.
--De lo contrario no se debe poder registrar a un atleta en la base de datos.

ALTER TABLE ATLETA ADD CONSTRAINT ck_atleta_edad CHECK (edad < 25);

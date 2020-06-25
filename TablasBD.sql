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
ADD CONSTRAINT fk_PAIS_cod_pais 
FOREIGN KEY (PAIS_cod_pais)
REFERENCES PAIS(cod_pais);

ALTER TABLE MIEMBRO
ADD CONSTRAINT fk_PROFESION_cod_prof
FOREIGN KEY (PROFESION_cod_prof)
REFERENCES PROFESION(cod_prof);

CREATE TABLE PUESTO_MIEMBRO(
	MIEMBRO_cod_miembro int NOT NULL,
	PUESTO_cod_puesto int NOT NULL,
	DEPARTAMENTO_cod_depto int NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date,
	CONSTRAINT pk_puesto_miembro PRIMARY KEY(MIEMBRO_cod_miembro, PUESTO_cod_puesto, DEPARTAMENTO_cod_depto)
);

ALTER TABLE PUESTO_MIEMBRO
ADD CONSTRAINT fk_MIEMBRO_cod_miembro
FOREIGN KEY (MIEMBRO_cod_miembro)
REFERENCES MIEMBRO(cod_miembro);

ALTER TABLE PUESTO_MIEMBRO
ADD CONSTRAINT fk_PUESTO_cod_puesto
FOREIGN KEY (PUESTO_cod_puesto)
REFERENCES PUESTO(cod_puesto);

ALTER TABLE PUESTO_MIEMBRO
ADD CONSTRAINT fk_DEPARTAMENTO_cod_depto
FOREIGN KEY (DEPARTAMENTO_cod_depto)
REFERENCES DEPARTAMENTO(cod_depto);

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
ADD CONSTRAINT fk_PAIS_cod_pais
FOREIGN KEY (PAIS_cod_pais)
REFERENCES PAIS(cod_pais);

ALTER TABLE MEDALLERO
ADD CONSTRAINT fk_TIPO_MEDALLA_cod_tipo
FOREIGN KEY (TIPO_MEDALLA_cod_tipo)
REFERENCES TIPO_MEDALLA(cod_tipo);

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
ADD CONSTRAINT fk_DISCIPLINA_cod_disciplina
FOREIGN KEY (DISCIPLINA_cod_disciplina)
REFERENCES DISCIPLINA(cod_disciplina);

ALTER TABLE ATLETA
ADD CONSTRAINT fk_PAIS_cod_pais
FOREIGN KEY (PAIS_cod_pais)
REFERENCES PAIS(cod_pais);

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
ADD CONSTRAINT fk_DISCIPLINA_cod_disciplina 
FOREIGN KEY (DISCIPLINA_cod_disciplina)
REFERENCES DISCIPLINA(cod_disciplina);

ALTER TABLE EVENTO
ADD CONSTRAINT fk_TIPO_PARTICIPACION_cod_participacion
FOREIGN KEY (TIPO_PARTICIPACION_cod_participacion)
REFERENCES TIPO_PARTICIPACION(cod_participacion);

ALTER TABLE EVENTO
ADD CONSTRAINT fk_CATEGORIA_cod_categoria
FOREIGN KEY (CATEGORIA_cod_categoria)
REFERENCES CATEGORIA(cod_categoria);

CREATE TABLE EVENTO_ATLETA(
	ATLETA_cod_atleta int NOT NULL,
	EVENTO_cod_evento int NOT NULL,
	CONSTRAINT pk_evento_atleta PRIMARY KEY (ATLETA_cod_atleta, EVENTO_cod_evento)
);

ALTER TABLE EVENTO_ATLETA
ADD CONSTRAINT fk_ATLETA_cod_atleta
FOREIGN KEY (ATLETA_cod_atleta)
REFERENCES ATLETA(cod_atleta);

ALTER TABLE EVENTO_ATLETA
ADD CONSTRAINT fk_EVENTO_cod_evento
FOREIGN KEY (EVENTO_cod_evento)
REFERENCES EVENTO(cod_evento);

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
ADD CONSTRAINT fk_EVENTO_cod_evento 
FOREIGN KEY (EVENTO_cod_evento)
REFERENCES EVENTO(cod_evento);

ALTER TABLE COSTO_EVENTO
ADD CONSTRAINT fk_TELEVISORA_cod_televisora
FOREIGN KEY (TELEVISORA_cod_televisora)
REFERENCES TELEVISORA(cod_televisora);


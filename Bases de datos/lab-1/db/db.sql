use mysql_g9;


CREATE TABLE IF NOT EXISTS empleado(
  nombre_usuario varchar(10) not null,
  nombre varchar(10) not null,
  apellido  varchar(10) not null,
  email  varchar(30) not null,
  contrasenia  varchar(30) not null,
  PRIMARY KEY(nombre_usuario)
);

CREATE TABLE IF NOT EXISTS telefono_empleado(
  empleado varchar(10) not null,
  telefono int not null,
  PRIMARY KEY(empleado,telefono),
  FOREIGN KEY (empleado) REFERENCES empleado(nombre_usuario)
);

CREATE TABLE IF NOT EXISTS rol(
  rol_id int not null,
  nombre_rol varchar(20) not null,
  PRIMARY KEY(rol_id)
);

CREATE TABLE IF NOT EXISTS rol_empleado(
  empleado varchar(10) not null,
  rol int not null,
  PRIMARY KEY(empleado,rol),
  FOREIGN KEY (empleado) REFERENCES empleado(nombre_usuario),
  FOREIGN KEY (rol) REFERENCES rol(rol_id)
);


CREATE TABLE IF NOT EXISTS cliente(
  nombre_usuario varchar(10) not null,
  nombre varchar(10) not null,
  apellido  varchar(10) not null,
  email  varchar(30) not null,
  contrasenia  varchar(30) not null,
  telefono int not null,
  nacimiento date not null,
  sexo char not null,
  PRIMARY KEY(nombre_usuario)
);

CREATE TABLE IF NOT EXISTS plan(
  codigo int not null,
  nombre varchar(20) not null,
  monto    int not null,
  PRIMARY KEY(codigo)
);

CREATE TABLE IF NOT EXISTS cliente_suscripto(
  cliente varchar(10) not null,
  plan    int not null,
  fecha_sus date not null,
  PRIMARY KEY(cliente,plan),
  FOREIGN KEY (cliente) REFERENCES cliente(nombre_usuario),
  FOREIGN KEY (plan) REFERENCES plan(codigo)
);

CREATE TABLE IF NOT EXISTS contenido(
  id_contenido int not null,
  titulo varchar(20) not null,
  descripcion varchar(100) not null,
  productora varchar(20) not null,
  fecha_de_lanzamiento date not null,
  duracion int not null,
  calificacion float not null,
  PRIMARY KEY (id_contenido)
);

CREATE TABLE IF NOT EXISTS resenia(
  id_resenia int not null,
  fecha date not null,
  descripcion varchar(80) not null,
  calificacion  int not null,
  cliente varchar(10) not null,
  contenido int not null,
  PRIMARY KEY(id_resenia),
  FOREIGN KEY (cliente) REFERENCES cliente(nombre_usuario),
  FOREIGN KEY (contenido) REFERENCES contenido(id_contenido)
);

CREATE TABLE IF NOT EXISTS genero_contenido(
  genero varchar(10) not null,
  contenido_multimedia int not null,
  PRIMARY KEY(genero,contenido_multimedia),
  FOREIGN KEY (contenido_multimedia) REFERENCES contenido(id_contenido)
);

CREATE TABLE IF NOT EXISTS pelicula(
  pelicula_id int not null,
  PRIMARY KEY(pelicula_id),
  FOREIGN KEY (pelicula_id) REFERENCES contenido(id_contenido)
);

CREATE TABLE IF NOT EXISTS subtitulos(
  idioma varchar(10) not null,
  pelicula int not null,
  PRIMARY KEY(idioma, pelicula),
  FOREIGN KEY (pelicula) REFERENCES pelicula(pelicula_id)
);

CREATE TABLE IF NOT EXISTS episodios(
  episodios_id int not null,
  PRIMARY KEY(episodios_id),
  FOREIGN KEY(episodios_id) REFERENCES contenido(id_contenido)
);

CREATE TABLE IF NOT EXISTS programa_tv(
  id_programa int not null,
  cadena_de_tv varchar(10) not null,
  titulo varchar(20) not null,
  PRIMARY KEY(id_programa)
);

CREATE TABLE IF NOT EXISTS episodio_es_de(
  episodio int not null,
  programa_tv int not null,
  anio_temporada date not null,
  numero_temporada int not null,
  PRIMARY KEY(episodio, programa_tv),
  FOREIGN KEY (episodio) REFERENCES episodios(episodios_id),
  FOREIGN KEY (programa_tv) REFERENCES programa_tv(id_programa)
);


CREATE TABLE IF NOT EXISTS elenco(
  nombre varchar(10) not null,
  apellido varchar(10) not null,
  fecha_nacimiento date not null,
  id_elenco int not null,
  pagina_web varchar(80),
  sexo char,
  PRIMARY KEY(id_elenco)
);


CREATE TABLE IF NOT EXISTS participantes_en(
  id_elenco int not null,
  rol varchar(30) not null,
  contenido int not null,
  PRIMARY KEY(id_elenco, contenido),
  FOREIGN KEY(contenido) REFERENCES contenido(id_contenido)
);


CREATE TABLE IF NOT EXISTS reproducciones(
  reproducion_num int not null,
  fecha_reproduccion date not null,
  cliente varchar(10) not null,
  contenido_rep int not null,
  PRIMARY KEY(reproducion_num),
  FOREIGN KEY(cliente) REFERENCES cliente(nombre_usuario),
  FOREIGN KEY(contenido_rep) REFERENCES contenido(id_contenido)
);


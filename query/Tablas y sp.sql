use bddBandas;

/* Tabla de Roles */
CREATE TABLE tblRol (
    rol_id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nombre_rol VARCHAR(50) NOT NULL
);

SELECT * FROM tblRol;
INSERT INTO tblRol (nombre_rol) VALUES ('ADMINISTRADOR');
INSERT INTO tblRol (nombre_rol) VALUES ('NORMAL');
INSERT INTO tblRol (nombre_rol) VALUES ('BANDA');

/* Tabla de Usuarios*/
CREATE TABLE tblUsuario (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nombre_usuario VARCHAR(250) NOT NULL,
    email_usuario VARCHAR(250),
    telefono_usuario VARCHAR(15),
    contrasena_usuario VARCHAR(250) NOT NULL,
    estado_usuario VARCHAR(10) NOT NULL DEFAULT ('ACTIVO'),
    -- Campos específicos para bandas (pueden ser vaciuos si no es banda)
    nombre_banda VARCHAR(250) NULL,
    generos_banda TEXT NULL,
    slogan_banda TEXT NULL,
    numero_integrantes_banda INT NULL,
    -- Relación con el rol del usuario (USUARIO o BANDA)
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES tblRol(rol_id)
);

CREATE TABLE tblCancion(
	id_cancion INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	nombre_cancion VARCHAR(250) NOT NULL,
	descripcion_cancion TEXT NULL,
	autor_cancion TEXT NOT NULL,
	portada_cancion VARBINARY(MAX) NULL,
	archivo_cancion VARBINARY(MAX) NOT NULL,
	fk_id_usuario INT,
	FOREIGN KEY (fk_id_usuario) REFERENCES tblUsuario (id_usuario)
);
DROP TABLE tblConcierto;
CREATE TABLE tblConcierto (
    id_concierto INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nombre_concierto VARCHAR(250) NOT NULL,
    fecha_concierto DATE NOT NULL,
    hora_concierto VARCHAR(50) NOT NULL,
    lugar_concierto VARCHAR(250) NOT NULL,  
    precio_boleto DECIMAL(10, 2) NOT NULL,  
    cantidad_boleto INT NOT NULL,           
    descripcion_concierto TEXT NULL ,
	fk_id_usuario INT,
	FOREIGN KEY (fk_id_usuario) REFERENCES tblUsuario (id_usuario)
);
DROP TABLE tblCompraBoleto;
CREATE TABLE tblCompraBoleto(
    id_compra INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    fk_id_usuario INT NOT NULL, 
    fk_id_concierto INT NOT NULL,
    cantidad_boleto INT NOT NULL,
    fecha_compra DATE NOT NULL,
    estado_compra VARCHAR(50) NOT NULL,
    FOREIGN KEY (fk_id_concierto) REFERENCES tblConcierto(id_concierto),
	FOREIGN KEY (fk_id_usuario) REFERENCES tblUsuario (id_usuario)
);

/* Proceso almecnado para crear usuario */
CREATE PROCEDURE sp_crear_usuario_normal
@nombre VARCHAR(250),
@email VARCHAR(250),
@telefono VARCHAR(15),
@contrasena VARCHAR(250)
AS BEGIN INSERT INTO tblUsuario (nombre_usuario,email_usuario,telefono_usuario,contrasena_usuario,estado_usuario,rol_id)
VALUES(@nombre,@email,@telefono,@contrasena,'ACTIVO',2)end;

DROP PROCEDURE sp_crear_usuario_normal;
EXEC sp_crear_usuario_normal 
    @nombre = 'Alexander Soto', 
    @email = 'alexander@hotmail.com', 
    @telefono = '0999385175', 
    @contrasena = 'alex123', 



DROP procedure sp_crear_usuario_banda;
/* Proceso almacenado para crear solo bandas */
CREATE PROCEDURE sp_crear_usuario_banda
	@nombre VARCHAR(250),
    @nombre_banda VARCHAR(250),
    @email VARCHAR(250),
    @telefono VARCHAR(15),
    @contrasena VARCHAR(250),
    @estado VARCHAR(10),
    @generos_banda TEXT, 
    @slogan_banda TEXT,
    @numero_integrantes_banda INT
AS BEGIN INSERT INTO tblUsuario(nombre_usuario, email_usuario, telefono_usuario, contrasena_usuario, estado_usuario, rol_id, nombre_banda, 
generos_banda, slogan_banda, numero_integrantes_banda) 
values(@nombre,@email, @telefono, @contrasena, @estado, 3, @nombre_banda, @generos_banda, @slogan_banda, @numero_integrantes_banda)end;

EXEC sp_crear_usuario_banda
	@nombre = 'jess',
    @nombre_banda = 'Banda XYZ', 
    @email = 'contacto@bandaxyz.com', 
    @telefono = '0988776655', 
    @contrasena = 'bandapass', 
    @estado = 'ACTIVO', 
    @generos_banda = 'Rock, Indie', 
    @slogan_banda = '¡La música es nuestra vida!', 
    @numero_integrantes_banda = 4;

select * from tblUsuario;

/*Proceso Almacenado para el login */
CREATE PROCEDURE sp_login
@nombre_usuario VARCHAR(250),
@contrasena_usuario VARCHAR(250)
AS BEGIN SELECT id_usuario, nombre_usuario, rol_id 
FROM tblUsuario WHERE nombre_usuario = @nombre_usuario AND contrasena_usuario = @contrasena_usuario AND estado_usuario = 'ACTIVO';
END;

EXEC sp_login @nombre_usuario = 'Alexander Soto', @contrasena_usuario = 'alex123';

/* Proceso almacenado para ver Perfil */
CREATE PROCEDURE sp_ver_perfil
    @id_usuario INT
AS
BEGIN
    SELECT 
        nombre_usuario,
        email_usuario,
        telefono_usuario,
        estado_usuario,
        nombre_banda,
        generos_banda,
        slogan_banda,
        numero_integrantes_banda
    FROM tblUsuario
    WHERE id_usuario = @id_usuario;  -- Buscar por ID de usuario
END


/*Proceso almacenado para actualizar poerfil*/
CREATE PROCEDURE sp_actualizar_perfil
    @id_usuario INT,
    @nombre_usuario NVARCHAR(100),
    @email_usuario NVARCHAR(100),
    @telefono NVARCHAR(50),
    @estado_usuario NVARCHAR(50),
    @nombre_banda NVARCHAR(100) = NULL,
    @generos_banda NVARCHAR(100) = NULL,
    @slogan_banda NVARCHAR(100) = NULL,
    @numero_integrantes_banda INT
AS
BEGIN
    UPDATE tblUsuario
    SET 
        nombre_usuario = @nombre_usuario,
        email_usuario = @email_usuario,
        telefono_usuario = @telefono,
        estado_usuario = @estado_usuario,
        nombre_banda = @nombre_banda,
        generos_banda = @generos_banda,
        slogan_banda = @slogan_banda,
        numero_integrantes_banda = @numero_integrantes_banda
    WHERE id_usuario = @id_usuario;  -- Actualizar el usuario por ID
END

/* Proceso almcenado para crear canciones */
select * from tblCancion;
CREATE PROCEDURE sp_crear_cancion
@nombre varchar(250),
@descripcion text,
@autor text,
@portada VARBINARY(MAX),
@archivo VARBINARY(MAX),
@id_usuario int
as begin 
insert into tblCancion (nombre_cancion,descripcion_cancion,autor_cancion,portada_cancion,archivo_cancion,fk_id_usuario) 
values (@nombre,@descripcion,@autor,@portada,@archivo,@id_usuario) end;

EXEC sp_crear_cancion 
    @nombre = 'Canción de prueba',
    @descripcion = 'Descripción de prueba',
    @autor = 'Autor de prueba',
    @portada = 0x0,
    @archivo = 0x0,
    @id_usuario = 1;

/* Porceso almecnado para consultar las musicas */
DROP PROCEDURE sp_consultar_cancion;
CREATE PROCEDURE sp_consultar_cancion
AS BEGIN SET NOCOUNT ON;
SELECT id_cancion,
        nombre_cancion,
        descripcion_cancion,
        autor_cancion,
        portada_cancion,
        archivo_cancion,
        fk_id_usuario
FROM tblCancion
ORDER BY id_cancion DESC;
END

/* Proceso almcenado para crear concierto */
CREATE PROCEDURE sp_crear_concierto
    @nombre_concierto VARCHAR(250),
    @fecha_concierto DATE,
    @hora_concierto VARCHAR(50),
    @lugar_concierto VARCHAR(250),
    @precio_boleto DECIMAL(10, 2),
    @cantidad_boleto INT,
    @descripcion_concierto TEXT,
    @fk_id_usuario INT -- Este campo es el foráneo
AS
BEGIN
    INSERT INTO tblConcierto (nombre_concierto, fecha_concierto, hora_concierto, lugar_concierto, precio_boleto, cantidad_boleto, descripcion_concierto, fk_id_usuario)
    VALUES (@nombre_concierto, @fecha_concierto, @hora_concierto, @lugar_concierto, @precio_boleto, @cantidad_boleto, @descripcion_concierto, @fk_id_usuario);
END
SELECT * FROM tblConcierto;
/* Proceso almacenado para compra de boleto */
CREATE PROCEDURE sp_registrar_compra_boleto
    @id_usuario INT,
    @id_concierto INT,
    @cantidad_boleto INT,
    @estado_compra VARCHAR(50),
    @fecha_compra DATE
AS
BEGIN
    INSERT INTO tblCompraBoleto (fk_id_usuario, fk_id_concierto, cantidad_boleto, estado_compra, fecha_compra)
    VALUES (@id_usuario, @id_concierto, @cantidad_boleto, @estado_compra, @fecha_compra);
END
/* Proceso almacenado para obtener los conciertos  */
CREATE PROCEDURE sp_obtener_conciertos
AS
BEGIN
    SELECT id_concierto, nombre_concierto FROM tblConcierto;
END
select * from tblCompraBoleto;

/* Proceso almacenado para selecionar todo */
create procedure sp_descubrir_concierto
as begin select * from tblConcierto end;

create procedure sp_descubrir_cancion
as begin select * from tblCancion end;

-- sp_descubrir_concierto
CREATE PROCEDURE sp_descubrir_concierto
AS BEGIN
    SELECT nombre_concierto, fecha_concierto, hora_concierto, lugar_concierto, precio_boleto
    FROM tblConcierto
END


-- sp_descubrir_cancion
CREATE PROCEDURE sp_descubrir_cancion
AS
BEGIN
    SELECT nombre_cancion, autor_cancion, portada_cancion
    FROM tblCancion
END

use bddBandas;
select * from tblRol;
select * from tblUsuario;
-- Sintaxis general del Inner join: select columna1, columna2 , etc from tabla1 inner join tabla2 on tabla1.columna_relacionada = tabla2.solumna_relacionada

select nombre_rol from tblRol;
select nombre_usuario from tblUsuario where estado_usuario = 'ACTIVO';
select nombre_concierto, precio_boleto from tblConcierto where precio_boleto>100;

-- Encontrar cada usuario con su rol
select nombre_usuario, nombre_rol from tblUsuario 
inner join tblRol on tblRol.rol_id = tblUsuario.rol_id; 

-- Encuentro el nombre de concierto y el nombre de usuario que lo organizo
select nombre_usuario, nombre_concierto from tblUsuario 
inner join tblConcierto on tblConcierto.fk_id_usuario = tblUsuario.id_usuario;

-- 1. Grafico: Distriobucion de usuarios por estado activo o inactivo
select estado_usuario, count(*) as total_usuarios
from tblUsuario group by estado_usuario;

-- 2. Grafico: Numero de canciones hecha por usuario
select nombre_usuario, count(id_cancion) as total_canciones
from tblUsuario
left join tblCancion on tblUsuario.id_usuario = tblCancion.fk_id_usuario
GROUP BY tblUsuario.nombre_usuario having count(id_cancion)>0;

-- 3. Top 20 usuarios con mas conciertos generados 
select top 20 tu.nombre_usuario, count(tco.id_concierto) as total_conciertos
from tblusuario tu
inner join tblconcierto tco on tu.id_usuario = tco.fk_id_usuario
group by tu.nombre_usuario
order by total_conciertos desc;

-- 4. Top 5 de usuarios con mas canciones 
select top 5 nombre_usuario, count(id_cancion) as total_canciones
from tblUsuario
inner join tblCancion on tblUsuario.id_usuario = tblCancion.fk_id_usuario
group by nombre_usuario
order by total_canciones desc;

-- top 5 de conciertos con mas boletos vendidos 
select top 5 tco.nombre_concierto, sum(tcb.cantidad_boleto) as total_boletos_vendidos
from tblConcierto tco
inner join tblCompraBoleto tcb on tco.id_concierto = tcb.fk_id_concierto
group by tco.nombre_concierto
order by total_boletos_vendidos desc;

-- Top 10 de concierto con mas boletos generados
select top 10 tco.nombre_concierto, 
              tco.cantidad_boleto as boletos_disponibles
from tblConcierto tco
order by tco.cantidad_boleto desc;


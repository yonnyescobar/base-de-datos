create database proyectoGrados
go

use proyectoGrados

go

--creacion tabla proyecto
create table proyecto (
idProyecto int identity(1,1) primary key,
titulo varchar(50) not null,
codigoProyecto varchar(50) not null,
descripcion varchar(100)
)
go

--creacion tabla persona
create table persona (
idPersona int identity(1,1) primary key,
nombre varchar(50) not null,
direccion varchar(50),
edad int,
telefono int
)
go

--creacion tabla tipoProyecto
create table tipoProyecto (
idTipoProyecto int identity(1,1) primary key,
idProyecto int,
tipo varchar(50) not null,
descripcion varchar(100),
constraint CK_tipoProyecto_tipo CHECK (tipo IN ('Pasantia', 'Asesoria','Trabajo dirigido')),
FOREIGN KEY (idProyecto) REFERENCES proyecto(idProyecto)
)
go

--creacion tabla estadoProyecto
create table estadoProyecto (
idEstadoproyecto int identity(1,1) primary key,
idProyecto int,
estado varchar (50) not null,
descripcion varchar (100),
constraint CK_estadoProyecto_estado CHECK (estado IN ('En Estudio', 'En Desarrollo','Aprobado', 'Terminado', 'Rechazado')),
FOREIGN KEY (idProyecto) REFERENCES proyecto(idProyecto)
)
go

--creacion tabla estudiante
create table estudiante (
idEstudiante int identity(1,1) primary key,
idPersona int,
promedioAcumulado decimal,
codigo varchar(50) not null,
constraint CK_estudiante_promedioAcumulado check (promedioAcumulado >= 0 and promedioAcumulado <= 5),
FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
)
go

--creacion tabla asesor
create table asesor (
idAsesor int identity(1,1) primary  key,
idPersona int,
profesion varchar (50) not null,
FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
)
go

--creacion tabla informe
create table informe(
idInforme int identity(1,1) primary key,
idTipoProyecto int,
notaInforme decimal,
observacion varchar(100),
constraint CK_informe_notaInforme check (notaInforme >= 0 and notaInforme <= 5),
FOREIGN KEY (idTipoProyecto) REFERENCES tipoProyecto(idTipoProyecto)
)
go

--creacion tabla director
create table director (
idDirector int identity(1,1) primary key,
idPersona int,
idInforme int,
codigo varchar(50) not null,
profesion varchar (50) not null,
dependencia varchar (100) not null,
FOREIGN KEY (idPersona) REFERENCES persona(idPersona),
FOREIGN KEY (idInforme) REFERENCES informe(idInforme)
)
go

--creacion tabla jurado
create table jurado (
idJurado int identity(1,1) primary key,
idPersona int,
codigoJurado varchar(50) not null,
profesion varchar (50) not null,
dependencia varchar (100) not null,
FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
)
go

--creacion tabla actaCurricular
create table actaCurricular (
idActaCurricular int identity(1,1) primary key,
idProyecto int,
fecha datetime not null,
cambioDescripcion varchar(100),
FOREIGN KEY (idProyecto) REFERENCES proyecto(idProyecto)
)
go

--creacion tabla actaCurricularJurado
create table actaCurricularJurado(
idActaCurricularJurado int identity(1,1) primary key,
idJurado int,
idActaCurricular int,
fechaSustentacion datetime not null,
sitioSustentacion varchar(100),
FOREIGN KEY (idJurado) REFERENCES jurado(idJurado),
FOREIGN KEY (idActaCurricular) REFERENCES actaCurricular(idActaCurricular)
)
go

--creacion tabla tipoSolicitudProyecto
create table tipoSolicitudProyecto (
idTipoSolicitudProyecto int identity(1,1) primary key,
idEstudiante int,
fecha datetime not null,
motivo varchar(100),
FOREIGN KEY (idEstudiante) REFERENCES estudiante(idEstudiante),
)
go

--creacion tabla solicitudProyecto
create table solicitudProyecto(
idSolicitudProyecto int identity(1,1) primary key,
idTipoProyecto int,
descripcion varchar(100),
FOREIGN KEY (idTipoProyecto) REFERENCES tipoProyecto(idTipoProyecto),
)
go

--creación tabla sustentacionEstudiante
create table sustentacionEstudiante (
idSustentacionEstudiante int identity(1,1) primary key,
idEstudiante int,
idTipoProyecto int,
idJurado int,
notaDefinitiva decimal,
constraint CK_sustentacionEstudiante_notaDefinitiva check (notaDefinitiva >= 0 and notaDefinitiva <= 5),
FOREIGN KEY (idEstudiante) REFERENCES estudiante(idEstudiante),
FOREIGN KEY (idTipoProyecto) REFERENCES tipoProyecto(idTipoProyecto),
FOREIGN KEY (idJurado) REFERENCES jurado(idJurado),
)
go

--7. índices
--agrupados
/*
CREATE CLUSTERED INDEX IX_proyecto_idProyecto ON proyecto(idProyecto);
CREATE CLUSTERED INDEX IX_persona_idPersona ON persona(idPersona);
CREATE CLUSTERED INDEX IX_tipoProyecto_idTipoProyecto ON tipoProyecto(idTipoProyecto);
*/

--no agrupados
CREATE NONCLUSTERED INDEX IX_proyecto_titulo ON proyecto(titulo);
CREATE NONCLUSTERED INDEX IX_persona_nombre ON persona(nombre);
CREATE NONCLUSTERED INDEX IX_tipoProyecto_tipo ON tipoProyecto(tipo);

--columnares
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_proyecto_columnar ON proyecto(idProyecto, titulo, codigoProyecto, descripcion);
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_persona_columnar ON persona(idPersona, nombre, direccion, edad, telefono);
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_tipoProyecto_columnar ON tipoProyecto(idTipoProyecto, idProyecto, tipo, descripcion);

--8. insertar datos tabla proyecto
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Sistema de proyectos', 'SP001', 'Desarrollo de un sistema para gestionar proyectos');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Plataforma Parque i', 'PI002', 'Desarrollo de una plataforma para el parque i');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Aplicación Móvil', 'AM003', 'Desarrollo de una aplicación para el celular');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Sistema de Inventarios', 'SI004', 'Desarrollo de un sistema de inventarios');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Plataforma de Reservas', 'PR005', 'Desarrollo de una plataforma reservas');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Aplicación de red social', 'ARS006', 'Desarrollo de una aplicación para redes');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Sistema de Ventas', 'SV007', 'Desarrollo de un sistema para gestionar ventas');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Plataforma de hoteles', 'PH008', 'Desarrollo de una plataforma para hoteles');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Aplicación de realidad virtual', 'ARV009', 'Desarrollo de una aplicación que utiliza');
INSERT INTO proyecto (titulo, codigoProyecto, descripcion)VALUES
('Control automatizado', 'CA010', 'Desarrollo de un sistema para controlar maquinas');

--insertar datos tabla persona
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Ana Gómez', 'Calle 45', 22, 4535543);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('José Rodríguez', 'Avenida LAU', 78, 4545678);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('María García', 'Calle 80', 35, 453654321);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Carlos Martínez', 'Avenida SUR', 29, 545387654);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Laura Fernández', 'Calle 74A', 27, 836434567);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Daniel López', 'Avenida NORTE', 31, 78865432);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Elena Pérez', 'Calle 78', 26, 875632109);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Miguel Sánchez', 'Avenida 75', 33, 5580987);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Sofía Torres', 'Calle 50', 30, 9676543);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Javier Ruiz', 'Avenida colombia', 28, 48367876);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Luisa Morales', 'Carrera 32', 24, 311223344);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Martín Vargas', 'Calle 23', 40, 322334455);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Paola Ríos', 'Avenida Principal', 29, 333445566);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Roberto López', 'Calle 60', 35, 344556677);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Natalia Soto', 'Avenida Central', 28, 355667788);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Juan Carlos Pérez', 'Calle 85', 32, 366778899);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Valeria Jiménez', 'Avenida del Sol', 27, 377889900);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Diego Gutiérrez', 'Calle 55', 26, 388990011);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Mariana Herrera', 'Avenida 60', 31, 399001122);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Pedro Castro', 'Carrera 45', 34, 400112233);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Carmen Sánchez', 'Calle 70', 29, 411223344);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Alejandro Ramírez', 'Avenida Occidente', 33, 422334455);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Isabel Mendoza', 'Calle 65', 28, 433445566);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Raúl Guzmán', 'Avenida del Este', 31, 444556677);
INSERT INTO persona (nombre, direccion, edad, telefono) VALUES
('Ana María Castro', 'Calle 88', 27, 455667788);

--insertar datos tabla tipo proyecto
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(1, 'Pasantia', 'Proyecto de tipo pasantía para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(2, 'Asesoria', 'Proyecto de asesoría para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(3, 'Trabajo dirigido', 'Proyecto de trabajo para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(4, 'Pasantia', 'Proyecto de tipo pasantía para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(5, 'Asesoria', 'Proyecto de asesoría para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(6, 'Trabajo dirigido', 'Proyecto de trabajo para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(7, 'Pasantia', 'Proyecto de tipo pasantía para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(8, 'Asesoria', 'Proyecto de asesoría para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(9, 'Trabajo dirigido', 'Proyecto de trabajo para estudiantes');
INSERT INTO tipoProyecto (idProyecto, tipo, descripcion)VALUES
(10, 'Pasantia', 'Proyecto de tipo pasantía para estudiantes');

--insertar datos tabla estado proyecto
INSERT INTO estadoProyecto (idProyecto, estado, descripcion)VALUES
(1, 'En Estudio', 'Proyecto a ser analizado');
INSERT INTO estadoProyecto (idProyecto, estado, descripcion)VALUES
(2, 'En Desarrollo', 'Proyecto iniciado');
INSERT INTO estadoProyecto (idProyecto, estado, descripcion)VALUES
(3, 'Aprobado', 'Proyecto aprobado');
INSERT INTO estadoProyecto (idProyecto, estado, descripcion) VALUES
(4, 'Terminado', 'Proyecto completado');
INSERT INTO estadoProyecto (idProyecto, estado, descripcion) VALUES
(5, 'Rechazado', 'Proyecto rechazado');

--insertar datos tabla estudiante
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(1, 4.2, 'es001');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(2, 3.8, 'es002');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(3, 4.5, 'es003');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(4, 4.0, 'es004');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(5, 3.7, 'es005');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(21, 3.8, 'es006');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(22, 4.7, 'es007');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(23, 2.7, 'es008');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(24, 1.7, 'es009');
INSERT INTO estudiante (idPersona, promedioAcumulado, codigo)VALUES
(25, 1.7, 'es010');

--insertar datos tabla asesor
INSERT INTO asesor (idPersona, profesion)VALUES
(6, 'Ingeniero Electronico');
INSERT INTO asesor (idPersona, profesion)VALUES
(7, 'Arquitecto ');
INSERT INTO asesor (idPersona, profesion)VALUES
(8, 'Diseñador Grafico');
INSERT INTO asesor (idPersona, profesion)VALUES
(9, 'Ingeniero Biomédico');
INSERT INTO asesor (idPersona, profesion)VALUES
(10, 'Consultor Empresarial');

--insertar datos tabla informe
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(1, 4.5, 'Informe detallado y bien estructurado');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(2, 3.8, 'Buen análisis y recomendaciones claras');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(3, 4.2, 'Trabajo dirigido con evidencia de investigación');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(1, 3.9, 'Buen avance en la pasantía');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(2, 4.7, 'Excelente, resultados destacados');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(3, 1.1, 'Trabajo dirigido en la innovación');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(1, 3.5, 'Informe preliminar, necesita más detalle');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(2, 4.0, 'Buen trabajo en la asesoría, pero algunos puntos pueden mejorarse');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(3, 4.4, 'Trabajo con potencial');
INSERT INTO informe (idTipoProyecto, notaInforme, observacion)VALUES
(1, 3.6, 'Avances grandes se recomienda mejorar la presentacion');

--insertar datos tabla director
INSERT INTO director (idPersona, idInforme, codigo, profesion, dependencia)VALUES
(11, 1, 'D01', 'Director de Proyecto', 'Facultad de Ciencias Exactas y Aplicadas');
INSERT INTO director (idPersona, idInforme, codigo, profesion, dependencia)VALUES
(12, 2, 'D02', 'Director Técnico', 'Facultad de Ciencias Ecnómicas y Administrativas');
INSERT INTO director (idPersona, idInforme, codigo, profesion, dependencia)VALUES
(13, 3, 'D03', 'Director de Innovación', 'Facultad de Artes y Humanidades');
INSERT INTO director (idPersona, idInforme, codigo, profesion, dependencia)VALUES
(14, 4, 'D04', 'Director de Desarrollo', 'Facultad de Ingenierías');
INSERT INTO director (idPersona, idInforme, codigo, profesion, dependencia)VALUES
(15, 5, 'D05', 'Director de Calidad', 'Facultad de Ingenierías');

--insertar datos tabla jurado
INSERT INTO jurado (idPersona, codigoJurado,  profesion, dependencia) VALUES
(16, 'J1', 'Ingeniero de Sistemas', 'Facultad de Ingenierías');
INSERT INTO jurado (idPersona, codigoJurado,  profesion, dependencia) VALUES
(17, 'J2', 'Administrador de Empresas', 'Facultad de Ciencias Ecnómicas y Administrativas');
INSERT INTO jurado (idPersona, codigoJurado,  profesion, dependencia) VALUES
(18, 'J3', 'Contador Público', 'Facultad de Ciencias Ecnómicas y Administrativas');
INSERT INTO jurado (idPersona, codigoJurado,  profesion, dependencia) VALUES
(19, 'J4', 'Ingeniero Biomédico', 'Facultad de Ciencias Exactas y Aplicadas');
INSERT INTO jurado (idPersona, codigoJurado,  profesion, dependencia) VALUES
(20, 'J5', 'Productor Cinematográfico', 'Facultad de Artes y Humanidades');

--insertar datos tabla acta curricular
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(1, '2023-01-15 12:30:45', 'Cambio en la metodología de desarrollo');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(2, '2023-02-20 22:00:45', 'Actualización de tecnologías utilizadas');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(3, '2023-03-25 17:59:00', 'Incorporación de nuevos módulos al sistema');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(4, '2023-04-30 14:30:10', 'Mejora en la interfaz de usuario');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(5, '2023-05-15 08:15:25', 'Optimización de procesos internos');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(6, '2023-06-20 21:05:55', 'funcionalidades adicionales');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(7, '2023-07-25 18:30:00', 'Actualización de la base de datos');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(8, '2023-08-30 13:49:07', 'Ajustes conforme a recomendaciones del informe');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(9, '2023-09-15 15:23:01', 'Mejora en la seguridad del sistema');
INSERT INTO actaCurricular (idProyecto, fecha, cambioDescripcion) VALUES
(10, '2023-10-20 16:10:45', 'Optimización de rendimiento');

--insertar datos tabla acta curricular jurado
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(1, 1, '2023-01-25 09:35:45', 'Salón 101');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(2, 2, '2023-02-28 10:42:56', 'Salón 102');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(3, 3, '2023-04-05 14:19:15', 'Salón 103');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(4, 4, '2023-05-10 17:37:45', 'Salón 104');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(5, 5, '2023-06-25 17:53:02', 'Salón 105');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(1, 6, '2023-08-01 18:00:45', 'Salón 106');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(2, 7, '2023-09-05 14:15:23', 'Salón 107');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(3, 8, '2023-10-10 14:59:59', 'Salón 108');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(4, 9, '2023-11-15 15:10:38', 'Salón 109');
INSERT INTO actaCurricularJurado (idJurado, idActaCurricular, fechaSustentacion, sitioSustentacion) VALUES
(5, 10, '2023-12-20 15:48:45', 'Salón 110');

--insertar datos tabla tipo solicitud proyecto
INSERT INTO tipoSolicitudProyecto (idEstudiante, fecha, motivo) VALUES
(1, '2023-01-01 17:59:00', 'Solicitud de cambio en el tipo de proyecto');
INSERT INTO tipoSolicitudProyecto (idEstudiante, fecha, motivo) VALUES
(2, '2023-02-05 07:30:00', 'Solicitud de extensión de plazo');
INSERT INTO tipoSolicitudProyecto (idEstudiante, fecha, motivo) VALUES
(3, '2023-03-10 08:46:45', 'Solicitud de cambio en el tema del proyecto');
INSERT INTO tipoSolicitudProyecto (idEstudiante, fecha, motivo) VALUES
(4, '2023-04-15 09:17:36', 'Solicitud de cambio en el tipo de proyecto');
INSERT INTO tipoSolicitudProyecto (idEstudiante, fecha, motivo) VALUES
(5, '2023-05-20 11:29:05', 'Solicitud de extensión de plazo');

--insertar datos tabla solicitud proyecto
INSERT INTO solicitudProyecto (idTipoProyecto, descripcion) VALUES
(1, 'Solicitud 1 ');
INSERT INTO solicitudProyecto (idTipoProyecto, descripcion) VALUES
(2, 'Solicitud 2 ');
INSERT INTO solicitudProyecto (idTipoProyecto, descripcion) VALUES
(3, 'Solicitud 3 ');

--insertar datos tabla sustentacion estudiante
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(1, 1, 1, 4.5);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(2, 2, 2, 3.8);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(3, 3, 3, 4.2);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(4, 1, 4, 3.5);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(5, 2, 5, 4.8);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(6, 3, 1, 3.9);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(7, 1, 2, 4.0);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(8, 2, 3, 4.6);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(9, 3, 4, 3.7);
INSERT INTO sustentacionEstudiante (idEstudiante, idTipoProyecto, idJurado, notaDefinitiva) VALUES
(10, 1, 5, 4.4);
go

--9. update
update asesor set profesion = 'Ingeniero Industrial' where idPersona = 10
go 

update persona set edad = 37 where idPersona = 22
go 

--delete
delete from estadoProyecto where estado = 'Rechazado'
go 

delete from asesor where idAsesor = 5
go 

--truncate
truncate table asesor
go 

truncate table estadoProyecto
go 

--10. select usando clausulas, sentencias y operadores lógicos
--proyectos iniciados
select
p.nombre as Estudiante,
tp.tipo as TipoProyecto,
pr.titulo as Proyecto,
ep.estado as Estado

from persona as p
right join estudiante as e on e.idPersona = p.idPersona
right join sustentacionEstudiante as se on se.idEstudiante = e.idEstudiante
right join  tipoProyecto as tp on tp.idTipoProyecto = se.idTipoProyecto
right join proyecto as pr on pr.idProyecto = tp.idProyecto
right join estadoProyecto as ep on ep.idProyecto = pr.idProyecto

where 
tp.idProyecto is not null 
and ep.estado != 'Aprobado'
order by p.nombre asc

--proyectos con acta curricular por rango de fecha
select 
pr.titulo as Proyecto,
tp.tipo as Tipo,
ac.idActaCurricular as Acta,
ac.fecha as FechaActa

from proyecto as pr
left join tipoProyecto as tp on tp.idProyecto = pr.idProyecto
left join actaCurricular as ac on ac.idProyecto = pr.idProyecto

where 
ac.fecha between '2023-01-01' and '2023-06-30'
and ac.idActaCurricular is not null
order by ac.fecha asc

--proyectos relacionados a sistemas
select 
pr.titulo as Proyecto,
pr.descripcion as Descripción

from proyecto as pr

where 
pr.titulo like '%Sistema%'

--11. select usando funciones
--conteo de estudiantes por edad
select 
count(p.idPersona) as CantidadEstudiantes,
p.edad as Edad

from persona as p
right join estudiante as e on e.idPersona = p.idPersona

group by p.edad
order by count(p.idPersona) desc

--antigüedad acta curricular
select 
pr.titulo as Proyecto,
tp.tipo as Tipo,
ac.idActaCurricular as Acta,
ac.fecha as FechaActa,
convert(varchar,(datediff(month,ac.fecha,getdate()))) + ' meses' as AntiguedadActa

from proyecto as pr
left join tipoProyecto as tp on tp.idProyecto = pr.idProyecto
left join actaCurricular as ac on ac.idProyecto = pr.idProyecto

where 
ac.idActaCurricular is not null
order by ac.fecha asc

--promedio de edad de estudiantes
select 
convert(varchar,(sum(p.edad)/count(p.edad))) + ' años' as PromedioEdadEstudiantes

from persona as p
right join estudiante as e on e.idPersona = p.idPersona
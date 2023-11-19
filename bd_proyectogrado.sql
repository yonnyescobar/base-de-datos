create database proyectoGrados
go

use proyectoGrados

go

--creacion tabla proyecto
create table proyecto (
idProyecto int identity(1,1) primary key,
titulo varchar(50) not null,
codigoProyecto varchar(50),
descripcion varchar(100)
)
go

--creacion tabla persona
create table persona (
idPersona int identity(1,1) primary key,
nombre varchar(50),
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
estado varchar (50),
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
codigo varchar(50),
constraint CK_estudiante_promedioAcumulado check (promedioAcumulado >= 0 and promedioAcumulado <= 5),
FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
)
go

--creacion tabla asesor
create table asesor (
idAsesor int identity(1,1) primary  key,
idPersona int,
profesion varchar (50)
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
codigo varchar(50),
profesion varchar (50),
dependencia varchar (100),
FOREIGN KEY (idPersona) REFERENCES persona(idPersona),
FOREIGN KEY (idInforme) REFERENCES informe(idInforme)
)
go

--creacion tabla jurado
create table jurado (
idJurado int identity(1,1) primary key,
idPersona int,
codigoJurado varchar(50),
profesion varchar (50),
dependencia varchar (100),
FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
)
go

--creacion tabla actaCurricular
create table actaCurricular (
idActaCurricular int identity(1,1) primary key,
idProyecto int,
fecha datetime,
cambioDescripcion varchar(100),
FOREIGN KEY (idProyecto) REFERENCES proyecto(idProyecto)
)
go

--creacion tabla actaCurricularJurado
create table actaCurricularJurado(
idActaCurricularJurado int identity(1,1) primary key,
idJurado int,
idActaCurricular int,
fechaSustentacion datetime,
sitioSustentacion varchar(100),
FOREIGN KEY (idJurado) REFERENCES jurado(idJurado),
FOREIGN KEY (idActaCurricular) REFERENCES actaCurricular(idActaCurricular)
)
go

--creacion tabla tipoSolicitudProyecto
create table tipoSolicitudProyecto (
idTipoSolicitudProyecto int identity(1,1) primary key,
idEstudiante int,
fecha datetime,
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
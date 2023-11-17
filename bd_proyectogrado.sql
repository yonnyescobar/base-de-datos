create database proyectoGrados
go

use proyectoGrados

go

--creacion tabla proyecto
create table proyecto (
idProyecto int identity(1,1) primary key,
titulo varchar(50) not null,
codigoProyecto varchar(50),
descripcion varchar(50)
)
go

--creacion tabla persona
create table persona (
idPersona int primary key,
nombre varchar(50),
direccion varchar(50),
edad int,
telefono int
)
go

--creacion tabla tipoProyecto
create table tipoProyecto (
idTipoProyecto int  primary key,
idProyecto int,
tipo varchar(50) not null,
descripcion varchar(50),
constraint CK_tipoProyecto_tipo CHECK (tipo IN ('Pasant�a', 'Asesor�a','Trabajo dirigido')),
FOREIGN KEY (idProyecto) REFERENCES proyecto(idProyecto)
)
go

--creacion tabla estadoProyecto
create table estadoProyecto (
idEstadoproyecto int primary key,
idProyecto int,
estado varchar (50),
descripcion varchar (50),
FOREIGN KEY (idProyecto) REFERENCES proyecto(idProyecto)
)
go

--creacion tabla estudiante
create table estudiante (
idEstudiante int primary key,
idPersona int,
promedioAcumulado decimal,
codigo varchar(50),
constraint CK_estudiante_promedioAcumulado check (promedioAcumulado >= 0 and promedioAcumulado <= 5),
FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
)
go

--creacion tabla persona
create table asesor (
idAsesor int primary key,
idPersona int,
profesion varchar (50)
FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
)
go

--creacion tabla informe
create table informe(
idInforme int primary key,
idTipoProyecto int,
notaInforme decimal,
observacion varchar(50),
constraint CK_informe_notaInforme check (notaInforme >= 0 and notaInforme <= 5),
FOREIGN KEY (idTipoProyecto) REFERENCES tipoProyecto(idTipoProyecto)
)
go

--creacion tabla director
create table director (
idDirector int primary key,
idPersona int,
idInforme int,
profesion varchar (50),
descripcion varchar (50),
FOREIGN KEY (idPersona) REFERENCES persona(idPersona),
FOREIGN KEY (idInforme) REFERENCES informe(idInforme)
)
go

--creacion tabla jurado
create table jurado (
idJurado int primary key,
idPersona int,
codigoJurado varchar(50),
FOREIGN KEY (idPersona) REFERENCES persona(idPersona)
)
go

--creacion tabla actaCurricular
create table actaCurricular (
idActaCurricular int primary key,
idProyecto int,
fecha date,
cambioDescripcion varchar(50),
estado varchar(50)
FOREIGN KEY (idProyecto) REFERENCES proyecto(idProyecto)
)
go

--creacion tabla actaCurricularJurado
create table actaCurricularJurado(
idActaCurricularJurado int primary key,
idJurado int,
idActaCurricular int,
fechaSustentacion date,
sitioSustentacion varchar(50),
FOREIGN KEY (idJurado) REFERENCES jurado(idJurado),
FOREIGN KEY (idActaCurricular) REFERENCES actaCurricular(idActaCurricular)
)
go

--creacion tabla tipoSolicitudProyecto
create table tipoSolicitudProyecto (
idTipoSolicitudProyecto int primary key,
idEstudiante int,
fecha date,
motivo varchar(50),
FOREIGN KEY (idEstudiante) REFERENCES estudiante(idEstudiante),
)
go

--creacion tabla solicitudProyecto
create table solicitudProyecto(
idSolicitudProyecto int primary key,
idTipoProyecto int,
descripcion varchar(50),
FOREIGN KEY (idTipoProyecto) REFERENCES tipoProyecto(idTipoProyecto),
)
go
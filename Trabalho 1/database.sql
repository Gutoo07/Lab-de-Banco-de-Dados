create database LabBD
go
use LabBD
--================================================
go
create table especialidade(
	id			int		not null,
	nome	varchar(30)	not null
	primary key (id)
)
go
create table material(
	id			int			not null,
	nome	varchar(30)		not null,
	valor	decimal(7,2)	not null
	primary key(id)
)
go
create table cliente(
	rg			char(9)			not null,
	nome		varchar(100)	not null,
	telefone	varchar(11)		not null,
	dt_nasc		date			not null,
	senha		varchar(35)		not null
	primary key(rg)
)
go
create table medico(
	rg				char(9)			not null,
	nome			varchar(100)	not null,
	telefone		varchar(11)		not null,
	periodo			varchar(5)		not null,
	valor_consulta	decimal(7,2)	not null,
	especialidade	int				not null
	primary key(rg)
	foreign key(especialidade) references especialidade(id)
)
go
create table consulta(
	id				int				not null,
	clienteRg			char(9)		not null,
	medicoRg			char(9)		not null,
	dia					date		not null,
	hora				time		not null,
	particular			bit			not null,
	cod_autorizacao	varchar(5)		null
	primary key(id)
	foreign key(clienteRg) references cliente(rg),
	foreign key(medicoRg) references medico(rg)
)
go
create table consulta_material(
	consultaId		int		not null,
	materialId		int		not null,
	qtd				int		not null
	primary key(consultaId, materialId)
	foreign key(consultaId) references consulta(id),
	foreign key(materialId) references material(id)
)
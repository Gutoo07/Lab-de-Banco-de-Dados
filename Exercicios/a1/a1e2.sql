create database a1e2
go
use a1e2
--------------------------
go
create table carro(
	placa		char(7)		not null,
	marca		varchar(70)	not null,
	modelo		varchar(70)	not null,
	ano			int			not null	check(ano>=0),
	cor			varchar(30)	not null
	primary key(placa)
)

create database a2e2
go
use a2e2
-------------------------------------
go
create table motorista(
	codigo			int			not null,
	nome			varchar(40)	not null,
	naturalidade	varchar(40)	not null
	primary key(codigo)
)
go
create table onibus(
	placa		char(7)			not null,
	marca	varchar(15)			not null,
	ano			int				not null,
	descricao	varchar(20)		not null
	primary key(placa)
)
go
create table viagem(
	codigo			int			not null,
	onibus			char(7)		not null,
	motorista		int			not null,
	hora_saida		int			not null,
	hora_chegada	int			not null,
	partida		varchar(40)		not null,
	destino		varchar(40)		not null
	primary key (codigo)
	foreign key(onibus) references onibus(placa),
	foreign key(motorista) references motorista(codigo)
)
------------------------------------------------------------
-- 1) Criar um Union das tabelas Motorista e ônibus,
--com as colunas ID (Código e Placa) e Nome (Nome e Marca)

select cast(m.codigo as varchar(7)) as ID, m.nome as Nome
from motorista m
UNION
select cast(o.placa as varchar(7))as ID, o.marca as Nome
from onibus o

--2) Criar uma View (Chamada v_motorista_onibus) do Union acima

create view v_motoristaOnibus
as
select cast(m.codigo as varchar(7)) as ID, m.nome as Nome
from motorista m
UNION
select cast(o.placa as varchar(7))as ID, o.marca as Nome
from onibus o

select * from v_motoristaOnibus

-- 3) Criar uma View (Chamada v_descricao_onibus) que mostre
-- o Código da Viagem,
-- o Nome do motorista, a placa do ônibus (Formato XXX-0000),
-- a Marca do ônibus, o Ano do ônibus e a descrição do onibus


create view v_descricaoOnibus
as
select v.codigo as Viagem, m.nome as Motorista,
	substring(o.placa, 1, 3) + '-' + substring(o.placa, 4, 4) as Onibus,
	o.marca as Marca_Onibus, o.ano as Ano_Onibus, o.descricao as Descricao_Onibus
	
from motorista m
inner join viagem v
on m.codigo = v.motorista
inner join onibus o
on v.onibus = o.placa

select * from v_descricaoOnibus

-- 4) Criar uma View (Chamada v_descricao_viagem) que mostre o
-- Código da viagem, a placa do ônibus(Formato XXX-0000),
-- a Hora da Saída da viagem (Formato HH:00),
-- a Hora da Chegada da viagem (Formato HH:00),
-- partida e destino

create view v_descricaoViagem as
select v.codigo as Viagem,
	substring(o.placa, 1, 3) + '-' + substring(o.placa, 4, 4) as Onibus,
	case when len(v.hora_saida) < 2
		then
			'0' + cast(v.hora_saida as varchar(2)) + ':00'
		else
			cast(v.hora_saida as varchar(2)) + ':00'
	end as Saida, 
	case when len(v.hora_chegada) < 2
		then
			'0' + cast(v.hora_chegada as varchar(2)) + ':00'
		else
			cast(v.hora_chegada as varchar(2)) + ':00'
	end as Chegada,
	v.partida as Partida, v.destino as Destino
from viagem v
inner join onibus o
on v.onibus = o.placa
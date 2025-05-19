create database aula1905
go
use aula1905
---------------------------
use master
go
drop database aula1905
go
create database aula1905
go
use aula1905
--------------------------
go
create table times (
	codigo	int			not null,
	nome	varchar(20)	not null,
	sigla	varchar(3)	not null
	primary key(codigo)
)
go
create table jogo (
	codigoTimeA		int		not null,
	codigoTimeB		int		not null,
	golsA			int		null,
	golsB			int		null,
	dia			datetime	not null
	primary key(codigoTimeA, codigoTimeB)
	foreign key(codigoTimeA) references times(codigo),
	foreign key(codigoTimeB) references times(codigo)
)
go
create table campeonato (
	codigoTime		int		not null,
	jogos			int		null,
	vitorias		int		null,
	empates			int		null,
	derrotas		int		null,
	golsPro			int		null,
	golsContra		int		null
	primary key(codigoTime)
	foreign key(codigoTime) references times(codigo)
)
go
create trigger t_time on times
after insert
as
begin
	declare @codigo int
	declare c cursor for
		select codigo from inserted
	open c
	fetch next from c into @codigo
	while @@FETCH_STATUS = 0 begin
		insert into campeonato (codigoTime) values (@codigo)
		fetch next from c into @codigo
	end
	close c 
	deallocate c
end

go
insert into times values
(1, 'Time A', 'TA'),
(2, 'Time B', 'TB')
go
insert into times values
(3, 'Time C', 'TC')
go
insert into times values
(4, 'Time D', 'TD')

go
select * from times
select * from campeonato

go
insert into jogo (codigoTimeA, codigoTimeB, dia) values
(1, 2, '22/04/2013 15:00'),
(1, 3, '29/04/2013 15:00'),
(1, 4, '06/05/2013 15:00'),
(2, 1, '25/04/2013 15:00'),
(2, 3 ,'02/04/2013 15:00'),
(2, 4 ,'09/05/2013 15:00'),
(3, 1 ,'12/05/2013 15:00'),
(3, 2 ,'15/05/2013 15:00'),
(3, 4 ,'18/05/2013 15:00'),
(4, 1 ,'23/05/2013 15:00'),
(4, 2 ,'27/05/2013 15:00'),
(4, 3 ,'31/05/2013 15:00')

go
create trigger t_jogo on jogo
after update
as
begin
	declare @codigoTimeA	int,
			@codigoTimeB	int,
			@golsA			int,
			@golsB			int
	declare c cursor for
		select codigoTimeA, codigoTimeB, golsA, golsB
		from inserted
	open c
	fetch next from c into @codigoTimeA, @codigoTimeB, @golsA, @golsB
	while @@FETCH_STATUS = 0 begin
		update campeonato
			set
				jogos = case 
					when jogos is null then 1 else jogos + 1 end,
				vitorias = case
					when (@golsA > @golsB and vitorias is null) then 1
					when (@golsA > @golsB and vitorias is not null) then vitorias + 1 
					else vitorias end,
				empates = case
					when (@golsA = @golsB and empates is null) then 1
					when (@golsA = @golsB and empates is not null) then empates + 1
					else empates end,
				derrotas = case
					when (@golsA < @golsB and derrotas is null) then 1
					when (@golsA < @golsB and derrotas is not null) then derrotas + 1
					else derrotas end,
				golsPro = case
					when (golsPro is null) then @golsA
					else golsPro + @golsA end,
				golsContra = case	
					when (golsContra is null) then @golsB
					else golsContra + @golsB end
			where codigoTime = @codigoTimeA
		update campeonato
			set
				jogos = case 
					when jogos is null then 1 else jogos + 1 end,
				vitorias = case
					when (@golsA < @golsB and vitorias is null) then 1
					when (@golsA < @golsB and vitorias is not null) then vitorias + 1 
					else vitorias end,
				empates = case
					when (@golsA = @golsB and empates is null) then 1
					when (@golsA = @golsB and empates is not null) then empates + 1
					else empates end,
				derrotas = case
					when (@golsA > @golsB and derrotas is null) then 1
					when (@golsA > @golsB and derrotas is not null) then derrotas + 1
					else derrotas end,
				golsPro = case
					when (golsPro is null) then @golsB
					else golsPro + @golsB end,
				golsContra = case	
					when (golsContra is null) then @golsA
					else golsContra + @golsA end
			where codigoTime = @codigoTimeB
		fetch next from c into @codigoTimeA, @codigoTimeB, @golsA, @golsB
	end
	close c
	deallocate c
end

update jogo
set golsA = 2,
golsB = 1
where codigoTimeA = 1 and codigoTimeB = 2

go
create function fn_campeonato()
returns @tabela table (
	
)
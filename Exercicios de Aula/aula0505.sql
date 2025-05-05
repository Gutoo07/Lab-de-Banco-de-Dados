create database aula0505
go
use aula0505
-----------------------------
go
create table times(
	cod		int			not null identity(1,1),
	nome	varchar(15)	not null
	primary key(cod)
)
go
create table jogos(
	id				int		not null,
	codTimeA		int		not null,
	codTimeB		int		not null,
	setTimeA		int		not null,
	setTimeB		int		not null
	primary key(id)
	foreign key(codTimeA) references times(cod),
	foreign key(codTimeB) references times(cod)
)
go
create function fn_resumo(@codTime int)
 returns @tabela table (
 	nomeTime			varchar(15),
	totalPts			int,
	totalSetsGanhos		int,
	totalSetsPerdidos	int,
	mediaSets			int
 )
 as
 begin
	declare @totalPts			int,
			@totalSetsGanhos	int,
			@totalSetsPerdidos	int,
			@i					int

	set @totalPts = 0
	set @totalSetsGanhos = 0
	set @totalSetsPerdidos = 0
	set @i = 1
	while ((select id from jogos where id = @i) is not null)
	begin
		if ((select codTimeA from jogos where id = @i) = @codTime)
		begin
			if ((select setTimeB from jogos where id = @i) < 2) --vencedor ganha +3 pontos
			begin
				set @totalPts = @totalPts + 3
			end
			else if ((select setTimeB from jogos where id = @i) = 2) --vencedor ganha +2 pontos
			begin
				set @totalPts = @totalPts + 2
			end
			else --perdedor ganha +1 pontos
			begin
				set @totalPts = @totalPts + 1
			end
			set @totalSetsGanhos = @totalSetsGanhos + (select setTimeA from jogos where id = @i)
			set @totalSetsPerdidos = @totalSetsPerdidos + (select setTimeB from jogos where id = @i)
		end
		else if ((select codTimeB from jogos where id = @i) = @codTime)
		begin
			if ((select setTimeA from jogos where id = @i) < 2) --vencedor ganha +3 pontos
			begin
				set @totalPts = @totalPts + 3
			end
			else if ((select setTimeA from jogos where id = @i) = 2) --vencedor ganha +2 pontos
			begin
				set @totalPts = @totalPts + 2
			end
			else --perdedor ganha +1 pontos
			begin
				set @totalPts = @totalPts + 1
			end
			set @totalSetsGanhos = @totalSetsGanhos + (select setTimeB from jogos where id = @i)
			set @totalSetsPerdidos = @totalSetsPerdidos + (select setTimeA from jogos where id = @i)
		end
		set @i = @i + 1
	end
	insert into @tabela values
	((select nome from times where cod = @codTime), @totalPts, @totalSetsGanhos,
	@totalSetsPerdidos,	(@totalSetsGanhos - @totalSetsPerdidos))
 	return
 end
-----------------------------------------------------------------------
insert into times values
('Time 1'),
('Time 2'),
('Time 3'),
('Time 4')
delete from jogos
insert into jogos values
(1, 1, 2, 3, 0),
(2, 1, 3, 3, 1),
(3, 1, 4, 2, 3),
(4, 2, 3, 2, 3),
(5, 2, 4, 1, 3),
(6, 3, 4, 2, 3)

select * from fn_resumo(1)
select * from fn_resumo(2)
select * from fn_resumo(3)
select * from fn_resumo(4)

---------------------------------------------------------
create trigger t_jogos on jogos
after insert, update
as
begin
	declare @i int,
			@setsTimeA int,
			@setsTimeB int
			
	set @i = 1
	while ((select id from inserted where id = @i) is not null)
	begin
		set @setsTimeA = (select setTimeA from inserted where id = @i) 
		set @setsTimeB = (select setTimeB from inserted where id = @i) 		
		if (@setsTimeA > 3 or @setsTimeB > 3 or (@setsTimeA + @setsTimeB) > 5)
		begin
			raiserror('Um ou mais inserts estao errados', 16, 1)
			rollback transaction
		end		
		set @i = @i + 1
	end
end
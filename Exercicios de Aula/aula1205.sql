create database aula1205
go
use aula1205
-----------------
/*Criar uma UDF (Function) cuja entrada é o código do curso e, com um cursor, monte uma
tabela de saída com as informações do curso que é parâmetro de entrada.
(Código_Disciplina | Nome_Disciplina | Carga_Horaria_Disciplina | Nome_Curso) */
-----------------
go
create table curso (
	codigo		int		not null,
	nome	varchar(50)	not null,
	duracao		int		not null
	primary key(codigo)
)
go
create table disciplina (
	codigo		varchar(6)		not null,
	nome	varchar(50)	not null,
	carga_horaria	int	not null,
	primary key (codigo)
)
go
create table disciplina_curso (
	codigo_disciplina	varchar(6)	not null,
	codigo_curso		int			not null
	primary key(codigo_disciplina, codigo_curso)
	foreign key(codigo_disciplina) references disciplina(codigo),
	foreign key(codigo_curso) references curso(codigo)
)
go
create function fn_dados_do_curso (@codigo_curso int)
returns @tabela table (
	codigo_disciplina	varchar(6),
	nome_disciplina		varchar(50),
	horas_disciplina		int,
	nome_curso			varchar(50)

)	
as
begin
	declare @codigo_disciplina	varchar(6),
			@nome_disciplina	varchar(50),
			@horas_disciplina	int,
			@nome_curso			varchar(50)
	declare c cursor
		for select d.codigo, d.nome, d.carga_horaria, cur.nome 
		from disciplina d
		inner join disciplina_curso dc
		on d.codigo = dc.codigo_disciplina
		inner join curso cur
		on dc.codigo_curso = cur.codigo
		where cur.codigo = @codigo_curso
	open c
	fetch next from c into @codigo_disciplina, @nome_disciplina, @horas_disciplina, @nome_curso
	while @@FETCH_STATUS = 0
	begin
		insert into  @tabela values (@codigo_disciplina, @nome_disciplina, @horas_disciplina, @nome_curso)
		fetch next from c into @codigo_disciplina, @nome_disciplina, @horas_disciplina, @nome_curso
	end
	close c
	deallocate c
	return
end

go
insert into curso values
(48, 'Análise e Desenvolvimento de Sistemas', 2880),
(51, 'Logística', 2880),
(67, 'Polímeros', 2880),
(73, 'Comércio Exterior', 2600),
(94, 'Gestão Empresarial', 2600)
go
insert into disciplina values
('ALG001', 'Algoritmos', 80),
('ADM001', 'Administração', 80),
('LHW010', 'Laboratório de Hardware', 40),
('LPO001', 'Pesquisa Operacional', 80),
('FIS003', 'Física I', 80),
('FIS007', 'Físico Química',80),
('CMX001', 'Comércio Exterior', 80),
('MKT002', 'Fundamentos de Marketing', 80),
('INF001', 'Informática', 40),
('ASI001', 'Sistemas de Informação', 80)
go
insert into disciplina_curso values
('ALG001', 48),
('ADM001', 48),
('ADM001', 51),
('ADM001', 73),
('ADM001', 94),
('LHW010', 48),
('LPO001', 51),
('FIS003', 67),
('FIS007', 67),
('CMX001', 51),
('CMX001', 73),
('MKT002', 51),
('MKT002', 94),
('INF001', 51),
('INF001', 73),
('ASI001', 48),
('ASI001', 94)
go

select * from fn_dados_do_curso(48)
select * from fn_dados_do_curso(51)
select * from fn_dados_do_curso(67)
select * from fn_dados_do_curso(73)
select * from fn_dados_do_curso(94)
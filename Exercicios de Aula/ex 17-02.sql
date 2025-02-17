create database aula1702
go
use aula1702
-------------------------------
create table curso(
	codigo_curso		int		not null,
	nome		varchar(70)		not null,
	sigla		varchar(10)		not null
	primary key(codigo_curso)
)
go
create table aluno(
	ra		char(7)				not null,
	nome	varchar(250)		not null,
	codigo_curso	int			not null
	primary key(ra)
	foreign key(codigo_curso) references curso(codigo_curso)
)
go
create table palestrante(
	codigo_palestrante		int		not null,
	nome			varchar(250)	not null,
	empresa			varchar(100)	not null
	primary key(codigo_palestrante)
)
go
create table palestra(
	codigo_palestra		int				not null,
	titulo				varchar(200)	not null,
	carga_horaria		int				not null,
	data_hora			datetime		not null,
	codigo_palestrante	int			not null
	primary key(codigo_palestra)
	foreign key(codigo_palestrante) references palestrante(codigo_palestrante)
)
go
create table alunos_inscritos(
	ra		char(7)		not null,
	codigo_palestra		int		not null
	primary key(ra, codigo_palestra)
	foreign key(ra) references aluno(ra),
	foreign key(codigo_palestra) references palestra(codigo_palestra)
)
go
create table nao_alunos(
	rg			varchar(9)		not null,
	orgao_exp		char(5)		not null,
	nome		varchar(25)		not null
	primary key(rg, orgao_exp)
)
go
create table nao_alunos_inscritos(
	rg		varchar(9)			not null,
	orgao_exp		char(5)		not null,
	codigo_palestra	int			not null
	primary key(rg, orgao_exp, codigo_palestra)
	foreign key(codigo_palestra) references palestra(codigo_palestra),
	foreign key(rg, orgao_exp) references nao_alunos(rg, orgao_exp)
)
-------------------------------------------------------------------------------
drop view v_chamada

create view v_chamada
as
select a.ra as Num_Documento, a.nome as Nome_Pessoa, p.titulo as Titulo_Palestra, 
	palestrante.nome as Nome_Palestrante, p.carga_horaria as Carga_Horaria, 
	p.data_hora as Data_Hora
from aluno a
inner join alunos_inscritos ai
on a.ra = ai.ra
inner join palestra p
on ai.codigo_palestra = p.codigo_palestra
inner join palestrante
on p.codigo_palestrante = palestrante.codigo_palestrante
UNION
select na.rg as Num_Documento, na.nome as Nome_Pessoa, p.titulo as Titulo_Palestra, 
	palestrante.nome as Nome_Palestrante, p.carga_horaria as Carga_Horaria, 
	p.data_hora as Data_Hora
from nao_alunos na
inner join nao_alunos_inscritos nai
on na.rg = nai.rg and na.orgao_exp = nai.orgao_exp
inner join palestra p
on nai.codigo_palestra = p.codigo_palestra
inner join palestrante
on p.codigo_palestrante = palestrante.codigo_palestrante

select * from v_chamada
where Titulo_Palestra like '%4%'
order by Nome_Pessoa desc
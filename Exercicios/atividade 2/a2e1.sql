create database a1e1
go
use a1e1

-------------------------------------------------
create table aluno(
	ra		char(4)		not null,
	nome	varchar(50)	not null,
	idade	int			not null	check(idade>0)
	primary key(ra)
)
go
create table disciplina(
	codigo			char(3)		not null,
	nome			varchar(50)	not null,
	carga_horaria	int			not null	check(carga_horaria > 32)
	primary key (codigo)
)
go
create table titulacao(
	codigo		char(2)		not null,
	titulo		varchar(30)	not null
	primary key (codigo)	
)
go
create table professor(
	registro	char(4)		not null,
	nome		varchar(30)	not null,
	titulacao	char(2)		not null
	primary key (registro)
	foreign key(titulacao) references titulacao(codigo)
)
go
create table curso(
	codigo	char(1)		not null,
	nome	varchar(30)	not null,
	area	varchar(30)	not null
	primary key(codigo)
)
go
create table aluno_disciplina(
	codigo_disciplina	char(3)		not null,
	ra_aluno			char(4)		not null
	primary key(codigo_disciplina, ra_aluno)
	foreign key(codigo_disciplina) references disciplina(codigo),
	foreign key(ra_aluno) references aluno(ra)
)
go
create table professor_disciplina(
	codigo_disciplina	char(3)		not null,
	registro_professor	char(4)		not null
	primary key(codigo_disciplina, registro_professor)
	foreign key(codigo_disciplina) references disciplina(codigo),
	foreign key(registro_professor) references professor(registro)
)
go
create table disciplina_curso(
	codigo_disciplina	char(3)		not null,
	codigo_curso		char(1)		not null
	primary key(codigo_disciplina, codigo_curso)
	foreign key(codigo_disciplina) references disciplina(codigo),
	foreign key(codigo_curso) references curso(codigo)
)
--------------INSERTS----------------------------------------------------------
insert into aluno values
('3416',	'DIEGO PIOVESAN DE RAMOS',	18),
('3423',	'LEONARDO MAGALH�ES DA ROSA',	17),
('3434',	'LUIZA CRISTINA DE LIMA MARTINELI',	20),
('3440',	'IVO ANDR� FIGUEIRA DA SILVA',	25),
('3443',	'BRUNA LUISA SIMIONI',	37),
('3448',	'THA�S NICOLINI DE MELLO',	17),
('3457',	'L�CIO DANIEL T�MARA ALVES',	29),
('3459',	'LEONARDO RODRIGUES',	25),
('3465',	'�DERSON RAFAEL VIEIRA',	19),
('3466',	'DAIANA ZANROSSO DE OLIVEIRA',	21),
('3467',	'DANIELA MAURER',	23),
('3470',	'ALEX SALVADORI PALUDO',	42),
('3471',	'VIN�CIUS SCHVARTZ',	19),
('3472',	'MARIANA CHIES ZAMPIERI',	18),
('3482',	'EDUARDO CAINAN GAVSKI',	19),
('3483',	'REDNALDO ORTIZ DONEDA',	20),
('3499',	'MAYELEN ZAMPIERON',	22)
go
insert into disciplina values
('1',	'Laborat�rio de Banco de Dados',	80),
('2',	'Laborat�rio de Engenharia de Software',	80),
('3',	'Programa��o Linear e Aplica��es',	80),
('4',	'Redes de Computadores',	80),
('5',	'Seguran�a da informa��o',	40),
('6',	'Teste de Software',	80),
('7',	'Custos e Tarifas Log�sticas',	80),
('8',	'Gest�o de Estoques',	40),
('9',	'Fundamentos de Marketing',	40),
('10',	'M�todos Quantitativos de Gest�o',	80),
('11',	'Gest�o do Tr�fego Urbano',	80),
('12',	'Sistemas de Movimenta��o e Transporte',	40)
go
insert into titulacao values
('1',	'Especialista'),
('2',	'Mestre'),
('3',	'Doutor')
go
insert into professor values
('1111',	'Leandro',	'2'),
('1112',	'Antonio',	'2'),
('1113',	'Alexandre',	'3'),
('1114',	'Wellington',	'2'),
('1115',	'Luciano',	'1'),
('1116',	'Edson',	'2'),
('1117',	'Ana',	'2'),
('1118',	'Alfredo',	'1'),
('1119',	'Celio',	'2'),
('1120',	'Dewar',	'3'),
('1121',	'Julio',	'1')
go
insert into curso values
('1',	'ADS',	'Ci�ncias da Computa��o'),
('2',	'Log�stica',	'Engenharia Civil')
go
insert into aluno_disciplina values
('1',	'3416'),
('4',	'3416'),
('1',	'3423'),
('2',	'3423'),
('5',	'3423'),
('6',	'3423'),
('2',	'3434'),
('5',	'3434'),
('6',	'3434'),
('1',	'3440'),
('5',	'3443'),
('6',	'3443'),
('4',	'3448'),
('5',	'3448'),
('6',	'3448'),
('2',	'3457'),
('4',	'3457'),
('5',	'3457'),
('6',	'3457'),
('1',	'3459'),
('6',	'3459'),
('7',	'3465'),
('11',	'3465'),
('8',	'3466'),
('11',	'3466'),
('8',	'3467'),
('12',	'3467'),
('8',	'3470'),
('9',	'3470'),
('11',	'3470'),
('12',	'3470'),
('7',	'3471'),
('7',	'3472'),
('12',	'3472'),
('9',	'3482'),
('11',	'3482'),
('8',	'3483'),
('11',	'3483'),
('12',	'3483'),
('8',	'3499')
go
insert into professor_disciplina values
('1', '1111'),
('2', '1112'),
('3', '1113'),
('4', '1114'),
('5', '1115'),
('6', '1116'),
('7', '1117'),
('8', '1118'),
('9', '1117'),
('10', '1119'),
('11', '1120'),
('12', '1121')
go
insert into disciplina_curso values
('1', '1'),
('2', '1'),
('3', '1'),
('4', '1'),
('5', '1'),
('6', '1'),
('7', '2'),
('8', '2'),
('9', '2'),
('10', '2'),
('11', '2'),
('12', '2')

select * from aluno
select * from disciplina
select * from professor
select * from curso
select * from titulacao
select * from aluno_disciplina
select * from professor_disciplina
select * from disciplina_curso

-----------SELECTS------------------------------
-- 1) Fazer uma pesquisa que permita gerar as listas de chamadas, com RA e nome por disciplina ?	
drop view v_chamada

create view v_chamada
as
select  d.nome as disciplina, a.ra, a.nome
from aluno a
inner join aluno_disciplina ad
on a.ra = ad.ra_aluno
inner join disciplina d
on ad.codigo_disciplina = d.codigo

select * from v_chamada
order by disciplina asc, nome asc
							





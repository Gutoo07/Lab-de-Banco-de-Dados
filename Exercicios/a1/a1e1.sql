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
('3423',	'LEONARDO MAGALHÃES DA ROSA',	17),
('3434',	'LUIZA CRISTINA DE LIMA MARTINELI',	20),
('3440',	'IVO ANDRÉ FIGUEIRA DA SILVA',	25),
('3443',	'BRUNA LUISA SIMIONI',	37),
('3448',	'THAÍS NICOLINI DE MELLO',	17),
('3457',	'LÚCIO DANIEL TÂMARA ALVES',	29),
('3459',	'LEONARDO RODRIGUES',	25),
('3465',	'ÉDERSON RAFAEL VIEIRA',	19),
('3466',	'DAIANA ZANROSSO DE OLIVEIRA',	21),
('3467',	'DANIELA MAURER',	23),
('3470',	'ALEX SALVADORI PALUDO',	42),
('3471',	'VINÍCIUS SCHVARTZ',	19),
('3472',	'MARIANA CHIES ZAMPIERI',	18),
('3482',	'EDUARDO CAINAN GAVSKI',	19),
('3483',	'REDNALDO ORTIZ DONEDA',	20),
('3499',	'MAYELEN ZAMPIERON',	22)
go
insert into disciplina values
('1',	'Laboratório de Banco de Dados',	80),
('2',	'Laboratório de Engenharia de Software',	80),
('3',	'Programação Linear e Aplicações',	80),
('4',	'Redes de Computadores',	80),
('5',	'Segurança da informação',	40),
('6',	'Teste de Software',	80),
('7',	'Custos e Tarifas Logísticas',	80),
('8',	'Gestão de Estoques',	40),
('9',	'Fundamentos de Marketing',	40),
('10',	'Métodos Quantitativos de Gestão',	80),
('11',	'Gestão do Tráfego Urbano',	80),
('12',	'Sistemas de Movimentação e Transporte',	40)
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
('1',	'ADS',	'Ciências da Computação'),
('2',	'Logística',	'Engenharia Civil')
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
select d.nome as disciplina, a.ra, a.nome as aluno
from aluno a
inner join aluno_disciplina ad
on a.ra = ad.ra_aluno
inner join disciplina d
on ad.codigo_disciplina = d.codigo
group by d.nome, a.ra, a.nome

-- 2) Fazer uma pesquisa que liste o nome das disciplinas e o nome dos professores que as ministram								
select d.nome as disciplina, p.nome as professor
from disciplina d
inner join professor_disciplina pd
on d.codigo = pd.codigo_disciplina
inner join professor p
on pd.registro_professor = p.registro
order by d.nome

-- 3) Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o nome do curso								
select c.nome
from curso c
inner join disciplina_curso dc
on c.codigo = dc.codigo_curso
inner join disciplina d
on dc.codigo_disciplina = d.codigo
where d.nome like '%Linear%'

-- 4) Fazer uma pesquisa que , dado o nome de uma disciplina, retorne sua área								
select c.area
from curso c
inner join disciplina_curso dc
on c.codigo = dc.codigo_curso
inner join disciplina d
on dc.codigo_disciplina = d.codigo
where d.nome like '%Marketing%'

-- 5) Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o título do professor que a ministra								
select t.titulo
from titulacao t
inner join professor p
on t.codigo = p.titulacao
inner join professor_disciplina pd
on p.registro = pd.registro_professor
inner join disciplina d
on pd.codigo_disciplina = d.codigo
where d.nome like '%Banco%'

-- 6) Fazer uma pesquisa que retorne o nome da disciplina e quantos alunos estão matriculados em cada uma delas								
select d.nome as disciplina, count(a.ra) as qtd_alunos
from disciplina d
inner join aluno_disciplina ad
on d.codigo = ad.codigo_disciplina
inner join aluno a
on ad.ra_aluno = a.ra
group by d.nome

-- 7) Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do professor.
--    Só deve retornar de disciplinas que tenham, no mínimo, 5 alunos matriculados		
select p.nome
from professor p
inner join professor_disciplina pd
on p.registro = pd.registro_professor
inner join disciplina d
on pd.codigo_disciplina = d.codigo
where d.nome like '%Urbano%' and d.codigo in (
	select d.codigo
	from disciplina d
	inner join aluno_disciplina ad
	on d.codigo = ad.codigo_disciplina
	group by d.codigo
	having ( count(ad.ra_aluno) > 4)
)	

-- 8) Fazer uma pesquisa que retorne o nome do curso e a quatidade de professores cadastrados que ministram aula nele.
--    A coluna deve se chamar quantidade													
select c.nome, count(p.registro) as quantidade
from curso c
inner join disciplina_curso dc
on c.codigo = dc.codigo_curso
inner join professor_disciplina pd
on dc.codigo_disciplina = pd.codigo_disciplina
inner join professor p
on pd.registro_professor = p.registro
group by c.nome				





create database aula1404
go
use aula1404
/* 1. Criar uma database, criar as tabelas abaixo, definindo o tipo de dados e a relação PK/FK e popular
com alguma massa de dados de teste (Suficiente para testar UDFs)

	Funcionário (Código, Nome, Salário)
	Dependendente (Código_Dep, Código_Funcionário, Nome_Dependente, Salário_Dependente)

a) Código no Github ou Pastebin de uma Function que Retorne uma tabela:
(Nome_Funcionário, Nome_Dependente, Salário_Funcionário, Salário_Dependente)

b) Código no Github ou Pastebin de uma Scalar Function que Retorne a soma dos Salários dos
dependentes, mais a do funcionário.*/
go
create table funcionario(
	codigo		int			not null,
	nome	varchar(100)	not null,
	salario	decimal(7,2)	not null
	primary key(codigo)
)
go
insert into funcionario values
(1, 'Funcionario 1', 1000.0),
(2, 'Funcionario 2', 2000.0),
(3, 'Funcionario 3', 3000.0),
(4, 'Funcionario 4', 4000.0),
(5, 'Funcionario 5', 5000.0),
(6, 'Funcionario 6', 6000.0),
(7, 'Funcionario 7', 7000.0),
(8, 'Funcionario 8', 8000.0),
(9, 'Funcionario 9', 9000.0),
(10, 'Funcionario 10', 10000.0)
go
create table dependente (
	codigo_dep			int				not null,
	codigo_funcionario	int				not null,
	nome_depentende		varchar(100)	not null,
	salario_dependente	decimal(7,2)	not null
	primary key (codigo_dep)
	foreign key (codigo_funcionario) references funcionario(codigo)
)
go
insert into dependente values
(1, 1, 'Dependente 1 F1', 100.0),
(2, 1, 'Dependente 2 F1', 100.0),
(3, 2, 'Dependente 1 F2', 200.0),
(4, 3, 'Dependente 1 F3', 300.0),
(5, 3, 'Dependente 2 F3', 300.0),
(6, 3, 'Dependente 3 F3', 300.0),
(7, 4, 'Dependente 1 F4', 400.0),
(8, 5, 'Dependente 1 F5', 500.0),
(9, 6, 'Dependente 1 F6', 600.0),
(10, 7, 'Dependente 1 F7', 700.0)

create function fn_funcionarios_depententes()
returns @tabela table (
	nome_funcionario	varchar(100),
	nome_dependente		varchar(100),
	salario_funcionario	decimal(7,2),
	salario_depentente	decimal(7,2)
)
as
begin
	insert into @tabela
		select f.nome, d.nome_depentende, f.salario, d.salario_dependente
		from dependente d
		inner join funcionario f
		on d.codigo_funcionario = f.codigo

	return
end

select * from fn_funcionarios_depententes()
select * from funcionario
select * from dependente

--===========================================================================

create function fn_salariofamiliartotal(@codigo_funcionario int)
returns decimal(7,2)
as
begin
	declare @salario_total decimal(7,2)

	set @salario_total = (select salario from funcionario where codigo = @codigo_funcionario)
	set @salario_total = @salario_total +
		(select sum(salario_dependente) from dependente where codigo_funcionario = @codigo_funcionario)
	return @salario_total
end

select dbo.fn_salariofamiliartotal(3) as salario_familiar_total

/*2. Fazer uma Function que retorne
a) a partir da tabela Produtos (codigo, nome, valor unitário e qtd estoque), quantos produtos
estão com estoque abaixo de um valor de entrada

b) Uma tabela com o código, o nome e a quantidade dos produtos que estão com o estoque
abaixo de um valor de entrada */
create table produto(
	codigo			int		not null,
	nome	varchar(100)	not null,
	valor	decimal(7,2)	not null,
	estoque			int		not null,
	primary key(codigo)
)
go
insert into produto values
(1, 'Produto 1', 10.0, 10),
(2, 'Produto 2', 20.0, 20),
(3, 'Produto 3', 30.0, 30),
(4, 'Produto 4', 40.0, 40),
(5, 'Produto 5', 50.0, 50)
go

create function fn_quantos_produtos_baixo_estoque(@estoque int)
returns int
as
begin
	declare @qtd int
	set @qtd = (select count(codigo) from produto where estoque < @estoque)
	return @qtd
end

select dbo.fn_quantos_produtos_baixo_estoque(41) as qtd_produtos_baixo_estoque

--===========================================================================

create function fn_tabela_produtos_baixo_estoque(@estoque int)
returns @tabela table (
	codigo	int,
	nome	varchar(100),
	estoque	int
)
as
begin
	insert into @tabela
		select codigo, nome, estoque from produto where estoque < @estoque
	return
end

select * from fn_tabela_produtos_baixo_estoque(41)

/*Criar, uma UDF, que baseada nas tabelas abaixo, retorne
Nome do Cliente, Nome do Produto, Quantidade e Valor Total, Data de hoje
Tabelas iniciais:
Cliente (Codigo, nome)
Produto (Codigo, nome, valor) */

create table cliente(
	codigo		int			not null,
	nome	varchar(100)	not null,
	primary key(codigo)
)
go
create table produtoEx3(
	codigo		int			not null,
	nome	varchar(100)	not null,
	valor	decimal(7,2)	not null
	primary key(codigo)
)
go
insert into cliente values
(1, 'Cliente 1'),
(2, 'Cliente 2'),
(3, 'Cliente 3'),
(4, 'Cliente 4'),
(5, 'Cliente 5')
go
insert into produtoEx3 values
(1, 'Produto 3.1', 13.0),
(2, 'Produto 3.2', 23.0),
(3, 'Produto 3.3', 33.0),
(4, 'Produto 3.4', 43.0),
(5, 'Produto 3.5', 53.0)
--tabela associativa que criarei a parte, suponho que seja necessaria dado o contexto do exercicio
go
create table compra (
	codigoCompra		int		not null,
	codigoCliente		int		not null,
	codigoProduto		int		not null,
	qtd					int		not null
	primary key(codigoCompra)
	foreign key(codigoCliente) references cliente(codigo),
	foreign key(codigoProduto) references produtoEx3(codigo)
)
go

create function fn_calcula_valor_total_compra(@codigoCompra int)
returns decimal(7,2)
as
begin
	declare @valorTotal decimal(7,2),
			@qtd		int,
			@valorUnitario	decimal(7,2)

	set @qtd = (select qtd from compra where codigoCompra = @codigoCompra)
	set @valorUnitario =	(select valor from produto p
							inner join compra cp
							on p.codigo = cp.codigoProduto
							where cp.codigoCompra = @codigoCompra)
	set @valorTotal = @qtd * @valorUnitario
	return @valorTotal
end

go
insert into compra (codigoCompra, codigoCliente, codigoProduto, qtd) values
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5)

create function fn_relatorio_compras_por_cliente(@codigoCliente int)
returns @tabela table(
	cliente			varchar(100),
	produto			varchar(100),
	qtd				int,
	valorTotal		decimal(7,2),
	dataPesquisa	date	default getdate()
)
as
begin
	insert into @tabela (cliente, produto, qtd, valorTotal)
		select c.nome, p.nome, cp.qtd, cp.qtd * p.valor
		from cliente c
		inner join compra cp
		on c.codigo = cp.codigoCliente
		inner join produto p
		on cp.codigoProduto = p.codigo
		where c.codigo = @codigoCliente
	return
end

select * from dbo.fn_relatorio_compras_por_cliente(5)
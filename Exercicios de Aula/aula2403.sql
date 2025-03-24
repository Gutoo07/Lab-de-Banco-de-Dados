create database aula2403
go
use aula2403
--========================
go
create table produto(
	codigo		int			not null,
	nome	varchar(30)		not null,
	valor	decimal(7,2)	not null
	primary key(codigo)
)
go
create table entrada(
	codigo_transacao		int		not null,
	codigo_produto			int		not null,
	qtd						int		not null,
	valor_total		decimal(7,2)	not null
	primary key(codigo_transacao)
	foreign key(codigo_produto) references produto(codigo)
)
go
create table saida(
	codigo_transacao		int		not null,
	codigo_produto			int		not null,
	qtd						int		not null,
	valor_total		decimal(7,2)	not null
	primary key(codigo_transacao)
	foreign key(codigo_produto) references produto(codigo)
)
go

create procedure sp_entrada_saida	(@opcao char(1), @codigo_transacao int, @codigo_produto int,
									@qtd int, @saida varchar(100) output)
as
	declare @tabela	varchar(7),
			@query	varchar(max),
			@valor_total	decimal(7,2)

	if (upper(@opcao) != 'E' and upper(@opcao) != 'S')
	begin
		raiserror('Erro ao inserir: Opcao Invalida', 16, 1)
	end
	else
	begin
		if (upper(@opcao) = 'E')--TABELA DE ENTRADA
		begin
			set @tabela = 'entrada'
		end
		else--TABELA DE SAIDA
		begin
			set @tabela = 'saida'
		end
		set @valor_total = (select valor from produto where codigo = @codigo_produto) * @qtd
		set @query = 'INSERT INTO '+@tabela+' VALUES('+cast(@codigo_transacao as varchar(10))+
						','+cast(@codigo_produto as varchar(10))+','+cast(@qtd as varchar(5))+
						','+cast(@valor_total as varchar(6))+')'
		print (@query)
		begin try
			exec (@query)
			set @saida = 'Tabela '+@tabela+' inserido(a) com sucesso.'
		end try
		begin catch
			set @saida = ERROR_MESSAGE()
			if @saida like '%PK%'
			begin
				raiserror('ID de Entrada/Saida já existente', 16, 1)
			end
			else
			begin
				raiserror('Erro desconhecido ao inserir Entrada/Saida', 16, 1)
			end
		end catch
	end

--testes
insert into produto values
(0, 'Produto 1', 10.0)

declare @out varchar(100)
exec sp_entrada_saida 'e', 0, 0, 3, @out output
print @out

select * from entrada

declare @out2 varchar(100)
exec sp_entrada_saida 's', 0, 0, 1, @out2 output
print @out2

select * from saida

declare @out3 varchar(100)
exec sp_entrada_saida 's', 0, 0, 2, @out3 output
print @out3

insert into produto values
(1, 'Produto 2', 50.0),
(2, 'Produto 3', 120.0)

declare @out4 varchar(100)
exec sp_entrada_saida 's', 1, 1, 2, @out4 output
print @out4

declare @out5 varchar(100)
exec sp_entrada_saida 'e', 1, 1, 2, @out5 output
print @out5

select * from entrada
select * from saida


create database a4e2
go
use a4e2
--------------------
go
create table cliente(
cpf						char(11)		not null,
nome				varchar(100)		not null,
email				varchar(200)		not null,
limite_de_credito	decimal(7,2)		not null,
dt_nasc						date		not null
primary key(cpf)
)
go
-------------------------------------------------
create procedure sp_cliente (@opc char(1), @cpf char(11), @nome varchar(100),
							@email varchar(200), @limite_de_credito decimal(7,2),
							@dt_nasc date, @saida varchar(100) output)
as
	declare @cpf_valido bit

	if (upper(@opc) = 'D' and @cpf is not null) --excluir informando cpf
	begin
		if ((select cpf from cliente where cpf = @cpf) is not null)
		begin
			delete cliente where cpf = @cpf
			set @saida = 'Cliente (CPF '+@cpf+') excluido com sucesso.'
		end
		else
		begin
			raiserror('Impossivel excluir: nao existe Cliente com o CPF informado!', 16, 1)
		end
	end
	else
	begin
		if (upper(@opc) = 'D' and @cpf is null) --excluir com cpf null
		begin
			raiserror('Erro ao excluir: CPF em branco!', 16, 1)
		end
		else -- se nao for excluir
		begin
			if (upper(@opc) = 'I') --se for inserir
			begin
				--confere se ja existe
				if ((select cpf from cliente where cpf = @cpf) is not null)
				begin
					raiserror('Erro ao Inserir: Cliente com esse CPF ja existe!', 16, 1)
				end
				else
				begin
					--valida o CPF com stored procedure
					exec sp_valida_cpf @cpf, @cpf_valido output
					if (@cpf_valido = 0)
					begin
						raiserror('Erro ao inserir: CPF invalido!', 16, 1)
					end
					else
					begin
						insert into cliente values
						(@cpf, @nome, @email, @limite_de_credito, @dt_nasc)
						set @saida = 'Cliente '+@nome+' inserido com sucesso.'
					end
				end
			end
			else
			begin
				if (upper(@opc) = 'U') -- se for update
				begin
					if (@cpf is null or (select cpf from cliente where cpf = '12345678900') is null)
					begin
						raiserror('Erro ao Atualizar: CPF invalido', 16, 1)
					end
					else
					begin
						update cliente
						set nome = @nome, email = @email,
							limite_de_credito = @limite_de_credito, dt_nasc = @dt_nasc
						where cpf = @cpf
						set @saida = 'Cliente (CPF '+@cpf+') atualizado com sucesso.'
					end
				end
			end
		end
	end

-------------------------------------------------------------------------------------------------------------------------
create procedure sp_valida_cpf (@cpf char(11), @valido bit output)
as
	declare @i		int,
			@j		int,
			@res	decimal(7,2)


	--comeca invalido
	set @valido = 0
	--verificando se todos os numeros sao iguais
	set @i = 2
	set @res = cast(substring(@cpf, 1, 1) as int)--pego o primeiro numero para comparar com o resto
	while (@i < 12)
	begin
		if (cast(substring(@cpf, @i, 1) as int) != @res)
		begin
			set @valido = 1 --se algum for diferente eu ja considero valido
		end
		set @i = @i + 1
	end

	--se passou no primeiro teste
	if (@valido = 1)
	begin
		set @i = 1
		set @j = 10 
		set @res = 0

		while (@i < 10)
		begin
			set @res = @res + ( cast(substring(@cpf,@i,1) as int) * @j )
			set @i = @i + 1
			set @j = @j - 1
		end
		--verificando PRIMEIRO digito verificador
		if ( (@res % 11) < 2)
		begin
			if ( cast(substring(@cpf, 10, 1) as int) != 0)
			begin
				set @valido = 0
			end
		end
		else
		begin
			if ( (11 - (@res % 11)) != cast(substring(@cpf, 10, 1) as int))
			begin
				set @valido = 0
			end
		end
	end

	--se ate aqui o cpf ainda for valido
	--(se o primeiro digito verificador estiver correto)
	if (@valido = 1)
	begin
		--verificando o SEGUNDO digito verificador
		set @i = 1
		set @j = 11
		set @res = 0

		while (@i < 11)
		begin
			set @res = @res + ( cast(substring(@cpf,@i,1) as int) * @j )
			set @i = @i + 1
			set @j = @j - 1
		end
		if ((@res % 11) < 2)
		begin
			if ( cast(substring(@cpf, 11, 1) as int) != 0)
			begin
				set @valido = 0
			end
		end
		else
		begin
			if ( (11 - (@res % 11)) != cast(substring(@cpf, 11, 1) as int))
			begin
				set @valido = 0
			end
		end
	end
-------------------------------------------------------------------------------
select * from cliente

declare @saida varchar(100)
exec sp_cliente 'I', '22233366638', 'Lucao', 'Sandra@gmail.com', 5000.00, '01/01/1998', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'I', '22233366638', 'Lucao', 'Lucao@gmail.com', 5000.00, '01/01/1998', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'U', '22233366638', 'Lucao', 'Lucao@gmail.com', 5000.00, '01/01/1998', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'D', '22233366638', 'Lucao', 'Lucao@gmail.com', 5000.00, '01/01/1998', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'D', '22233366638', 'Lucao', 'Lucao@gmail.com', 5000.00, '01/01/1998', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'i', '22233366638', 'Lucao', 'Lucao@gmail.com', 5000.00, '01/01/1998', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'i', '22233366638', 'Lucao', 'Lucao@gmail.com', 5000.00, '01/01/1998', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'i', '53489789813', 'Sandra', 'Lucao@gmail.com', 5000.00, '01/01/1998', @saida output
print @saida


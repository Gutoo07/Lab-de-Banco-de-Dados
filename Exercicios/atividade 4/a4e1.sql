create database a4e1
go
use a4e1
---------------------
go
create table aluno(
codigo			int		not null,
nome	varchar(100)	not null
primary key(codigo)
)
go
create table atividade(
codigo			int			not null,
descricao	varchar(100)	not null,
imc			decimal(7,2)	not null
primary key(codigo)
)
go
create table atividade_aluno(
codigo_aluno		int		not null,
codigo_atividade	int		not null,
altura		decimal(7,2)	not null,
peso		decimal(7,2)	not null,
imc			decimal(7,2)	not null
primary key(codigo_aluno, codigo_atividade)
)
-------------------------------------------
go
insert into atividade values
(1, 'Corrida + Step', 18.5),
(2, 'Biceps + Costas + Pernas', 24.9),
(3, 'Esteira + Biceps + Costas + Pernas', 29.9),
(4, 'Bicicleta + Biceps + Costas + Pernas', 34.9),
(5, 'Esteira + Bicicleta', 39.9)
--------------------------------------------------
go
create procedure sp_aluno	(@codigo int, @nome varchar(100),
							@altura decimal(7,2), @peso decimal(7,2),
							@saida varchar(100) output)
as
	declare @codigo_atividade	int,
			@novo_codigo		int,
			@imc		decimal(7,2),
			@imc_atividade	decimal(7,2)
	
	if (@codigo is null) -- se codigo for nulo
	begin
		if (@nome is not null and @altura is not null and @peso is not null)
		begin
			--achando o codigo novo para inserir
			if ( (select count(codigo) from aluno) = 0)
			begin
				set @novo_codigo = 1
			end
			else
			begin
				set @novo_codigo = (select max(codigo) from aluno) + 1
			end
			--inserindo codigo e nome na tabela Aluno
			insert into aluno values (@novo_codigo, @nome)
			set @saida  = 'Aluno '+cast(@codigo as varchar(5))+' inserido com sucesso.'
			--calculando imc e achando sua atividade correspondente
			set @imc = @peso /(@altura * @altura)
			exec sp_encontra_atividade_acima_do_imc @imc, @codigo_atividade output
				--inserindo dados na tabela Atividade_Aluno
				insert into atividade_aluno values (@novo_codigo, @codigo_atividade, @altura, @peso, @imc)
				--set @saida = @saida+' Tabela Atividade_Aluno compilada com sucesso.'
		end
	end
	else --se @codigo NAO for nulo
	begin
		if (select nome from aluno where codigo = @codigo) is not null --se exsitir aluno com esse @codigo
		begin
			set @imc = @peso /(@altura * @altura)
			exec sp_encontra_atividade_acima_do_imc @imc, @codigo_atividade output
			update atividade_aluno
			set altura = @altura, peso = @peso, imc = @imc, codigo_atividade = @codigo_atividade
			where codigo_aluno = @codigo
			set @saida = 'Aluno '+cast(@codigo as varchar(5))+' atualizado com sucesso.'
		end
		else
		begin
			raiserror('Erro ao atualizar Aluno: Aluno nao encontrado.', 16, 1)
		end
	end

--TESTES
select * from aluno
select * from atividade
select * from atividade_aluno

declare @saida varchar(100)
exec sp_aluno 1, 'Gustavo', 1.90, 85.3, @saida output
print @saida

declare @saida varchar(100)
exec sp_aluno NULL, 'Rafael', 1.90, 100.0, @saida output
print @saida

declare @saida varchar(100)
exec sp_aluno 2, NULL, 1.65, 100.0, @saida output
print @saida

declare @saida varchar(100)
exec sp_aluno 5, 'Amandinha', 1.55, 65.0, @saida output
print @saida
-----------------------------------------------------------------------------------------------------------
create procedure sp_encontra_atividade_acima_do_imc (@imc_aluno decimal(7,2), @codigo_atividade int output)
as

	declare @imc_atividade decimal(7,2)

	if (@imc_aluno < 39.9)
	begin
		set @codigo_atividade = 5
		set @imc_atividade = 39.9
		while (@imc_atividade > @imc_aluno) 
		begin
			set @codigo_atividade = @codigo_atividade - 1
			set @imc_atividade = (select imc from atividade where codigo = @codigo_atividade)
		end
		set @codigo_atividade = @codigo_atividade + 1
	end
	else
	begin
		set @codigo_atividade = 5
	end

--TESTES
declare @codigo_atividade int
exec sp_encontra_atividade_acima_do_imc 25, @codigo_atividade output
print @codigo_atividade


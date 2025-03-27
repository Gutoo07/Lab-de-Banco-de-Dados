create database LabBD
go
use LabBD
--================================================
go
create table especialidade(
	id			int		not null,
	nome	varchar(30)	not null
	primary key (id)
)
go
create table material(
	id			int			not null,
	nome	varchar(30)		not null,
	valor	decimal(7,2)	not null
	primary key(id)
)
go
create table cliente(
	rg			char(9)			not null,
	nome		varchar(100)	not null,
	telefone	varchar(11)		not null,
	dt_nasc		date			not null,
	senha		varchar(35)		not null
	primary key(rg)
)
go
create table medico(
	rg				char(9)			not null,
	nome			varchar(100)	not null,
	telefone		varchar(11)		not null,
	periodo			varchar(5)		not null,
	valor_consulta	decimal(7,2)	not null,
	especialidade	int				not null
	primary key(rg)
	foreign key(especialidade) references especialidade(id)
)
go
create table consulta(
	id				int				not null,
	clienteRg			char(9)		not null,
	medicoRg			char(9)		not null,
	dia					date		not null,
	hora				time		not null,
	particular			bit			not null,
	cod_autorizacao	varchar(5)		null
	primary key(id)
	foreign key(clienteRg) references cliente(rg),
	foreign key(medicoRg) references medico(rg)
)
go
create table consulta_material(
	consultaId		int		not null,
	materialId		int		not null,
	qtd				int		not null
	primary key(consultaId, materialId)
	foreign key(consultaId) references consulta(id),
	foreign key(materialId) references material(id)
)
go
--=============================================================
create procedure sp_valida_rg(@rg varchar(9), @rg_valido int output)
as

	set @rg_valido = 1 --comecamos valido e tentaremos invalida-lo
	if (len(@rg) != 9) --se o RG nao tiver 9 digitos
	begin
		set @rg_valido = 0
	end
	else --se tiver 9 digitos ele segue testando
	begin
		declare	@i		int,
				@j		int,
				@res	decimal(7,2)
		set @i = 1
		set @j = 9
		set @res = 0

		while (@i < 9)--vai passar do primeiro ao oitavo digito, multiplicando
		begin
			set @res = @res + (cast(substring(@rg, @i, 1) as int) * @j)
			set @i = @i + 1
			set @j = @j - 1
		end
		if (substring(@rg, 9, 1) != 'X')--se o ultimo digito nao for X
		begin
			--comparacao entre resto e digito verificador
			if ((@res % 11) != cast(substring(@rg, 9, 1) as decimal(7,2)))
			begin
				set @rg_valido = 2
			end
		end
		else --se o ultimo digito for X, o resto precisa ser = 10
		begin
			if ((@res % 11) != 10)--se o resto nao for 10, invalida
			begin
				set @rg_valido = 2
			end
		end
	end
	
--teste
declare @valido bit
exec sp_valida_rg '120300011', @valido output
print @valido

--=============================================================

create procedure sp_valida_senha(@senha varchar(35), @senha_valida int output)
as
	set @senha_valida = 0
	--verifica se tem no minimo 8 caracteres
	if (len(@senha) >= 8)
	begin
		declare @i	int
		set @i = 1
		while (@i <= len(@senha))
		begin
			if (ISNUMERIC(substring(@senha,@i,1)) = 1)
			--se tiver pelo menos um numero, ela valida
			begin
				set @senha_valida = 1
			end
			set @i = @i + 1
		end
		 if (@senha_valida = 0)
		 --se sair do while e ainda for 0 eh pq nao tem nenhum numero
		 begin
			set @senha_valida = 2 --vai retornar outro erro
		 end
	end

--teste
declare @valido int
exec sp_valida_senha 'senha123', @valido output
print @valido
exec sp_valida_senha 'senha', @valido output
print @valido
exec sp_valida_senha 'senhabcd', @valido output
print @valido

--=============================================================

create procedure sp_valida_login (@rg char(9), @senha varchar(35), @login_valido int output)
as
	if ((select rg from cliente where rg = @rg) is null)
	begin
		set @login_valido = 0 --primeiro erro: RG nao cadastrado
	end
	else --se houver um RG cadastrado
	begin
		if ((select senha from cliente where rg = @rg) != @senha)
		--se a senha for incorreta
		begin
			set @login_valido = 2
		end
		else --se a senha for correta
		begin
			set @login_valido = 1
		end
	end

--teste
insert into cliente values
('538227679', 'Camilo', '11911112222', '01/02/1998', 'senha1234')

declare @valido int
exec sp_valida_login '123', 'senha1234', @valido output --RG nao cadastrado
print @valido
exec sp_valida_login '538227679', 'senha1234', @valido output --senha correta
print @valido
exec sp_valida_login '538227679', 'aaa', @valido output --senha incorreta
print @valido

--=============================================================

create procedure sp_valida_idade(@dt_nasc date, @idade_valida int output)
as
	if (@dt_nasc is null)--passou dt_nasc null
	begin
		set @idade_valida = 0
	end
	else
	begin
		if (DATEDIFF(year, @dt_nasc, getdate()) < 18)
		begin
			set @idade_valida = 2 -- menor de 18 anos
		end
		else if (DATEDIFF(year, @dt_nasc, getdate()) > 18)
		begin
			set @idade_valida = 1 --maior de 18 anos
		end
		else --vai fazer/ja fez 18 esse ano
		begin --testar os meses
			if (MONTH(GETDATE()) < MONTH(@dt_nasc))
			begin
				set @idade_valida = 2
			end
			else if (MONTH(GETDATE()) > MONTH(@dt_nasc))
			begin
				set @idade_valida = 1
			end
			else
			begin --testar os dias
				if (DAY(GETDATE()) < DAY(@dt_nasc))
				begin
					set @idade_valida = 2
				end
				else
				begin
					set @idade_valida = 1
				end
			end
		end
	end

--teste
declare @valido int
exec sp_valida_idade '27/03/2007', @valido output
print @valido

declare @valido int
exec sp_valida_idade '26/03/2007', @valido output
print @valido

--=============================================================

create procedure sp_cliente	(@opc char(1), @rg char(9), @nome varchar(100), @telefone varchar(11),
							@dt_nasc date, @senha varchar(35), @saida varchar(100) output)
as
	declare @rg_valido	int,
			@senha_valida int

	if (upper(@opc) = 'I')
	--INSERIR CLIENTE
	begin
		if (@rg is not null and @nome is not null and @telefone is not null and @dt_nasc is not null and @senha is not null)
		--se todos os campos do Cliente foram preenchidos para o INSERT
		begin
			if ((select rg from cliente where rg = @rg) is not null)
			--se um Cliente com esse RG ja existir
			begin
				raiserror('Erro ao Inserir Cliente: este RG ja existe.', 16, 1)
			end
			else
			begin
				exec sp_valida_rg @rg, @rg_valido output
				if (@rg_valido = 0)--se o comprimento foi invalido
				begin
					raiserror('Erro ao Inserir Cliente: comprimento do RG invalido.', 16, 1)
				end
				else if (@rg_valido = 2)--se o RG foi invalido
				begin
					raiserror('Erro ao Inserir Cliente: RG invalido.', 16, 1)
				end
				else--se o RG eh valido
				begin
					exec sp_valida_senha @senha, @senha_valida output
					if (@senha_valida = 0)
					begin --se o comprimento da senha foi invalido
						raiserror('Erro ao Inserir Cliente: comprimendo da senha invalido.', 16, 1)
					end
					else if (@senha_valida = 2) --se a senha nao tem pelo menos 1 numero
					begin
						raiserror('Erro ao Inserir Cliente: a senha deve conter pelo menos um (1) numero.', 16 ,1)
					end
					else -- se a senha foi valida
					begin
						insert into cliente values
						(@rg, @nome, @telefone, @dt_nasc, @senha)
						set @saida = 'Cliente '+@nome+' inserido(a) com sucesso.'
					end
				end
			end			
		end
		else --se algum campo do Cliente nao foi inserido para o INSERT
		begin
			raiserror('Erro ao Inserir Cliente: um ou mais campos estao em branco.', 16, 1)
		end
	end
	else if (upper(@opc) = 'U')
	begin
		if (@rg is not null)
		--se o RG for passado
		begin
			if ((select rg from cliente where rg = @rg) is null)
			--se nao houver Cliente com este RG
			begin
				raiserror('Erro ao Atualizar: RG invalido.', 16, 1)
			end
			else
			begin
				exec sp_valida_senha @senha, @senha_valida output
				if (@senha_valida = 0)
				begin --se o comprimento da senha foi invalido
					raiserror('Erro ao Inserir Cliente: comprimendo da senha invalido.', 16, 1)
				end
				else if (@senha_valida = 2) --se a senha nao tem pelo menos 1 numero
				begin
					raiserror('Erro ao Inserir Cliente: a senha deve conter pelo menos um (1) numero.', 16 ,1)
				end
				else -- se a senha foi valida
				begin
					update cliente 
					set telefone = @telefone, dt_nasc = @dt_nasc, senha = @senha
					where rg = @rg
					set @saida = 'Cliente de RG: '+@rg+' atualizado(a) com sucesso.'
				end
			end
		end
		else
		begin
			raiserror('Erro ao atualizar: RG nao foi especificado', 16 ,1)
		end
	end
	else
	begin
		raiserror('Erro: Opcao Invalida', 16, 1)
	end

--teste
declare @saida varchar(100)
exec sp_cliente 'i', '311425471', 'Marcelo', '11933334444', '03/03/2003', 'senhamarcelo3', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'i', '311425471', 'Marcelo', '11933334444', '03/03/2003', 'senhamarcelo3', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'u', null, 'Marcelo Diaz', '11933334444', '03/03/2003', 'senhamarcelo333', @saida output
print @saida

declare @saida varchar(100)
exec sp_cliente 'i', '31142547', 'Lucas', '11933334444', '03/03/2003', 'senhamarcelo3', @saida output
print @saida

select * from cliente

--=============================================================

create procedure sp_medico	(@opc char(1), @rg char(9), @nome varchar(100), @telefone varchar(11), @periodo varchar(5),
							@valor_consulta decimal(7,2), @especialidade int, @saida varchar(100) output)
as
	declare @rg_valido int
					
	if (upper(@opc) = 'I')
	--INSERIR MEDICO
	begin
		exec sp_valida_rg @rg, @rg_valido output
		if (@rg_valido = 0)--se o comprimento foi invalido
		begin
			raiserror('Erro ao Inserir Medico: comprimento do RG invalido.', 16, 1)
		end
		else if (@rg_valido = 2)--se o RG foi invalido
		begin
			raiserror('Erro ao Inserir Medico: RG invalido.', 16, 1)
		end
		else--se o RG eh valido
		begin try
			insert into medico values
			(@rg, @nome, @telefone, @periodo, @valor_consulta, @especialidade)
			set @saida = 'Medico '+@nome+' inserido(a) com sucesso.'
		end try
		begin catch
			set @saida = ERROR_MESSAGE()
			if (@saida like '%NULL%')--algum campo em branco
			begin
				raiserror('Erro ao Inserir Medico: um ou mais campos em branco.', 16, 1)
			end
			else if (@saida like '%PK%')--primary key duplicada
			begin
				raiserror('Erro ao Inserir: RG ja cadastrado.', 16, 1)
			end
			else if (@saida like '%FK%')
			begin
				raiserror('Erro ao Inserir: Especialidade invalida.', 16, 1)
			end
			else
			begin
				raiserror('Erro desconhecido ao Inserir Medico.', 16, 1)
			end
		end catch
	end
	else if (upper(@opc) = 'U')
	begin
		if ((select rg from medico where rg = @rg) is null)
		--se nao houver Medico com este RG
		begin
			raiserror('Erro ao Atualizar Medico: RG invalido.', 16, 1)
		end
		else
		begin try
			update medico 
			set nome = @nome, telefone = @telefone, periodo = @periodo, valor_consulta = @valor_consulta, especialidade = @especialidade
			where rg = @rg
			set @saida = 'Medico de RG: '+@rg+' atualizado(a) com sucesso.'
		end try
		begin catch
			set @saida = ERROR_MESSAGE()
			if (@saida like '%NULL%')
			begin
				raiserror('Erro ao Atualizar Medico: um ou mais campos em branco.', 16 ,1)
			end
			else if (@saida like '%FK%')
			begin
				raiserror('Erro ao Inserir: Especialidade invalida.', 16, 1)
			end
		end catch
	end
	else if (upper(@opc) = 'D')
	begin 
		if ((select rg from medico where rg = @rg) is not null)
		begin
			delete from medico where rg = @rg
			set @saida = 'Medico de RG: '+@rg+' excluido(a) com sucesso.'
		end
		else
		begin
			raiserror('Erro ao Excluir Medico: RG invalido.', 16, 1)
		end	
	end
	else
	begin
		raiserror('Erro: Opcao Invalida', 16, 1)
	end

--=============================================================

create procedure sp_especialidade (@opc char(1), @id int, @nome varchar(30), @saida varchar(100) output)
as
	if(upper(@opc) = 'I')
	begin
		begin try
			insert into especialidade values
			(@id, @nome)
			set @saida = 'Especialidade '+@nome+' inserido(a) com sucesso.'
		end try
		begin catch
			if (ERROR_MESSAGE() like '%NULL%')
			begin
				raiserror('Erro ao Inserir Especialidade: um ou mais campos em branco.', 16, 1)
			end
			else if (ERROR_MESSAGE() like '%PK%')
			begin
				raiserror('Erro ao Inserir Especialidade: ID ja existe.', 16 ,1)
			end
			else
			begin
				raiserror('Erro desconhecido ao Inserir Especialidade.', 16, 1)
			end
		end catch
	end
	else if (upper(@opc) = 'U')
	begin
		begin try
			update especialidade
			set nome = @nome where id = @id
			set @saida = 'Especialidade #'+cast(@id as varchar(5))+' atualizado(a) com sucesso.'
		end try
		begin catch
			if (ERROR_MESSAGE() like '%NULL%')
			begin
				raiserror('Erro ao Inserir Especialidade: um ou mais campos em branco.', 16, 1)
			end
			else
			begin
				raiserror('Erro desconhecido ao Inserir Especialidade.', 16, 1)
			end			
		end catch
	end
	else if (upper(@opc) = 'D')
	begin
		if (@id is not null)
		begin
			delete from especialidade
			where id = @id
			set @saida = 'Especialidade #'+cast(@id as varchar(5))+'  excluido(a) com sucesso.'
		end
		else
		begin
			raiserror('Erro ao Excluir Especialidade: ID nao especificado', 16, 1)
		end
	end

--=============================================================

create procedure sp_material (@opc char(1), @id int, @nome varchar(30), @valor decimal(7,2), @saida varchar(100) output)
as
	if(upper(@opc) = 'I')
	begin
		begin try
			insert into material values
			(@id, @nome, @valor)
			set @saida = 'Material '+@nome+' inserido com sucesso.'
		end try
		begin catch
			if (ERROR_MESSAGE() like '%NULL%')
			begin
				raiserror('Erro ao Inserir Material: um ou mais campos em branco.', 16, 1)
			end
			else if (ERROR_MESSAGE() like '%PK%')
			begin
				raiserror('Erro ao Inserir Material: ID ja existe.', 16 ,1)
			end
			else
			begin
				raiserror('Erro desconhecido ao Inserir Material.', 16, 1)
			end
		end catch
	end
	else if (upper(@opc) = 'U')
	begin
		begin try
			update material
			set nome = @nome, valor = @valor where id = @id
			set @saida = 'Material #'+cast(@id as varchar(5))+' atualizado com sucesso.'
		end try
		begin catch
			if (ERROR_MESSAGE() like '%NULL%')
			begin
				raiserror('Erro ao Inserir Material: um ou mais campos em branco.', 16, 1)
			end
			else
			begin
				raiserror('Erro desconhecido ao Inserir Material.', 16, 1)
			end			
		end catch
	end
	else if (upper(@opc) = 'D')
	begin
		if (@id is not null)
		begin
			delete from material
			where id = @id
			set @saida = 'Material #'+cast(@id as varchar(5))+'  excluido com sucesso.'
		end
		else
		begin
			raiserror('Erro ao Excluir Material: ID nao especificado', 16, 1)
		end
	end

--teste
select * from material

declare @saida varchar(100)
exec sp_material 'i', 1, 'Material 1', 20.50, @saida output
print @saida

declare @saida varchar(100)
exec sp_material 'i', 2, 'Material 2', 5.0, @saida output
print @saida

declare @saida varchar(100)
exec sp_material 'u', 1, 'Material A', 20.50, @saida output
print @saida

declare @saida varchar(100)
exec sp_material 'd', 1, null, 20.50, @saida output
print @saida

declare @saida varchar(100)
exec sp_material 'i', null, 'Material 1', 20.50, @saida output
print @saida
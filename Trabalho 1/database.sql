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
create procedure sp_valida_rg(@rg varchar(9), @rg_valido bit output)
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
			if ((@res % 11) != cast(substring(@rg, 9, 1) as int))
			begin
				set @rg_valido = 0
			end
		end
		else --se o ultimo digito for X, o resto precisa ser = 10
		begin
			if ((@res % 11) != 10)--se o resto nao for 10, invalida
			begin
				set @rg_valido = 0
			end
		end
	end

declare @valido bit
exec sp_valida_rg '538227679', @valido output
print @valido
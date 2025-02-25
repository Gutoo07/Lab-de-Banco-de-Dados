create database a3e1
go
use a3e1
-------------------------------
-- A) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
declare @a	int
set @a = 30
if (@a % 2 = 0)
begin
	print('Numero '+cast(@a as varchar(2))+' é múltiplo de 2.')
end
if (@a % 3 = 0)
begin
	print('Numero '+cast(@a as varchar(2))+' é múltiplo de 3.')
end
if (@a % 5 = 0)
begin
	print('Numero '+cast(@a as varchar(2))+' é múltiplo de 5.')
end
if (@a % 2 !=0 and @a % 3 != 0 and @a % 5 != 0)
begin
	print('Numero '+cast(@a as varchar(2))+' não é múltiplo de 2, de 3 nem de 5.')
end

-- B) Fazer um algoritmo que leia 3 números e mostre o maior e o menor
declare @b	int,
		@c	int,
		@d	int,
		@maior	int,
		@menor	int,
		@aux	int
set @b = 21
set @c = 14
set @d = 7

--bubble sort altamente improvisado
while (@b > @c or @c > @d)
begin
	if (@b > @c)
	begin
		set @aux = @b
		set @b = @c
		set @c = @aux
	end
	set @aux = @c
	set @c = @d
	set @d = @aux
end
print(cast(@b as varchar(2))+' < '+cast(@c as varchar(2))+' < '+cast(@d as varchar(2)))

-- C) Fazer um algoritmo que calcule os 15 primeiros termos da série
declare @esquerda	int,
		@meio		int,
		@direita	int,
		@soma		int,
		@serie		varchar(100),
		@i			int
set @serie = '1'
set @soma = 1
set @esquerda = 0
set @meio = 1
set @i = 0
while (@i < 14)
begin
	set @direita = @esquerda + @meio
	set @serie = @serie +', ' + cast(@direita as varchar(3))
	set @soma = @soma + @direita
	set @esquerda = @meio
	set @meio = @direita
	set @i = @i + 1
end
print(@serie)
print ('Soma total = '+cast(@soma as varchar(5)))

-- D) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
--	minúsculo (Usar funções UPPER e LOWER)
declare @frase		varchar(30),
		@letras		varchar(30),
		@posicao	int

set @frase = 'aBcDe'
set @posicao = 1
set @letras = ''

while (@posicao <= len(@frase))
begin
	set @letras = @letras + upper(substring(@frase, @posicao, 1))
	set @posicao = @posicao + 1
end
set @posicao = 1
set @letras = @letras + ' ; '
while (@posicao <= len(@frase))
begin
	set @letras = @letras + lower(substring(@frase, @posicao, 1))
	set @posicao = @posicao + 1
end
print (@letras)

-- E) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)
declare @palavra	varchar(15),
		@invertida	varchar(15),
		@p			int
set @palavra = 'Subi No Onibus'
set @invertida = ''
set @p = len(@palavra)

while (@p > 0)
begin
	set @invertida = @invertida + substring(@palavra, @p, 1)
	set @p = @p - 1
end
print (@invertida)

-- F) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
--	com as regras estabelecidas (Não usar constraints na criação da tabela)

create table computador(
	id			int,
	marca		varchar(40),
	qtdRam		int,
	tipoHd		varchar(10),
	qtdHd		int,
	freqCpu		decimal(7,2)
	primary key(id)
)
declare @id			int,
		@ram		int,
		@tipoHd		varchar(10),
		@qtdHd			int,
		@freqCpu	decimal(7,2)
set @id = 1
set @ram = 0
set @qtdHd = 0

while (@id <= 100)
begin
------SORTEIA A RAM
	while (@ram != 2 and @ram != 4 and @ram != 8 and @ram != 16)
	begin
		set @ram = cast(RAND() * 15 + 2 as int) 
	end

------DESCOBRE O TIPO DO HD
	if ( (10000 + @id) % 3 = 0)
	begin
		set @tipoHd = 'HDD'
	------SE FOR HDD JA SORTEIA SUA QTD AQUI
		while (@qtdHd != 500 and @qtdHd != 1000 and @qtdHd != 2000)
		begin
			set @qtdHd = rand() * 1501 + 500
		end
	end
	else if ( (10000 + @id) % 3 = 1)
	begin
		set @tipoHd = 'SSD'
	end
	else if ( (10000 + @id) % 3 = 2)
	begin
		set @tipoHd = 'M2 NVME'
	end
------SORTEIA A QTD DOS SSDs SEPARADO PARA NAO REPETIR O CODIGO 2x, COMO FIZ NO DO HDD
	if (@tipoHd = 'SSD' or @tipoHd = 'M2 NVME')
	begin
		while (@qtdHd != 128 and @qtdHd != 256 and @qtdHd != 512)
		begin
			set @qtdHd = rand() * 385 + 128
		end
	end

------INSERE OS VALORES
	insert into computador values
	( (10000 + @id), 'Marca '+cast(@id as varchar(100)), 
		@ram, @tipoHd, @qtdHd, (rand() * 1.51 + 1.7) )

------RESETA OS VALORES PARA PODEREM SER SORTEADOS NOVAMENTE, DENTRO DOS VALORES PERMITIDOS
	set @id = @id + 1
	set @ram = 0
	set @qtdHd = 0
end
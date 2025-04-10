use springdata2

select * from paciente
select * from medico
select * from especialidade

select
c.id as consulta, convert(char(10), c.dia, 103) as dia, cast(c.hora as varchar(5)) as hora, m.codigo as m#, m.nome as medico, p.numBeneficiario as p#, p.nome as paciente
from consulta c
inner join medico m
on c.medicoCodigo = c.medicoCodigo
inner join paciente p
on c.pacienteNumBeneficiario = p.numBeneficiario


insert into paciente values
(1, '01234567', 'Rua  Legal', 'Enzo', 123, 'Rua Bacana 123', '11911112222')

insert into especialidade values
(1, 'Otorrinolaringologista'),
(2, 'Oftalmologista'),
(3, 'Dentista'),
(4, 'Fisioterapeuta')

insert into medico values
(1, '12345678', 'Avenida Joia', 'medico1@gmail.com', 'Anderson', 456, 'Avenida Diamante', 1)

insert into consulta values
(1, '15/04/2025', '13:00', 1, 1)


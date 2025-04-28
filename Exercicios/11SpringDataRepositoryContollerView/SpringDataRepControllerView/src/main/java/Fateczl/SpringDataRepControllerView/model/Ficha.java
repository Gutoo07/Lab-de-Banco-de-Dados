package Fateczl.SpringDataRepControllerView.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

/*Nao declarei nem criei Table porque considero essa classe inteira como uma
"classe derivada", ela eh temporaria e so vai servir pra exibir as consultas da
especialidade respectiva no front. A cada pesquisa de consultas por especialidade,
uma nova Ficha temporaria seria criada.*/

@Getter
@Setter
public class Ficha {
	private String medico;
	private LocalDate dia;
	private String hora;
}

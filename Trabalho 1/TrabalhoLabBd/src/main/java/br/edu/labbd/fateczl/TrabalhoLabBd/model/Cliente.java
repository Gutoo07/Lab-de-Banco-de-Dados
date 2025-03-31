package br.edu.labbd.fateczl.TrabalhoLabBd.model;

import java.time.LocalDate;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cliente {

	private String rg;
	private String nome;
	private String telefone;
	private LocalDate dt_nasc;
	private String dt_nascStr;
	private String senha;
}

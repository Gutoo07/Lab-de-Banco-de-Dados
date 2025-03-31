package br.edu.labbd.fateczl.TrabalhoLabBd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data /*monta os Getters, Setters, toString...*/
@AllArgsConstructor
@NoArgsConstructor
public class Especialidade {

	private int id;
	private String nome;
}

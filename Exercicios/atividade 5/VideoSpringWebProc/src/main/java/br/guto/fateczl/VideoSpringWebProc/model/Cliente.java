package br.guto.fateczl.VideoSpringWebProc.model;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cliente {
	
	private String cpf;
	private String nome;
	private String email;
	private double limite_de_credito;
	private LocalDate dt_nasc;
	private String dt_nascStr;
}

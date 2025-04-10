package edu.guto.fateczl.SegundoProjetoSpringData.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "paciente")
public class Paciente {

	@Id
	@Column(name = "numBeneficiario", nullable = false)
	private int numBeneficiario;
	@Column(name = "nome", length = 100, nullable = false)
	private String nome;
	@Column(name = "telefone", length = 11, nullable = false)
	private String telefone;
	@Column(name = "ruaEnd", length = 100, nullable = false)
	private String ruaEnd;
	@Column(name = "numEnd", nullable = false)
	private int numEnd;
	@Column(name = "cepEnd", length = 8, nullable = false) 
	private String cepEnd;
	@Column(name = "compEnd", length = 50, nullable = false)
	private String compEnd;
}

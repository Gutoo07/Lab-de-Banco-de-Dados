package Fateczl.SpringDataRepControllerView.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "medico")
@Getter
@Setter
public class Medico {
	@Id
	@Column(name = "codigo", nullable = false)
	private int codigo;
	@Column(name = "nome", length = 100, nullable = false)
	private String nome;
	@Column(name = "contato", length = 50, nullable = false)
	private String contato;
	@Column(name = "ruaEnd", length = 100, nullable = false)
	private String ruaEnd;
	@Column(name = "numEnd", nullable = false)
	private int numEnd;
	@Column(name = "cepEnd", length = 8, nullable = false) 
	private String cepEnd;
	@Column(name = "compEnd", length = 50, nullable = false)
	private String compEnd;
	
	@ManyToOne(targetEntity = Especialidade.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "especialidadeId", nullable = false)
	private Especialidade especialidade;
}

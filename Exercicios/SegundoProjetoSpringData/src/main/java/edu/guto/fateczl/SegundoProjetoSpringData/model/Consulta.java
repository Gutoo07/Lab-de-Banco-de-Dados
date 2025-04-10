package edu.guto.fateczl.SegundoProjetoSpringData.model;

import java.sql.Time;
import java.time.LocalDate;

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
@Table(name = "consulta")
@Getter
@Setter
public class Consulta {
	@Id
	@Column(name = "id", nullable = false)
	private int id;
	@Column(name = "dia", nullable = false)
	private LocalDate dia;
	@Column(name = "hora", nullable = false)
	private Time hora;
	
	
	@ManyToOne(targetEntity = Paciente.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "pacienteNumBeneficiario", nullable = false)
	private Paciente paciente;
	@ManyToOne(targetEntity = Medico.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "medicoCodigo", nullable = false)
	private Medico medico;
	@ManyToOne(targetEntity = Especialidade.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "especialidadeId", nullable = false) 
	private Especialidade especialidade;
}

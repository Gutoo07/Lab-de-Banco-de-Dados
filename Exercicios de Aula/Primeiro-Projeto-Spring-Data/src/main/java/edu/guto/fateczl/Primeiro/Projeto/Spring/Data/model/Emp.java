package edu.guto.fateczl.Primeiro.Projeto.Spring.Data.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Emp")
public class Emp {
	@Id
	@Column(name = "codEmp", nullable = false)
	private int codEmp;
	@Column(name = "nome", length = 100, nullable = false)
	private String nome;
	@Column(name = "cat", length = 1, nullable = false)
	private String cat;
	@Column(name = "sal", precision = 7, scale = 2)
	private BigDecimal sal;
	@Column(name = "dataIni", nullable = false)
	private LocalDate dataIni;
}

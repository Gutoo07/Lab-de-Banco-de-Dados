package edu.guto.fateczl.Primeiro.Projeto.Spring.Data.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "projeto")
public class Projeto {
	@Id
	@Column(name = "codProj", nullable = false)
	private int codProj;
	@Column(name = "tipo", length = 15, nullable = false)
	private String tipo;
	@Column(name = "descr", length = 255, nullable = false)
	private String descr;
	
	@ManyToOne(targetEntity = Emp.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "empCodEmp", nullable = false)
	private Emp emp;
}

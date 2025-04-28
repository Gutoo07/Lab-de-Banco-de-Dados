package Fateczl.SpringDataRepControllerView.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "especialidade")
@Getter
@Setter
public class Especialidade {
	@Id
	@Column(name = "id", nullable = false)
	private int id;
	@Column(name = "nome", length = 35, nullable = false)
	private String nome;	
}

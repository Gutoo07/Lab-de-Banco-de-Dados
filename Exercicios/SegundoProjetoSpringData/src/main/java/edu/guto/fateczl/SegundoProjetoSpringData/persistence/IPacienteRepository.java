package edu.guto.fateczl.SegundoProjetoSpringData.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import edu.guto.fateczl.SegundoProjetoSpringData.model.Paciente;

@Repository
public interface IPacienteRepository extends JpaRepository<Paciente, Integer> {
	
	public List<Paciente> findByNome(String nome);
}

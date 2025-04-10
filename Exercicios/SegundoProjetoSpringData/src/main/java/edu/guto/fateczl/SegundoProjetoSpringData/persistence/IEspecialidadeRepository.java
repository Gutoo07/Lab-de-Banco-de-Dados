package edu.guto.fateczl.SegundoProjetoSpringData.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import edu.guto.fateczl.SegundoProjetoSpringData.model.Especialidade;

@Repository
public interface IEspecialidadeRepository extends JpaRepository<Especialidade, Integer> {
	public Especialidade findByNome(String nome);
}

package Fateczl.SpringDataRepControllerView.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import edu.guto.fateczl.SegundoProjetoSpringData.model.Medico;

@Repository
public interface IMedicoRepository extends JpaRepository<Medico, Integer> {
	public List<Medico> findByNome(String nome);
	public List<Medico> findByEspecialidadeId(int especialidadeId);
}

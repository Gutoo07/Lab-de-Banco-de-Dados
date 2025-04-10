package edu.guto.fateczl.SegundoProjetoSpringData.persistence;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import edu.guto.fateczl.SegundoProjetoSpringData.model.Consulta;

@Repository
public interface IConsultaRepository extends JpaRepository<Consulta, Integer> {
	public List<Consulta> findByPacienteNumBeneficiario(int id);
	public List<Consulta> findByMedicoCodigo(int id);
	public List<Consulta> findByEspecialidadeId(int especialidadeId);
	public List<Consulta> findByDia(LocalDate dia);
}

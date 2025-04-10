package edu.guto.fateczl.SegundoProjetoSpringData.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import edu.guto.fateczl.SegundoProjetoSpringData.model.Consulta;
import edu.guto.fateczl.SegundoProjetoSpringData.model.Especialidade;
import edu.guto.fateczl.SegundoProjetoSpringData.model.Ficha;
import edu.guto.fateczl.SegundoProjetoSpringData.model.Medico;
import edu.guto.fateczl.SegundoProjetoSpringData.persistence.IConsultaRepository;
import edu.guto.fateczl.SegundoProjetoSpringData.persistence.IEspecialidadeRepository;
import edu.guto.fateczl.SegundoProjetoSpringData.persistence.IMedicoRepository;

@Controller
public class FichaController {
	@Autowired
	private IMedicoRepository medicoRepo;
	@Autowired
	private IConsultaRepository consultaRepo;
	@Autowired
	private IEspecialidadeRepository especialidadeRepo;
	
	public List<Ficha> getFicha(String nomeEspecialidade) {
		Especialidade especialidade = especialidadeRepo.findByNome(nomeEspecialidade);
		List<Consulta> consultas = consultaRepo.findByEspecialidadeId(especialidade.getId());
		if (!consultas.isEmpty()) {
			List<Ficha> fichas = new ArrayList<>();
			for (Consulta consulta: consultas) {
				Ficha ficha = new Ficha();
				ficha.setDia(consulta.getDia());
				ficha.setHora(consulta.getHora().toString());
				Optional<Medico> medico = medicoRepo.findById(consulta.getMedico().getCodigo());
				ficha.setMedico(medico.get().getNome());
				fichas.add(ficha);
			}
			return fichas;
		} else {
			return null;
		}
	}
}

package edu.guto.fateczl.SegundoProjetoSpringData.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import edu.guto.fateczl.SegundoProjetoSpringData.model.Especialidade;
import edu.guto.fateczl.SegundoProjetoSpringData.persistence.IEspecialidadeRepository;

@Controller
public class EspecialidadeController {
	@Autowired
	private IEspecialidadeRepository repo;
	
	public List<Especialidade> getAll() {
		return repo.findAll();
	}
	public Especialidade getByNome(String nome) {
		return repo.findByNome(nome);
	}
	public Optional<Especialidade> getById(int id) {
		return repo.findById(id);
	}
	public void inserir(Especialidade especialidade) {
		repo.save(especialidade);
	}
	public void atualizar(Especialidade especialidade) {
		repo.save(especialidade);
	}
	public void excluir(Especialidade especialidade) {
		repo.delete(especialidade);
	}
}

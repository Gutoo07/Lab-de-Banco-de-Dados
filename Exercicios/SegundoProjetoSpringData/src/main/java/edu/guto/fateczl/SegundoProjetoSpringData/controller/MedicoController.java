package edu.guto.fateczl.SegundoProjetoSpringData.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import edu.guto.fateczl.SegundoProjetoSpringData.model.Medico;
import edu.guto.fateczl.SegundoProjetoSpringData.persistence.IMedicoRepository;

@Controller
public class MedicoController {
	@Autowired
	private IMedicoRepository repo;
	
	public List<Medico> getAll() {
		return repo.findAll();
	}
	public List<Medico> getByNome(String nome) {
		return repo.findByNome(nome);
	}
	public Optional<Medico> getById(int id) {
		return repo.findById(id);
	}
	public void inserir(Medico medico) {
		repo.save(medico);
	}
	public void atualizar(Medico medico) {
		repo.save(medico);
	}
	public void excluir(Medico medico) {
		repo.delete(medico);
	}
}

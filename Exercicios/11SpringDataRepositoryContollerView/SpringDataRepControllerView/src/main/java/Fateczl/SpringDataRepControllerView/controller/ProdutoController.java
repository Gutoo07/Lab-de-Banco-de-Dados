package Fateczl.SpringDataRepControllerView.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import Fateczl.SpringDataRepControllerView.model.Paciente;
import Fateczl.SpringDataRepControllerView.persistence.IPacienteRepository;
 
@Controller
public class ProdutoController {
	@Autowired
	private IPacienteRepository pacienteRepo;
	
	public List<Paciente> getAll() {
		return pacienteRepo.findAll();
	}
	public List<Paciente> getByNome(String nome) {
		return pacienteRepo.findByNome(nome);
	}
	public Optional<Paciente> getById(int id) {
		return pacienteRepo.findById(id);
	}
	public void inserir(Paciente paciente) {
		pacienteRepo.save(paciente);
	}
	public void excluir(Paciente paciente) {
		pacienteRepo.delete(paciente);
	}
	public void atualizar(Paciente paciente) {
		pacienteRepo.save(paciente);
	}

}

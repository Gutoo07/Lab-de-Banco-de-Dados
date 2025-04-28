package Fateczl.SpringDataRepControllerView.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import Fateczl.SpringDataRepControllerView.model.Consulta;
import Fateczl.SpringDataRepControllerView.persistence.IConsultaRepository;

@Controller
public class ConsultaController {
	@Autowired
	private IConsultaRepository repo;
	
	public List<Consulta> getAll() {
		return repo.findAll();
	}
	public List<Consulta> getByPacienteId(int id) {
		return repo.findByPacienteNumBeneficiario(id);
	}
	public List<Consulta> getByMedicoId(int id) {
		return repo.findByMedicoCodigo(id);
	}
	public List<Consulta> getByDia(LocalDate dia) {
		return repo.findByDia(dia);
	}
	public void inserir(Consulta consulta) {
		repo.save(consulta);
	}
	public void atualizar(Consulta consulta) {
		repo.save(consulta);
	}
}

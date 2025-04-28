package Fateczl.SpringDataRepControllerView.persistence;

import java.util.List; 

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import Fateczl.SpringDataRepControllerView.model.Paciente;

@Repository
public interface IPacienteRepository extends JpaRepository<Paciente, Integer> {
	
	public List<Paciente> findByNome(String nome);
}

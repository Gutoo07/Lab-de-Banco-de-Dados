package edu.guto.fateczl.SegundoProjetoSpringData;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import edu.guto.fateczl.SegundoProjetoSpringData.controller.ConsultaController;
import edu.guto.fateczl.SegundoProjetoSpringData.controller.MedicoController;
import edu.guto.fateczl.SegundoProjetoSpringData.model.Medico;
import edu.guto.fateczl.SegundoProjetoSpringData.persistence.IPacienteRepository;

@SpringBootApplication
public class SegundoProjetoSpringDataApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(SegundoProjetoSpringDataApplication.class, args);
	}
}
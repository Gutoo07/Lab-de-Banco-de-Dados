package edu.guto.fateczl.Primeiro.Projeto.Spring.Data.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import edu.guto.fateczl.Primeiro.Projeto.Spring.Data.model.Projeto;

public interface IProjetoRepository extends JpaRepository<Projeto, Integer> {

}

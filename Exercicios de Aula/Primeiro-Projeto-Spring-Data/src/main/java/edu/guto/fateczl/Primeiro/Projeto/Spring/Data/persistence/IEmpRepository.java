package edu.guto.fateczl.Primeiro.Projeto.Spring.Data.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import edu.guto.fateczl.Primeiro.Projeto.Spring.Data.model.Emp;

public interface IEmpRepository extends JpaRepository<Emp, Integer> {

}

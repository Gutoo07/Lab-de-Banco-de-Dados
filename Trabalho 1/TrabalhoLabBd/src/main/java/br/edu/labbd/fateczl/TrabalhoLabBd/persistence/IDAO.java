package br.edu.labbd.fateczl.TrabalhoLabBd.persistence;

import java.sql.SQLException;
import java.util.List;

public interface IDAO<T> {

	public String inserir (T t) throws SQLException, ClassNotFoundException;
	public String atualizar (T t) throws SQLException, ClassNotFoundException;
	public String excluir (T t) throws SQLException, ClassNotFoundException;
	public T buscar (T t) throws SQLException, ClassNotFoundException;
	public List<T> listar() throws SQLException, ClassNotFoundException;
}

package persistence;

import java.sql.SQLException;
import java.util.List;

public interface IDao<T> {

	public void inserir (T t) throws SQLException, ClassNotFoundException;
	public void atualizar (T t) throws SQLException, ClassNotFoundException;
	public void excluir (T t) throws SQLException, ClassNotFoundException;
	public T pesquisar (T t) throws SQLException, ClassNotFoundException;
	public List<T> listar () throws SQLException, ClassNotFoundException;
}

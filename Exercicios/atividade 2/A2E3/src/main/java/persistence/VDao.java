package persistence;

import java.sql.SQLException;
import java.util.List;

public interface VDao<T> {

	public T getView(T t) throws ClassNotFoundException, SQLException;
}

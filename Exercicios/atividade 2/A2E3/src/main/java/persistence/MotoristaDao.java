package persistence;

import model.Motorista;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MotoristaDao implements IDao<Motorista> {
	
	private GenericDao gDao;
	
	public MotoristaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Motorista m) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "INSERT INTO motorista VALUES (?,?,?)";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setInt(1, m.getCodigo());
		stm.setString(2, m.getNome());
		stm.setString(3, m.getNaturalidade());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public void atualizar(Motorista m) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "UPDATE motorista SET nome = ?, naturalidade = ? WHERE codigo = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, m.getNome());
		stm.setString(2, m.getNaturalidade());
		stm.setInt(3, m.getCodigo());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public void excluir(Motorista m) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "DELETE FROM motorista WHERE codigo = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setInt(1, m.getCodigo());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public Motorista pesquisar(Motorista m) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM motorista WHERE codigo = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setInt(1, m.getCodigo());
		ResultSet rs = stm.executeQuery();
		if(rs.next()) {
			m.setNome(rs.getString("nome"));
			m.setNaturalidade(rs.getString("naturalidade"));
		}
		rs.close();
		stm.close();
		con.close();
		return m;
	}

	@Override
	public List<Motorista> listar() throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM motorista";
		PreparedStatement stm = con.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		List<Motorista> motoristaList = new ArrayList<>();
		while(rs.next()) {
			Motorista m = new Motorista();
			m.setCodigo(rs.getInt("codigo"));
			m.setNome(rs.getString("nome"));
			m.setNaturalidade(rs.getString("naturalidade"));
			motoristaList.add(m);
		}
		rs.close();
		stm.close();
		con.close();
		return motoristaList;
	}

}

package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Carro;

public class CarroDao implements IDao<Carro> {
	
	private GenericDao gDao;
	
	public CarroDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Carro c) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "INSERT INTO carro VALUES (?,?,?,?,?)";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, c.getPlaca());
		stm.setString(2, c.getMarca());
		stm.setString(3, c.getModelo());
		stm.setInt(4, c.getAno());
		stm.setString(5, c.getCor());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public void atualizar(Carro c) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "UPDATE carro SET marca = ?, modelo = ?, ano = ?, cor = ? WHERE placa = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, c.getMarca());
		stm.setString(2, c.getModelo());
		stm.setInt(3, c.getAno());
		stm.setString(4, c.getCor());
		stm.setString(5, c.getPlaca());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public void excluir(Carro c) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "DELETE FROM carro WHERE placa = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, c.getPlaca());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public List<Carro> listar() throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM carro";
		PreparedStatement stm = con.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		List<Carro> carros = new ArrayList<>();
		while(rs.next()) {
			Carro c = new Carro();
			c.setPlaca(rs.getString("placa"));
			c.setMarca(rs.getString("marca"));
			c.setModelo(rs.getString("modelo"));
			c.setAno(rs.getInt("ano"));
			c.setCor(rs.getString("cor"));
			carros.add(c);
		}
		rs.close();
		stm.close();
		con.close();
		return carros;
	}

	@Override
	public Carro pesquisar(Carro c) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM carro WHERE placa = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, c.getPlaca());
		ResultSet rs = stm.executeQuery();
		if(rs.next()) {
			c.setMarca(rs.getString("marca"));
			c.setModelo(rs.getString("modelo"));
			c.setAno(rs.getInt("ano"));
			c.setCor(rs.getString("cor"));
		}
		rs.close();
		stm.close();
		con.close();
		return c;
	}

}

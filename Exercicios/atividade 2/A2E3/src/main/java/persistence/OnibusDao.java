package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Onibus;


public class OnibusDao implements IDao<Onibus>{

	private GenericDao gDao;
	
	public OnibusDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Onibus o) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "INSERT INTO onibus VALUES (?,?,?,?)";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, o.getPlaca());
		stm.setString(2, o.getMarca());
		stm.setInt(3, o.getAno());
		stm.setString(4, o.getDescricao());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public void atualizar(Onibus o) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "UPDATE onibus SET marca = ?, ano = ?, descricao = ? WHERE placa = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, o.getMarca());
		stm.setInt(2, o.getAno());
		stm.setString(3, o.getDescricao());
		stm.setString(4, o.getPlaca());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public void excluir(Onibus o) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "DELETE FROM onibus WHERE placa = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, o.getPlaca());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public List<Onibus> listar() throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM onibus";
		PreparedStatement stm = con.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		List<Onibus> onibusList = new ArrayList<>();
		while(rs.next()) {
			Onibus o = new Onibus();
			o.setPlaca(rs.getString("placa"));
			o.setMarca(rs.getString("marca"));
			o.setAno(rs.getInt("ano"));
			o.setDescricao(rs.getString("descricao"));
			onibusList.add(o);
		}
		rs.close();
		stm.close();
		con.close();
		return onibusList;
	}

	@Override
	public Onibus pesquisar(Onibus o) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM onibus WHERE placa = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, o.getPlaca());
		ResultSet rs = stm.executeQuery();
		if(rs.next()) {
			o.setMarca(rs.getString("marca"));
			o.setAno(rs.getInt("ano"));
			o.setDescricao(rs.getString("descricao"));
		}
		rs.close();
		stm.close();
		con.close();
		return o;
	}
}
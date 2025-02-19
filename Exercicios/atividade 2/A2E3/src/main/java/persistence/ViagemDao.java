package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Viagem;


public class ViagemDao implements IDao<Viagem>{
	
	private GenericDao gDao;
	
	public ViagemDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Viagem v) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "INSERT INTO viagem VALUES (?,?,?,?,?,?,?)";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setInt(1, v.getCodigo());
		stm.setString(2, v.getOnibus());
		stm.setInt(3, v.getMotorista());
		stm.setInt(4, v.getHora_saida());
		stm.setInt(5, v.getHora_chegada());
		stm.setString(6, v.getPartida());
		stm.setString(7, v.getDestino());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public void atualizar(Viagem v) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "UPDATE viagem SET onibus = ?, motorista = ?, "
				+ "hora_saida = ?, hora_chegada = ?, partida = ?, destino = ? WHERE codigo = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, v.getOnibus());
		stm.setInt(2, v.getMotorista());
		stm.setInt(3, v.getHora_saida());
		stm.setInt(4, v.getHora_chegada());
		stm.setString(5, v.getPartida());
		stm.setString(6, v.getDestino());
		stm.setInt(7, v.getCodigo());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public void excluir(Viagem v) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "DELETE FROM viagem WHERE codigo = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setInt(1, v.getCodigo());
		stm.execute();
		stm.close();
		con.close();
	}

	@Override
	public List<Viagem> listar() throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM viagem";
		PreparedStatement stm = con.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		List<Viagem> viagemList = new ArrayList<>();
		while(rs.next()) {
			Viagem v = new Viagem();
			v.setCodigo(rs.getInt("codigo"));
			v.setOnibus(rs.getString("onibus"));
			v.setMotorista(rs.getInt("motorista"));
			v.setHora_saida(rs.getInt("hora_saida"));
			v.setHora_chegada(rs.getInt("hora_chegada"));
			v.setPartida(rs.getString("partida"));
			v.setDestino(rs.getString("destino"));
			viagemList.add(v);
		}
		rs.close();
		stm.close();
		con.close();
		return viagemList;
	}

	@Override
	public Viagem pesquisar(Viagem v) throws ClassNotFoundException, SQLException {
		Connection con = gDao.getConnection();
		String sql = "SELECT * FROM viagem WHERE codigo = ?";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setInt(1, v.getCodigo());
		ResultSet rs = stm.executeQuery();
		if(rs.next()) {
			v.setOnibus(rs.getString("onibus"));
			v.setMotorista(rs.getInt("motorista"));
			v.setHora_saida(rs.getInt("hora_chegada"));
			v.setHora_chegada(rs.getInt("hora_chegada"));
			v.setPartida(rs.getString("partida"));
			v.setDestino(rs.getString("destino"));
		}
		rs.close();
		stm.close();
		con.close();
		return v;
	}
}
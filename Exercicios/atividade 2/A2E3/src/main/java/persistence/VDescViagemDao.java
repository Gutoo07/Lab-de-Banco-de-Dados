package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.VDescricaoOnibus;
import model.VDescricaoViagem;

public class VDescViagemDao implements VDao<VDescricaoViagem>{
	
	private GenericDao gDao;
	
	public VDescViagemDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public VDescricaoViagem getView(VDescricaoViagem v) throws ClassNotFoundException, SQLException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM v_descricaoViagem WHERE viagem = ?";
		PreparedStatement stm = c.prepareStatement(sql);
		stm.setInt(1, v.getViagem());
		ResultSet rs = stm.executeQuery();
		if(rs.next()) {
			v.setOnibus(rs.getString("Onibus"));
			v.setSaida(rs.getString("Saida"));
			v.setChegada(rs.getString("Chegada"));
			v.setPartida(rs.getString("Partida"));
			v.setDestino(rs.getString("Destino"));
		}
		rs.close();
		stm.close();
		c.close();
		return v;
	}
}

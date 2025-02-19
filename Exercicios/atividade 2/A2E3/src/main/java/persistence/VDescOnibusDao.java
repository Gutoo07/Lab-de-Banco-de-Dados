package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import model.VDescricaoOnibus;
import model.Viagem;

public class VDescOnibusDao implements VDao<VDescricaoOnibus> {
	
	private GenericDao gDao;
	
	public VDescOnibusDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public VDescricaoOnibus getView(VDescricaoOnibus v) throws ClassNotFoundException, SQLException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM v_descricaoOnibus WHERE viagem = ?";
		PreparedStatement stm = c.prepareStatement(sql);
		stm.setInt(1, v.getViagem());
		ResultSet rs = stm.executeQuery();
		if(rs.next()) {
			v.setMotorista(rs.getString("Motorista"));
			v.setOnibus(rs.getString("Onibus"));
			v.setMarca_onibus(rs.getString("Marca_Onibus"));
			v.setAno_onibus(rs.getInt("Ano_Onibus"));
			v.setDescricao_onibus(rs.getString("Descricao_Onibus"));
		}
		rs.close();
		stm.close();
		c.close();
		return v;
	}
}

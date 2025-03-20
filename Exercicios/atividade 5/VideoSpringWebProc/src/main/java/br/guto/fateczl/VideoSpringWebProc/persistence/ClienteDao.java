package br.guto.fateczl.VideoSpringWebProc.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.guto.fateczl.VideoSpringWebProc.model.Cliente;

@Repository
public class ClienteDao implements IDAO<Cliente> {
	
	@Autowired
	private GenericDAO gDAO;
	
	/*private GenericDAO gDAO;
	
	public ClienteDao(GenericDAO gDAO) {
		this.gDAO = gDAO;
	}*/

	@Override
	public String inserir(Cliente c) throws SQLException, ClassNotFoundException {
		Connection con = gDAO.getConnection();
		String sql = "{CALL sp_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "I");
		cs.setString(2, c.getCpf());
		cs.setString(3, c.getNome());
		cs.setString(4, c.getEmail());
		cs.setDouble(5, c.getLimite_de_credito());
		cs.setString(6, c.getDt_nasc().toString());
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(7);
		
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String atualizar(Cliente c) throws SQLException, ClassNotFoundException {
		Connection con = gDAO.getConnection();
		String sql = "{CALL sp_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "U");
		cs.setString(2, c.getCpf());
		cs.setString(3, c.getNome());
		cs.setString(4, c.getEmail());
		cs.setDouble(5, c.getLimite_de_credito());
		cs.setString(6, c.getDt_nasc().toString());
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(7);
		
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String excluir(Cliente c) throws SQLException, ClassNotFoundException {
		Connection con = gDAO.getConnection();
		String sql = "{CALL sp_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "D");
		cs.setString(2, c.getCpf());
		cs.setNull(3, Types.VARCHAR);
		cs.setNull(4, Types.VARCHAR);
		cs.setNull(5, Types.DECIMAL);
		cs.setNull(6, Types.VARCHAR);
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(7);
		
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public Cliente buscar(Cliente c) throws SQLException, ClassNotFoundException {
		Connection con = gDAO.getConnection();
		 String sql = "SELECT nome, email, limite_de_credito, dt_nasc FROM cliente WHERE cpf = ?";
		 PreparedStatement stm = con.prepareStatement(sql);
		 stm.setString(1, c.getCpf());
		 
		 ResultSet rs = stm.executeQuery();
		 if (rs.next()) {
			 c.setNome(rs.getString("nome"));
			 c.setEmail(rs.getString("email"));
			 c.setLimite_de_credito(rs.getDouble("limite_de_credito"));
			 c.setDt_nasc(LocalDate.parse(rs.getString("dt_nasc")));
		 }
		 rs.close();
		 stm.close();
		 con.close();
		 return c;
	}

	@Override
	public List<Cliente> listar() throws SQLException, ClassNotFoundException {
		Connection con = gDAO.getConnection();
		String sql = "SELECT cpf, nome, email, limite_de_credito, CONVERT(CHAR(10),dt_nasc,103) AS dt_nasc FROM cliente";
		PreparedStatement stm = con.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		List<Cliente> clientes = new ArrayList<>();
		while (rs.next()) {
			Cliente c = new Cliente();
			c.setCpf(rs.getString("cpf"));
			c.setNome(rs.getString("nome"));
			c.setEmail(rs.getString("email"));
			c.setLimite_de_credito(rs.getDouble("limite_de_credito"));
			c.setDt_nascStr(rs.getString("dt_nasc"));
			clientes.add(c);
		}
		rs.close();
		stm.close();
		con.close();
		return clientes;
	}	
}
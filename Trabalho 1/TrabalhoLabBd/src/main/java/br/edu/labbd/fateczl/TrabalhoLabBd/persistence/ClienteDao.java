package br.edu.labbd.fateczl.TrabalhoLabBd.persistence;

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

import br.edu.labbd.fateczl.TrabalhoLabBd.model.Cliente;

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
		cs.setString(2, c.getRg());
		cs.setString(3, c.getNome());
		cs.setString(4, c.getTelefone());
		cs.setString(5, c.getDt_nasc().toString());
		cs.setString(6, c.getSenha());
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
		cs.setString(2, c.getRg());
		cs.setString(3, c.getNome());
		cs.setString(4, c.getTelefone());
		cs.setString(5, c.getDt_nasc().toString());
		cs.setString(6, c.getSenha());
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
		cs.setString(2, c.getRg());
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
		 String sql = "SELECT nome, telefone, dt_nasc, senha FROM cliente WHERE rg = ?";
		 PreparedStatement stm = con.prepareStatement(sql);
		 stm.setString(1, c.getRg());
		 
		 ResultSet rs = stm.executeQuery();
		 if (rs.next()) {
			 c.setNome(rs.getString("nome"));
			 c.setTelefone(rs.getString("telefone"));
			 c.setDt_nasc(LocalDate.parse(rs.getString("dt_nasc")));
			 c.setSenha(rs.getString("senha"));
		 }
		 rs.close();
		 stm.close();
		 con.close();
		 return c;
	}

	@Override
	public List<Cliente> listar() throws SQLException, ClassNotFoundException {
		Connection con = gDAO.getConnection();
		String sql = "SELECT rg, nome, telefone, CONVERT(CHAR(10),dt_nasc,103) AS dt_nasc, senha FROM cliente";
		PreparedStatement stm = con.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		List<Cliente> clientes = new ArrayList<>();
		while (rs.next()) {
			Cliente c = new Cliente();
			c.setRg(rs.getString("rg"));
			c.setNome(rs.getString("nome"));
			c.setTelefone(rs.getString("telefone"));
			c.setDt_nascStr(rs.getString("dt_nasc"));
			c.setSenha(rs.getString("senha"));
			clientes.add(c);
		}
		rs.close();
		stm.close();
		con.close();
		return clientes;
	}	
}
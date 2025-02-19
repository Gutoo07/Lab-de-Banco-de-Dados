package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Motorista;
import persistence.GenericDao;
import persistence.MotoristaDao;

@WebServlet("/motorista")
public class MotoristaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MotoristaServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		int codigo = Integer.parseInt(request.getParameter("codigo"));
		 
		Motorista m = new Motorista();
		List<Motorista> motoristaList = new ArrayList<>();
		String erro = "";
		
		try {
			GenericDao gDao = new GenericDao();
			MotoristaDao mDao = new MotoristaDao(gDao);
			m.setCodigo(codigo);
			
			if(acao.equalsIgnoreCase("Excluir")) {
				mDao.excluir(m);
				motoristaList = mDao.listar();
				m = null;
			} else if (acao.equalsIgnoreCase("Editar")) {
				mDao.pesquisar(m);
				motoristaList = null;
			} else {
				m = null;
				motoristaList = null;
			}
		} catch (SQLException | ClassNotFoundException e ) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("motorista", m);
			request.setAttribute("motoristaList", motoristaList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("motorista.jsp");
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Motorista m = new Motorista();
		String codigo = request.getParameter("codigo");
		String nome = request.getParameter("nome");
		String naturalidade = request.getParameter("naturalidade");
		
		String acao = request.getParameter("botao");
		String saida = "";
		String erro = "";	
		
		if (!acao.equalsIgnoreCase("Listar")) {
			m.setCodigo(Integer.parseInt(codigo));
		}
		if (acao.equalsIgnoreCase("Inserir") || acao.equalsIgnoreCase("Atualizar")) {
			m.setNome(nome);
			m.setNaturalidade(naturalidade);
		}
		
		GenericDao gDao = new GenericDao();
		MotoristaDao mDao = new MotoristaDao(gDao);
		List<Motorista> motoristaList = new ArrayList<>();
		
		try {
			if (acao.equalsIgnoreCase("Listar")) {
				motoristaList = mDao.listar();
			}
			if (acao.equalsIgnoreCase("Inserir")) {
				mDao.inserir(m);
				saida = "Motorista #"+m.getCodigo()+" inserido com sucesso.";
			}
			if (acao.equalsIgnoreCase("Excluir")) {
				mDao.excluir(m);
				saida = "Motorista #"+m.getCodigo()+" excluído com sucesso.";
			}
			if (acao.equalsIgnoreCase("Atualizar")) {
				mDao.atualizar(m);
				saida = "Motorista #"+m.getCodigo()+" atualizado com sucesso.";
			}
			if (acao.equalsIgnoreCase("Pesquisar")) {
				m = mDao.pesquisar(m);
			}
		} catch (SQLException | ClassNotFoundException e) {
			
		} finally {
			if (!acao.equalsIgnoreCase("Pesquisar")) {
				m = null;
			}
			if (!acao.equalsIgnoreCase("Listar")) {
				motoristaList = null;
			}
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			request.setAttribute("motorista", m);
			request.setAttribute("motoristaList", motoristaList);
			RequestDispatcher dispatcher =  request.getRequestDispatcher("motorista.jsp");
			dispatcher.forward(request, response);
		}
	}
}
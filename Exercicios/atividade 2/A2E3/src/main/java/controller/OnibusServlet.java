package controller;

import jakarta.servlet.RequestDispatcher; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import persistence.GenericDao;
import persistence.OnibusDao;
import model.Onibus;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/onibus")
public class OnibusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public OnibusServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		String placa = request.getParameter("placa");
		
		Onibus o = new Onibus();
		List<Onibus> onibusList = new ArrayList<>();
		String erro = "";
		
		try {
			GenericDao gDao = new GenericDao();
			OnibusDao oDao = new OnibusDao(gDao);
			
			o.setPlaca(placa);
			
			if(acao.equalsIgnoreCase("Excluir")) {
				oDao.excluir(o);
				onibusList = oDao.listar();
				o = null;
			} else if (acao.equalsIgnoreCase("Editar")) {
				oDao.pesquisar(o);
				onibusList = null;
			} else {
				o = null;
				onibusList = null;
			}
		} catch (SQLException | ClassNotFoundException e ) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("onibus", o);
			request.setAttribute("onibusList", onibusList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("onibus.jsp");
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Onibus o = new Onibus();
		String placa = request.getParameter("placa");
		String marca = request.getParameter("marca");
		String ano = request.getParameter("ano");
		String descricao = request.getParameter("descricao");
		
		String acao = request.getParameter("botao");
		String saida = "";
		String erro = "";
		
		if (!acao.equalsIgnoreCase("Listar")) {
			o.setPlaca(placa);
		}
		if (acao.equalsIgnoreCase("Inserir") || acao.equalsIgnoreCase("Atualizar")) {
			o.setMarca(marca);
			o.setAno(Integer.parseInt(ano));
			o.setDescricao(descricao);
		}
		
		GenericDao gdao = new GenericDao();
		OnibusDao oDao = new OnibusDao(gdao);
		
		List<Onibus> onibusList = new ArrayList<>();
		
		try {
			if (acao.equalsIgnoreCase("Listar")) {
				onibusList = oDao.listar();
			}
			if (acao.equalsIgnoreCase("Inserir")) {
				oDao.inserir(o);
				saida = "Onibus #"+o.getPlaca()+" inserido com sucesso.";
			}
			if (acao.equalsIgnoreCase("Atualizar")) {
				oDao.atualizar(o);
				saida = "Onibus #"+o.getPlaca()+" atualizado com sucesso.";
			}
			if(acao.equalsIgnoreCase("Excluir")) {
				oDao.excluir(o);
				saida = "Onibus #"+o.getPlaca()+" excluído com sucesso.";
			}
			if (acao.equalsIgnoreCase("Pesquisar")) {
				o = oDao.pesquisar(o);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			if (!acao.equalsIgnoreCase("Pesquisar")) {
				o = null;
			}
			if (!acao.equalsIgnoreCase("Listar")) {
				onibusList = null;
			}
			
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			request.setAttribute("onibus", o);
			request.setAttribute("onibusList", onibusList);
			
			RequestDispatcher dispatcher =  request.getRequestDispatcher("onibus.jsp");
			dispatcher.forward(request, response);
		}
	}
}

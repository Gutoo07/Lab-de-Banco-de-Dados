package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Carro;
import persistence.GenericDao;
import persistence.CarroDao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/carro")
public class CarroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CarroServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		String placa = request.getParameter("placa");
		
		Carro c = new Carro();
		List<Carro> carros = new ArrayList<>();
		String erro = "";
		
		try {
			GenericDao gDao = new GenericDao();
			CarroDao cDao = new CarroDao(gDao);
			
			c.setPlaca(placa);
			
			if(acao.equalsIgnoreCase("Excluir")) {
				cDao.excluir(c);
				carros = cDao.listar();
				c = null;
			} else if (acao.equalsIgnoreCase("Editar")) {
				cDao.pesquisar(c);
				carros = null;
			} else {
				c = null;
				carros = null;
			}
		} catch (SQLException | ClassNotFoundException e ) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("carro", c);
			request.setAttribute("carros", carros);
			RequestDispatcher dispatcher = request.getRequestDispatcher("carro.jsp");
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Carro c = new Carro();
		String placa = request.getParameter("placa");
		String marca = request.getParameter("marca");
		String modelo = request.getParameter("modelo");
		String ano = request.getParameter("ano");
		String cor = request.getParameter("cor");
		
		String acao = request.getParameter("botao");
		String saida = "";
		String erro = "";
		
		if (!acao.equalsIgnoreCase("Listar")) {
			c.setPlaca(placa);
		}
		if (acao.equalsIgnoreCase("Inserir") || acao.equalsIgnoreCase("Atualizar")) {
			c.setMarca(marca);
			c.setModelo(modelo);
			c.setAno(Integer.parseInt(ano));
			c.setCor(cor);
		}
		
		GenericDao gdao = new GenericDao();
		CarroDao cDao = new CarroDao(gdao);
		
		List<Carro> carros = new ArrayList<>();
		
		try {
			if (acao.equalsIgnoreCase("Listar")) {
				carros = cDao.listar();
			}
			if (acao.equalsIgnoreCase("Inserir")) {
				cDao.inserir(c);
				saida = "Carro #"+c.getPlaca()+" inserido com sucesso.";
			}
			if (acao.equalsIgnoreCase("Atualizar")) {
				cDao.atualizar(c);
				saida = "Carro #"+c.getPlaca()+" atualizado com sucesso.";
			}
			if(acao.equalsIgnoreCase("Excluir")) {
				cDao.excluir(c);
				saida = "Carro #"+c.getPlaca()+" excluído com sucesso.";
			}
			if (acao.equalsIgnoreCase("Pesquisar")) {
				c = cDao.pesquisar(c);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			if (!acao.equalsIgnoreCase("Pesquisar")) {
				c = null;
			}
			if (!acao.equalsIgnoreCase("Listar")) {
				carros = null;
			}
			
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			request.setAttribute("carro", c);
			request.setAttribute("carros", carros);
			
			RequestDispatcher dispatcher =  request.getRequestDispatcher("carro.jsp");
			dispatcher.forward(request, response);
		}
	}
}

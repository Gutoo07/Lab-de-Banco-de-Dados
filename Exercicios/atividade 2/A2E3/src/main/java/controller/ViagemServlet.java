package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Viagem;
import model.VDescricaoOnibus;
import model.VDescricaoViagem;
import persistence.GenericDao;
import persistence.ViagemDao;
import persistence.VDescOnibusDao;
import persistence.VDescViagemDao;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/viagem")
public class ViagemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public ViagemServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		String codigo = request.getParameter("codigo");
		
		Viagem v = new Viagem();
		List<Viagem> viagemList = new ArrayList<>();
		String erro = "";
		
		try {
			GenericDao gDao = new GenericDao();
			ViagemDao vDao = new ViagemDao(gDao);
			
			v.setCodigo(Integer.parseInt(codigo));
			
			if(acao.equalsIgnoreCase("Excluir")) {
				vDao.excluir(v);
				viagemList = vDao.listar();
				v = null;
			} else if (acao.equalsIgnoreCase("Editar")) {
				vDao.pesquisar(v);
				viagemList = null;
			} else {
				v = null;
				viagemList = null;
			}
		} catch (SQLException | ClassNotFoundException e ) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("viagem", v);
			request.setAttribute("viagemList", viagemList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("viagem.jsp");
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Viagem v = new Viagem();
		VDescricaoOnibus descOnibus = new VDescricaoOnibus();
		VDescricaoViagem descViagem = new VDescricaoViagem();
		String codigo = request.getParameter("codigo");
		String onibus = request.getParameter("onibus");
		String motorista = request.getParameter("motorista");
		String hora_saida = request.getParameter("hora_saida");
		String hora_chegada = request.getParameter("hora_chegada");
		String partida = request.getParameter("partida");
		String destino = request.getParameter("destino");
		
		String acao = request.getParameter("botao");
		String saida = "";
		String erro = "";
		
		if (!acao.equalsIgnoreCase("Listar")) {
			v.setCodigo(Integer.parseInt(codigo));
		}
		if (acao.equalsIgnoreCase("Inserir") || acao.equalsIgnoreCase("Atualizar")) {
			v.setOnibus(onibus);
			v.setMotorista(Integer.parseInt(motorista));
			v.setHora_saida(Integer.parseInt(hora_saida));
			v.setHora_chegada(Integer.parseInt(hora_chegada));
			v.setPartida(partida);
			v.setDestino(destino);
		}
		if (acao.equalsIgnoreCase("Descricao Onibus")) {
			if (!codigo.isBlank()) {
				descOnibus.setViagem(Integer.parseInt(codigo));
			}			
		}
		if (acao.equalsIgnoreCase("Descricao Viagem")) {
			if (!codigo.isBlank()) {
				descViagem.setViagem(Integer.parseInt(codigo));
			}
		}
		
		GenericDao gDao = new GenericDao();
		ViagemDao vDao = new ViagemDao(gDao);
		VDescOnibusDao doDao= new VDescOnibusDao(gDao);
		VDescViagemDao dvDao = new VDescViagemDao(gDao);
		
		List<Viagem> viagemList = new ArrayList<>();
		
		try {
			if (acao.equalsIgnoreCase("Listar")) {
				viagemList = vDao.listar();
			}
			if (acao.equalsIgnoreCase("Inserir")) {
				vDao.inserir(v);
				saida = "Viagem #"+v.getCodigo()+" inserida com sucesso.";
			}
			if (acao.equalsIgnoreCase("Atualizar")) {
				vDao.atualizar(v);
				saida = "Viagem #"+v.getCodigo()+" atualizada com sucesso.";
			}
			if(acao.equalsIgnoreCase("Excluir")) {
				vDao.excluir(v);
				saida = "Viagem #"+v.getCodigo()+" excluída com sucesso.";
			}
			if (acao.equalsIgnoreCase("Pesquisar")) {
				v = vDao.pesquisar(v);
			}
			if (acao.equalsIgnoreCase("Descricao Onibus")) {
				descOnibus = doDao.getView(descOnibus);
			}
			if (acao.equalsIgnoreCase("Descricao Viagem")) {
				descViagem = dvDao.getView(descViagem);
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			if (!acao.equalsIgnoreCase("Pesquisar")) {
				v = null;
			}
			if (!acao.equalsIgnoreCase("Listar")) {
				viagemList = null;
			}
			if (!acao.equalsIgnoreCase("Descricao Onibus")) {
				descOnibus = null;
			}
			if (!acao.equalsIgnoreCase("Descricao Viagem")) {
				descViagem = null;
			}
			
			request.setAttribute("erro", erro);
			request.setAttribute("saida", saida);
			request.setAttribute("viagem", v);
			request.setAttribute("viagemList", viagemList);
			request.setAttribute("descricaoOnibus", descOnibus);
			request.setAttribute("descricaoViagem", descViagem); 
			
			RequestDispatcher dispatcher =  request.getRequestDispatcher("viagem.jsp");
			dispatcher.forward(request, response);
		}
	}
}

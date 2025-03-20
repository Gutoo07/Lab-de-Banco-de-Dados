package br.guto.fateczl.VideoSpringWebProc.controller;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.guto.fateczl.VideoSpringWebProc.model.Cliente;
import br.guto.fateczl.VideoSpringWebProc.persistence.ClienteDao;

@Controller
public class ClienteController {
	
	@Autowired
	private ClienteDao cDao;
	
	/* Nao preciso declarar explicitamente o Servlet pq ja configuramos o Dispatcher*/
	
	/*Se for receber parametros:*/
	@RequestMapping(name = "cliente.jsp", value = "/cliente", method = RequestMethod.GET) //mapeei a chamada dos meus Links
	public ModelAndView clienteGet(@RequestParam Map<String, String> params, ModelMap model) {
		String acao = params.get("acao");
		String cpf = params.get("cpf");
		
		Cliente c = new Cliente();
		List<Cliente> clientes = new ArrayList<>();
		String erro = "";
		try {
			if (cpf != null) {
				c.setCpf(cpf);
				if (acao.equals("excluir")) {
					cDao.excluir(c);
					clientes = cDao.listar();
					c = null;
				} else if (acao.equals("editar")) {
					c = cDao.buscar(c);
					clientes = null;
				} else {
					c = null;
					clientes = null;
				}
			}
		} catch (SQLException | ClassNotFoundException e ){
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("cliente", c);
			model.addAttribute("clientes", clientes);
		}
				
		return new ModelAndView("cliente.jsp");
	}
	
	@RequestMapping(name = "cliente.jsp", value = "/cliente", method = RequestMethod.POST)
	public ModelAndView clientePost(@RequestParam Map<String, String> params, ModelMap model) {
		String cpf = params.get("cpf");
		String nome = params.get("nome");
		String email = params.get("email");
		String limite_de_credito = params.get("limite_de_credito");
		String dt_nasc = params.get("dt_nasc");
		String acao = params.get("botao");
		
		Cliente c = new Cliente();
		if (!acao.equalsIgnoreCase("Listar")) {
			c.setCpf(cpf);			
		}
		if (acao.equalsIgnoreCase("Inserir") || acao.equalsIgnoreCase("Atualizar")) {
			c.setNome(nome);
			c.setEmail(email);
			c.setLimite_de_credito(Double.parseDouble(limite_de_credito));
			c.setDt_nasc(LocalDate.parse(dt_nasc));
		}
		String saida = "";
		String erro = "";
		List<Cliente> clientes = new ArrayList<>();
		
		try {
			if (acao.equalsIgnoreCase("Inserir")) {
				saida = cDao.inserir(c);				  
			}
			if (acao.equalsIgnoreCase("Atualizar")) {
				saida = cDao.atualizar(c);
			}
			if (acao.equalsIgnoreCase("Excluir")) {
				saida = cDao.excluir(c);
			}
			if (acao.equalsIgnoreCase("Buscar")) {
				c = cDao.buscar(c);
			}
			if (acao.equalsIgnoreCase("Listar")) {
				clientes = cDao.listar();
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("cliente", c);
			model.addAttribute("clientes", clientes);
		}
		
		return new ModelAndView("cliente.jsp");
	}
	
	
	
	
	
	
}

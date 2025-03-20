<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cliente</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
	<div align="center">
		<jsp:include page="menu.jsp"></jsp:include>
	</div>
	<br />
	<div class="conteiner" align="center">
		<h1>Cadastro de Clientes</h1>
		<br />
		<form action="cliente" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3"> 
						<input type="text" min="0" name="cpf" id="cpf" placeholder="CPF" value='<c:out value="${cliente.cpf }" />'>
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Buscar" class="btn btn-dark"> <!-- nao usar Button para form -->
					</td>					
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="nome" id="nome" placeholder="Nome" value='<c:out value="${cliente.nome }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="email" id="email" placeholder="Email" value='<c:out value="${cliente.email }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="number" min="0.0" name="limite_de_credito" id="limite_de_credito" value='<c:out value="${cliente.limite_de_credito }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="date" name="dt_nasc" id="dt_nasc" value='<c:out value="${cliente.dt_nasc }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao" value="Inserir" class="btn btn-dark"></td>
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao" value="Atualizar" class="btn btn-dark"></td>
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao" value="Excluir" class="btn btn-dark"></td>
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao" value="Listar" class="btn btn-dark"></td>
				</tr>
			</table>	
		</form>	
	</div>
	<br />
	<!--  Saidas e Mensagens de Sucesso -->
	<div class="conteiner" align="center">
		<c:if test="${not empty saida }">
			<h2 style="color: green;"><c:out value="${saida }" /></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty erro }">
			<h2 style="color: red;"><c:out value="${erro }" /></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty clientes }">
			<table class="table table-dark table-striped-columns">
				<thead>
					<tr>
						<th>CPF</th>
						<th>Nome</th>
						<th>Email</th>
						<th>Limite</th>
						<th>Nasc</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${clientes }">
						<tr>
							<td>${c.cpf }</td>
							<td>${c.nome }</td>
							<td>${c.email }</td>
							<td>${c.limite_de_credito }</td>
							<td>${c.dt_nascStr }</td>
							<td><a href="${pageContext.request.contextPath }/cliente?acao=editar&cpf=${c.cpf}">Editar</a></td>
							<td><a href="${pageContext.request.contextPath }/cliente?acao=excluir&cpf=${c.cpf}">Excluir</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>











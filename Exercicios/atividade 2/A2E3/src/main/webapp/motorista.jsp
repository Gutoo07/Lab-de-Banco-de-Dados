<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Onibus</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
	<br />
	<div class="conteiner" align="center">
		<h1>CRUD Motorista</h1>
		<br />
		<form action="motorista" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="number" name="codigo" id="codigo"placeholder="Codigo"
							value='<c:out value="${motorista.codigo }" />'>
					</td>
					<td>
						<input type="submit" name="botao" id="botao"
							value="Pesquisar" class="btn btn-primary">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="text" name="nome" id="nome" placeholder="Nome"
							value='<c:out value="${motorista.nome }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="text" name="naturalidade" id="naturalidade"
							placeholder="Naturalidade" value='<c:out value="${motorista.naturalidade }" />'>
					</td>
				</tr>
			</table>
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td><input type="submit" name="botao" id="botao" value="Inserir"
						style="margin: 0 2px;" class="btn btn-primary"></td>
					<td><input type="submit" name="botao" id="botao" value="Atualizar"
						style="margin: 0 2px;" class="btn btn-primary"></td>
					<td><input type="submit" name="botao" id="botao" value="Excluir"
						style="margin: 0 2px;" class="btn btn-primary"></td>
					<td><input type="submit" name="botao" id="botao" value="Listar"
						style="margin: 0 2px;" class="btn btn-primary"></td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<div class="conteiner" align="center">
		<c:if test="${not empty saida }">
			<h2 style="color: green;"><c:out value="${saida }"></c:out></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty erro }">
			<h2 style="color: orange;"><c:out value="${erro }"></c:out></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty motoristaList }">
			<table class="table table-dark table-striped-columns">
				<thead>
					<tr>
						<th>
						<th>Codigo</th>
						<th>Nome</th>
						<th>Naturalidade</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="m" items="${motoristaList }">
						<tr>
							<td>${m.codigo }</td>
							<td>${m.nome }</td>
							<td>${m.naturalidade }</td>
							<td><a href="${pageContext.request.contextPath }
								/motorista?acao=editar&codigo=${m.codigo }">Editar</a></td>
							<td><a href="${pageContext.request.contextPath }
								/motorista?acao=excluir&codigo=${m.codigo }">Excluir</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>





</body>
</html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Onibus</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
	<br />
	<div class="conteiner" align="center">
		<h1>CRUD Ônibus</h1>
		<br />
		<form action="onibus" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="text" name="placa" id="placa"
							placeholder="Placa" value='<c:out value="${onibus.placa }" />'>
					</td>
					<td>
						<input type="submit" name="botao" id="botao"
							value="Pesquisar" class="btn btn-success">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="text" name="marca" id="marca"
							placeholder="Marca" value='<c:out value="${onibus.marca }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="number" name="ano" id="ano" min="0"
						step="1" placeholder="Ano" value='<c:out value="${onibus.ano }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="text" name="descricao" id="descricao"
						placeholder="Descricao" value='<c:out value="${onibus.descricao }" />'>
					</td>
				</tr>
			</table>
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td><input type="submit" name="botao" id="botao" value="Inserir"
						style="margin: 0 2px;" class="btn btn-success"> </td>
					<td><input type="submit" name="botao" id="botao" value="Atualizar"
						style="margin: 0 2px;" class="btn btn-success"> </td>
					<td><input type="submit" name="botao" id="botao" value="Excluir"
						style="margin: 0 2px;" class="btn btn-success"> </td>
					<td><input type="submit" name="botao" id="botao" value="Listar"
						style="margin: 0 2px;" class="btn btn-success"> </td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<div class="conteiner" align="center">
		<c:if test="${not empty saida }">
			<h2 style="color:green;"><c:out value="${saida }"></c:out></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty erro }">
			<h2 style="color:orange;"><c:out value="${erro }"></c:out></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty onibusList }">
			<table class="table table-dark table-striped-columns">
				<thead>
					<tr>
						<th>Placa</th>
						<th>Marca</th>
						<th>Ano</th>
						<th>Descricao</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="o" items="${onibusList }">
						<tr>
							<td>${o.placa }</td>
							<td>${o.marca }</td>
							<td>${o.ano }</td>
							<td>${o.descricao }</td>
							<td><a href="${pageContext.request.contextPath }
								/onibus?acao=editar&placa=${o.placa }">Editar</a></td>
							<td><a href="${pageContext.request.contextPath }
								/onibus?acao=excluir&placa=${o.placa }">Excluir</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>
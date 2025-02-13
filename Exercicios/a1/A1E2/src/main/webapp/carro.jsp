<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/styles.css">
<title>Carro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
	<br />
	<div class="conteiner" align="center">
		<h1>Cadastro de Carros</h1>
		<br />
		<form action="carro" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="text" name="placa" id="placa" placeholder="Placa" value='<c:out value="${carro.placa }" />'>
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Pesquisar" class="btn btn-success">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="5">
						<input type="text" name="marca" id="marca" placeholder="Marca" value='<c:out value="${carro.marca }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td>
						<input type="text" name="modelo" id="modelo" placeholder="Modelo" value='<c:out value="${carro.modelo }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td>
						<input type="number" name="ano" id="ano" placeholder="Ano" value='<c:out value="${carro.ano }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td>
						<input type="text" name="cor" id="cor" placeholder="Cor" value='<c:out value="${carro.cor }" />'>
					</td>
				</tr>
			</table>
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td><input type="submit" name="botao" id="botao" value="Inserir" style="margin: 0 2px;" class="btn btn-success"></td>
					<td><input type="submit" name="botao" id="botao" value="Atualizar" style="margin: 0 2px;" class="btn btn-success"></td>
					<td><input type="submit" name="botao" id="botao" value="Excluir" style="margin: 0 2px;" class="btn btn-success"></td>
					<td><input type="submit" name="botao" id="botao" value="Listar" style="margin: 0 2px;" class="btn btn-success"></td>
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
	<div>
		<c:if test="${not empty erro }">
			<h2 style="color:red;"><c:out value="${erro }"></c:out></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty carros }">
			<table class="table table-dark table-striped-columns">
				<thead>
					<tr>
						<th>Placa</th>
						<th>Marca</th>
						<th>Modelo</th>
						<th>Ano</th>
						<th>Cor</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${carros }">
						<tr>
							<td>${c.placa }</td>
							<td>${c.marca }</td>
							<td>${c.modelo }</td>
							<td>${c.ano }</td>
							<td>${c.cor }</td>
							<td><a href="${pageContext.request.contextPath }/carro?acao=editar&placa=${c.placa }">Editar</a></td>
							<td><a href="${pageContext.request.contextPath }/carro?acao=excluir&placa=${c.placa }">Excluir</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>








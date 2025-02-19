<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Viagem</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>
	<br />
	<div class="conteiner" align="center">
		<h1>CRUD Viagens</h1>
		<br />
		<form action="viagem" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="number" name="codigo" id="codigo" placeholder="Código"
							value='<c:out value="${viagem.codigo }" />'>
					</td>
					<td>
						<input type="submit" name="botao" id="botao"
							value="Pesquisar" class="btn btn-dark">
					</td>
					<td>
						<input type="submit" name="botao" id="botao" value="Descricao Onibus"
							style="margin: 0 2px;" class="btn btn-info">
					</td>
					<td>
						<input type="submit" name="botao" id="botao" value="Descricao Viagem"
							style="margin: 0 2px;" class="btn btn-info">
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3">
						<input type="text" name="onibus" id="onibus" placeholder="Placa do Ônibus"
							value='<c:out value="${viagem.onibus }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td>
						<input type="number" name="motorista" id="motorista" placeholder="Código do Motorista"
							value='<c:out value="${viagem.motorista }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td>
						<input type="number" name="hora_saida" id="hora_saida" placeholder="Saída"
							min="0" max="23" step="1" value='<c:out value="${viagem.hora_saida }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td>
						<input type="number" name="hora_chegada" id="hora_chegada" placeholder="Chegada"
							min="0" max="23" step="1" value='<c:out value="${viagem.hora_chegada }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td>
						<input type="text" name="partida" id="partida" placeholder="Local de Partida"
							value='<c:out value="${viagem.partida }" />'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td>
						<input type="text" name="destino" id="destino" placeholder="Local de Destino"
							value='<c:out value="${viagem.destino }" />'>
					</td>
				</tr>
			</table>
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td><input type="submit" name="botao" id="botao" value="Inserir"
						style="margin: 0 2px;" class="btn btn-dark"></td>
					<td><input type="submit" name="botao" id="botao" value="Atualizar"
						style="margin: 0 2px;" class="btn btn-dark"></td>
					<td><input type="submit" name="botao" id="botao" value="Excluir"
						style="margin: 0 2px;" class="btn btn-dark"></td>
					<td><input type="submit" name="botao" id="botao" value="Listar"
						style="margin: 0 2px;" class="btn btn-dark"></td>					
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
			<h2 style="color:orange;"><c:out value="${erro }"></c:out></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty viagemList }">
			<table class="table table-dark table-striped-columns">
				<thead>
					<tr>
						<th>Codigo</th>
						<th>Onibus</th>
						<th>Motorista</th>
						<th>Saída</th>
						<th>Chegada</th>
						<th>Partida</th>
						<th>Destino</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="v" items="${viagemList }">
						<tr>
							<td>${v.codigo }</td>
							<td>${v.onibus }</td>
							<td>${v.motorista }</td>
							<td>${v.hora_saida }:00</td>
							<td>${v.hora_chegada }:00</td>
							<td>${v.partida }</td>
							<td>${v.destino }</td>
							<td><a href="${pageContext.request.contextPath }/viagem?acao=editar&codigo=${v.codigo }">Editar</a></td>
							<td><a href="${pageContext.request.contextPath }/viagem?acao=excluir&codigo=${v.codigo }">Excluir</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty descricaoOnibus }">
			<table class="table table-info table-striped-columns">
				<thead>
					<tr>
						<th>Viagem</th>
						<th>Motorista</th>
						<th>Onibus</th>
						<th>Marca_Onibus</th>
						<th>Ano_Onibus</th>
						<th>Descricao_Onibus</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${descricaoOnibus.viagem }</td>
						<td>${descricaoOnibus.motorista }</td>
						<td>${descricaoOnibus.onibus }</td>
						<td>${descricaoOnibus.marca_onibus }</td>
						<td>${descricaoOnibus.ano_onibus }</td>
						<td>${descricaoOnibus.descricao_onibus }</td>
					</tr>
				</tbody>
			</table>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty descricaoViagem }">
			<table class="table table-info table-striped-columns">
				<thead>
					<tr>
						<th>Viagem</th>
						<th>Onibus</th>
						<th>Saida</th>
						<th>Chegada</th>
						<th>Partida</th>
						<th>Destino</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${descricaoViagem.viagem }</td>
						<td>${descricaoViagem.onibus }</td>
						<td>${descricaoViagem.saida }</td>
						<td>${descricaoViagem.chegada }</td>
						<td>${descricaoViagem.partida }</td>
						<td>${descricaoViagem.destino }</td>
					</tr>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>
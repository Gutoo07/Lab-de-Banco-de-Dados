<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<title>Trabalho Lab BD 1</title>
</head>
<body>
	<div align="center">
		<jsp:include page="menu.jsp"></jsp:include>
	</div>
	<div align="center">
		<br />
		<h1>Clínica</h1>
		<br />		
	</div>
	<div class="conteiner" align="center">
		<h1>Cadastro de Clientes</h1>
		<br />
		<form action="index" method="post">
			<table>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="3"> 
						<input type="text" min="0" name="rg" id="rg" placeholder="RG"/>'>
					</td>				
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td colspan="4">
						<input type="text" name="senha" id="senha" placeholder="Senha"/>'>
					</td>
				</tr>
				<tr style="border-bottom: solid white 12px;">
					<td><input style="margin: 0 2px;" type="submit" id="botao" name="botao" value="Login" class="btn btn-dark"></td>
				</tr>
			</table>	
		</form>	
	</div>
</body>
</html>
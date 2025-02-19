package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Viagem {

	private int codigo;
	private String onibus;
	private int motorista;
	private int hora_saida;
	private int hora_chegada;
	private String partida;
	private String destino;
}

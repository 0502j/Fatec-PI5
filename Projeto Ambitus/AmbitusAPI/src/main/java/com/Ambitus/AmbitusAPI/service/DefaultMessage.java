package com.Ambitus.AmbitusAPI.service;

import com.Ambitus.AmbitusAPI.entities.Evento;

public class DefaultMessage {
	
	private Evento evento;
	public DefaultMessage(Evento evento) {
		this.evento = evento;
	}
	
	public String getDefaultMessage() {
		StringBuilder msg = new StringBuilder();
		msg.append("<h3><b>Dados do evento:</b></h3><br>")
		.append("<b>Titulo</b>:").append(evento.getTitulo()).append("<br>")
		.append("<b>Descrição</b>:").append(evento.getDescricao()).append("<br>")
		.append("<b>Local</b>:").append(evento.getLocal()).append("<br>")
		.append("<b>Data</b>:").append(evento.getData()).append("<br>")
		.append("<b>Hora</b>:").append(evento.getHora()).append("<br>")
		.append("<b>Tipo</b>:").append(evento.getTipo()).append("<br>")
		.append("<b>Contato Organizador</b>:").append(evento.getOrganizador().getEmail()).append("<br>");
		
		return msg.toString();
		
	}

}

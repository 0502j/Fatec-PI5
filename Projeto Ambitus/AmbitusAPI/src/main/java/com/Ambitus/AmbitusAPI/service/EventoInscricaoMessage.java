package com.Ambitus.AmbitusAPI.service;

import com.Ambitus.AmbitusAPI.entities.Evento;

public class EventoInscricaoMessage extends DefaultMessage implements EventoNotificacao{
	
	public EventoInscricaoMessage(Evento evento) {
		super(evento);
	}
	@Override
	public String getMensagemEvento() {
		StringBuilder msg = new StringBuilder();
		msg.append("<h3><b>Inscrição Confirmada,agradecemos por sua iniciativa!</b></h3>");
		msg.append(super.getDefaultMessage());
		return msg.toString();
	}
}

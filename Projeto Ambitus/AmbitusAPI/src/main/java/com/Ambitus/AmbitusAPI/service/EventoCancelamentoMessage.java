package com.Ambitus.AmbitusAPI.service;

import com.Ambitus.AmbitusAPI.entities.Evento;

public class EventoCancelamentoMessage extends DefaultMessage implements EventoNotificacao{
	
	public EventoCancelamentoMessage(Evento evento) {
		super(evento);
	}
	@Override
	public String getMensagemEvento() {
		StringBuilder msg = new StringBuilder();
		msg.append("<h3><b>Inscrição Cancelada, sentiremos sua falta!</b></h3>");
		msg.append(super.getDefaultMessage());
		return msg.toString();
	}
}

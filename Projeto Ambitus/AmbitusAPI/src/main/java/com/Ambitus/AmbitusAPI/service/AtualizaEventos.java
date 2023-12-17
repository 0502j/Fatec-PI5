package com.Ambitus.AmbitusAPI.service;

import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.Ambitus.AmbitusAPI.entities.Evento;
import com.Ambitus.AmbitusAPI.entities.Evento.StatusEvento;
import com.Ambitus.AmbitusAPI.repositories.EventoRepository;

@Service
public class AtualizaEventos {
	@Autowired
	private EventoRepository repository;
	
	@Scheduled(fixedDelay = 10,timeUnit = TimeUnit.MINUTES)
	void atualizaEventosExpirados(){
		for(Evento e:repository.getEventosExpirados()) {
			e.setStatus(StatusEvento.CONCLUIDO);
			repository.save(e);
		} 
	}
}

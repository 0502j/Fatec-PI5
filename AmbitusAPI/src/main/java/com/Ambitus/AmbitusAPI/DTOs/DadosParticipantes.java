package com.Ambitus.AmbitusAPI.DTOs;

import java.util.Set;

import com.Ambitus.AmbitusAPI.entities.Evento;
import com.Ambitus.AmbitusAPI.entities.Usuario;

public record DadosParticipantes(String titulo,Set<Usuario> participantes) {
	 public DadosParticipantes(Evento evento) {
		this(evento.getTitulo(),evento.getParticipantes());
	}
}

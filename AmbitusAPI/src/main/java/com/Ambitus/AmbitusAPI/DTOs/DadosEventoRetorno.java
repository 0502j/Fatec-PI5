package com.Ambitus.AmbitusAPI.DTOs;

import java.time.LocalDate;
import java.time.LocalTime;

import com.Ambitus.AmbitusAPI.entities.Evento;
import com.Ambitus.AmbitusAPI.entities.Evento.OpcaoEvento;
import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.validation.constraints.NotBlank;

public record DadosEventoRetorno(@NotBlank String titulo, @NotBlank String descricao, @NotBlank String local,
		@JsonFormat(pattern = "dd/MM/yyyy") LocalDate data, LocalTime hora, OpcaoEvento tipo,String image,Organizador organizador) {
	
	
	public DadosEventoRetorno(Evento evento){
		this(evento.getTitulo(),evento.getDescricao(),evento.getLocal(),evento.getData(),evento.getHora(),evento.getTipo(),evento.getImage(),new Organizador(evento.getOrganizador().getEmail(),evento.getOrganizador().getId()));
	}

}

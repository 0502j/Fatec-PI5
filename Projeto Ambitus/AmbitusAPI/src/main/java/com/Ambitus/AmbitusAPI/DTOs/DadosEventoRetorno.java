package com.Ambitus.AmbitusAPI.DTOs;

import java.time.LocalDate;
import java.time.LocalTime;

import com.Ambitus.AmbitusAPI.entities.Cupom;
import com.Ambitus.AmbitusAPI.entities.Evento;
import com.Ambitus.AmbitusAPI.entities.Evento.OpcaoEvento;
import com.Ambitus.AmbitusAPI.entities.Usuario;
import com.fasterxml.jackson.annotation.JsonFormat;

public record DadosEventoRetorno(Long id,String titulo,  String descricao,  String local,
		@JsonFormat(pattern = "dd/MM/yyyy") LocalDate data, LocalTime hora, OpcaoEvento tipo,String image,Organizador organizador,Boolean isOwner,DadosCupom cupom) {
	
	
	public DadosEventoRetorno(Evento evento,Usuario usuario){
		this(evento.getId(),evento.getTitulo(),evento.getDescricao(),evento.getLocal(),evento.getData(),evento.getHora(),evento.getTipo(),evento.getImage(),new Organizador(evento.getOrganizador().getEmail(),evento.getOrganizador().getId(),evento.getOrganizador().getNome()),evento.getOrganizador().getId().equals(usuario.getId()),DadosCupom.getDadosCupom(evento.getCupom()));
	}
	
	public DadosEventoRetorno(Evento evento) {
		this(evento.getId(),evento.getTitulo(),evento.getDescricao(),evento.getLocal(),evento.getData(),evento.getHora(),evento.getTipo(),evento.getImage(),new Organizador(evento.getOrganizador().getEmail(),evento.getOrganizador().getId(),evento.getOrganizador().getNome()),true,DadosCupom.getDadosCupom(evento.getCupom()));
	}

}

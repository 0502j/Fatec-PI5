package com.Ambitus.AmbitusAPI.DTOs;

import java.time.LocalDate;

import com.Ambitus.AmbitusAPI.entities.Cupom;
import com.Ambitus.AmbitusAPI.entities.Evento.StatusEvento;
import com.fasterxml.jackson.annotation.JsonFormat;

public record DadosCupom(String titulo,String descricao,@JsonFormat(pattern = "dd/MM/yyyy")LocalDate validade,String codigo) {
	public DadosCupom(Cupom cupom) {
		this(cupom.getTitulo(),cupom.getDescricao(),cupom.getValidade(),cupom.getCodigo());
	}
	
	public static DadosCupom getDadosCupom(Cupom cupom) {
		if(cupom!=null) {
			return new DadosCupom(cupom);
		}
		return null;
	}
}

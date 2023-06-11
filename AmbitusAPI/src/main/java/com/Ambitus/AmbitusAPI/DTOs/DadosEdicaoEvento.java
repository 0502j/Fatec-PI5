package com.Ambitus.AmbitusAPI.DTOs;

import java.time.LocalDate;
import java.time.LocalTime;

import com.Ambitus.AmbitusAPI.entities.Evento.OpcaoEvento;
import com.fasterxml.jackson.annotation.JsonFormat;

public record DadosEdicaoEvento(String titulo,String descricao,String local,@JsonFormat(pattern = "dd/MM/yyyy") LocalDate data,LocalTime hora,OpcaoEvento tipo,String image) {

}

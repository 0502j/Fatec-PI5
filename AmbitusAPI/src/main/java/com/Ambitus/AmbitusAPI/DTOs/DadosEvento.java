package com.Ambitus.AmbitusAPI.DTOs;

import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.Ambitus.AmbitusAPI.entities.Evento.OpcaoEvento;
import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.validation.constraints.NotBlank;

public record DadosEvento(@NotBlank String titulo, @NotBlank String descricao, @NotBlank String local,
		@JsonFormat(pattern = "dd/MM/yyyy") LocalDate data, LocalTime hora, OpcaoEvento tipo,String image) {
}

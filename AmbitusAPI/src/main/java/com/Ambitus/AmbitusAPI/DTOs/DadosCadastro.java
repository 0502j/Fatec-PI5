package com.Ambitus.AmbitusAPI.DTOs;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record DadosCadastro(
		@NotBlank
		String nome,
		@NotNull
		Integer idade,
		@NotBlank
		String sexo,
		@Email
		String email,
		@NotBlank
		String senha,
		String image
		) {

}

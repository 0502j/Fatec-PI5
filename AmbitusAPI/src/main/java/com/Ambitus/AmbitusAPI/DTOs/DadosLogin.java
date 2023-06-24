package com.Ambitus.AmbitusAPI.DTOs;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record DadosLogin(
		@Email
		String email,
		@NotBlank
		String senha) {

}

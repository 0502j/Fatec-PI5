package com.Ambitus.AmbitusAPI.infra;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GerenciamentoExcecoes {
	
	@ExceptionHandler(MethodArgumentNotValidException.class)
	public ResponseEntity<List<CampoInvalido>> noArguments(MethodArgumentNotValidException arguments){
		List<FieldError> erros = arguments.getFieldErrors();
		return ResponseEntity.badRequest().body(erros.stream().map(CampoInvalido::new).toList());
	}
	
	
	public record CampoInvalido(String campo,String mensagem) {
		CampoInvalido(FieldError fError){
			this(fError.getField(),fError.getDefaultMessage());
		}
	}
}

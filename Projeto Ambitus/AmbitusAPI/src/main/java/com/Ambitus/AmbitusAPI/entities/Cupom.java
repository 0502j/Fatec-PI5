package com.Ambitus.AmbitusAPI.entities;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "cupom")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Cupom {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String titulo;
	private String descricao;
	private String codigo;
	private LocalDate validade;
	@OneToOne(mappedBy = "cupom",fetch = FetchType.LAZY)
	@Getter(onMethod = @__(@JsonIgnore))
	private Evento evento;
	
	public Cupom(String titulo,String descricao,LocalDate validade,String codigo) {
		this.titulo = titulo;
		this.descricao = descricao;
		this.validade = validade;
		this.codigo = codigo;
	}
	
	
}

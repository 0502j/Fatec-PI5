package com.Ambitus.AmbitusAPI.entities;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Set;

import com.Ambitus.AmbitusAPI.DTOs.DadosEvento;
import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "evento")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
@Getter
public class Evento {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String titulo;
	private String descricao;
	private String local;
	private LocalDate data;
	private LocalTime hora;
	@Enumerated(EnumType.STRING)
	private OpcaoEvento tipo;
	@Getter(onMethod = @__(@JsonIgnore))
	@ManyToOne
	@JoinColumn(name = "id_organizador")
	private Usuario organizador;
	private String image;
	
	@Getter(onMethod = @__(@JsonIgnore))
	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "evento_participante",
	joinColumns = @JoinColumn(name = "evento_id"),
	inverseJoinColumns = @JoinColumn(name = "participante_id"))
	private Set<Usuario> participantes;
	
	
	public Evento(DadosEvento dados,Usuario usuario) {
		this.titulo = dados.titulo();
		this.descricao = dados.descricao();
		this.local = dados.local();
		this.data = dados.data();
		this.hora = dados.hora();
		this.tipo = dados.tipo();
		this.image = dados.image();
		this.organizador = usuario;
	}
	
	 public static enum OpcaoEvento{
		RECICLAGEM,
		REFLORESTAMENTO,
		LIMPEZA_DE_AMBIENTES,
		CONSCIENTIZACAO_E_EDUCACAO,
		CONSERVACAO_DE_ESPECIES;
	}

}

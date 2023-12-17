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
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "evento")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
@Getter
@Setter
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
	
	@Enumerated(EnumType.STRING)
	@Setter
	private StatusEvento status;
	
	@OneToOne
	@JoinColumn(name = "cupom_id")
	@Getter(onMethod = @__(@JsonIgnore))
	private Cupom cupom;
	
	
	public Evento(DadosEvento dados,Usuario usuario,Cupom cupom) {
		this.status = StatusEvento.ABERTO;
		this.titulo = dados.titulo();
		this.descricao = dados.descricao();
		this.local = dados.local();
		this.data = dados.data();
		this.hora = dados.hora();
		this.tipo = dados.tipo();
		this.image = dados.imagem();
		this.organizador = usuario;
		this.cupom = cupom;
	}
	
	 public static enum OpcaoEvento{
		RECICLAGEM,
		REFLORESTAMENTO,
		LIMPEZA_DE_AMBIENTES,
		CONSCIENTIZACAO_E_EDUCACAO,
		CONSERVACAO_DE_ESPECIES;
	}
	 
	public static enum StatusEvento{
		ABERTO,
		CONCLUIDO,
		CANCELADO
	}

	public void atualizarDados(DadosEvento dados) {
		if(dados.titulo()!=null)
			this.titulo = dados.titulo();
		if(dados.descricao()!=null)
			this.descricao = dados.descricao();
		if(dados.local()!=null)
			this.local = dados.local();
		if(dados.data()!=null)
			this.data = dados.data();
		if(dados.hora()!=null)
			this.hora = dados.hora();
		if(dados.tipo()!=null)
			this.tipo = dados.tipo();
		if(dados.imagem()!=null)
			this.image = dados.imagem();
	}
}

package com.Ambitus.AmbitusAPI.entities;

import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "medalha")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Medalha {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String nome;
	private String descricao;
	private Integer req_nivel;
	private String imagem;
	//Usuários que possuem a medalha
	@Getter(onMethod = @__(@JsonIgnore))
	@ManyToMany
	@JoinTable(name = "medalha_usuario",joinColumns = @JoinColumn(name = "medalha_id"),inverseJoinColumns = @JoinColumn(name = "user_id"))
	private Set<Usuario> usuarios;
	
	
	
}

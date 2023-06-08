package com.Ambitus.AmbitusAPI.entities;

import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.Ambitus.AmbitusAPI.DTOs.DadosCadastro;
import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name="usuario")
@Getter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class Usuario implements UserDetails{
	private static final long serialVersionUID = -3956492689524663717L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String nome;
	@Getter(onMethod = @__(@JsonIgnore))
	private Integer idade;
	@Getter(onMethod = @__(@JsonIgnore))
	private String sexo;
	private String email;
	@Getter(onMethod = @__(@JsonIgnore))
	private String senha;
	@Getter(onMethod = @__(@JsonIgnore))
	@ManyToMany(mappedBy = "participantes",fetch = FetchType.EAGER)
	private Set<Evento> eventosInscrito;
	
	public Usuario(DadosCadastro dados) {
		this.nome = dados.nome();
		this.idade = dados.idade();
		this.sexo = dados.sexo();
		this.email = dados.email();
		this.senha = dados.senha();
	}

	public void criptografarSenha(BCryptPasswordEncoder encoder) {
		this.senha = encoder.encode(this.senha);
	}

	@Override
	@JsonIgnore
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority("ROLE_USER"));
	}

	@Override
	@JsonIgnore
	public String getPassword() {
		return senha;
	}

	@Override
	@JsonIgnore
	public String getUsername() {
		return email;
	}

	@Override
	@JsonIgnore
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	@JsonIgnore
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	@JsonIgnore
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	@JsonIgnore
	public boolean isEnabled() {
		return true;
	}
}

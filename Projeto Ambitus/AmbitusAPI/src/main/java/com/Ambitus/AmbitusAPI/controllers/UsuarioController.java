package com.Ambitus.AmbitusAPI.controllers;

import java.net.URI;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.Ambitus.AmbitusAPI.DTOs.DadosCadastro;
import com.Ambitus.AmbitusAPI.DTOs.DadosLogin;
import com.Ambitus.AmbitusAPI.DTOs.DadosUsuario;
import com.Ambitus.AmbitusAPI.Security.JWTTokenGenerate;
import com.Ambitus.AmbitusAPI.entities.Cupom;
import com.Ambitus.AmbitusAPI.entities.Usuario;
import com.Ambitus.AmbitusAPI.entities.Evento.StatusEvento;
import com.Ambitus.AmbitusAPI.repositories.UsuarioRepository;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/usuario")
public class UsuarioController {
	
	@Autowired
	private UsuarioRepository usuarioRepository;
	@Autowired
	private AuthenticationManager authManager;
	@Autowired
	private JWTTokenGenerate tokenGenerate;

	
	@PostMapping("/cadastro")
	public ResponseEntity<Void> cadastrar(@RequestBody @Valid DadosCadastro dados,UriComponentsBuilder uriBuilder) {
		Usuario user = new Usuario(dados);
		user.criptografarSenha(new BCryptPasswordEncoder());
		usuarioRepository.save(user);
		URI uri = URI.create(uriBuilder.path("/usuario/{id}").build(user.getId()).toString());
		return ResponseEntity.created(uri).build();
	}
	
	@PostMapping("/login")
	public ResponseEntity<UsuarioController.TokenAccess> login(@RequestBody @Valid DadosLogin dados){
		UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(dados.email(),dados.senha());
		Authentication auth = authManager.authenticate(authToken);
		Usuario user = (Usuario)auth.getPrincipal();
		String tokenAcesso = tokenGenerate.genToken((Usuario)auth.getPrincipal());
		return ResponseEntity.accepted().body(new TokenAccess(tokenAcesso,user.getNome(),user.getImage(),user.getNivel()));
	}
	
	@GetMapping("/dados")
	public ResponseEntity<DadosUsuario> dadosUsuario(){
		Usuario user =(Usuario)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Cupom> cuponsUsuario = user.getEventosInscrito().stream().map(e->e.getCupom()).filter(c->c!=null && c.getValidade().isAfter(LocalDate.now())).toList();
		List<Cupom>cuponsUsuarioFiltrados = cuponsUsuario.stream().filter(c->c.getEvento().getStatus().equals(StatusEvento.CONCLUIDO)).toList();
		DadosUsuario dados = new DadosUsuario(user.getNome(),user.getEmail(),user.getNivel(),user.getMedalhas(),cuponsUsuarioFiltrados);
		return ResponseEntity.ok(dados);
	}
	
	public record TokenAccess(String token,String nome,String image,Integer nivel) {}

}

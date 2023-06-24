package com.Ambitus.AmbitusAPI.controllers;

import java.net.URI;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.Ambitus.AmbitusAPI.DTOs.DadosEvento;
import com.Ambitus.AmbitusAPI.DTOs.DadosEventoRetorno;
import com.Ambitus.AmbitusAPI.DTOs.DadosParticipantes;
import com.Ambitus.AmbitusAPI.DTOs.MeusEventos;
import com.Ambitus.AmbitusAPI.Security.BloqueioEdicao;
import com.Ambitus.AmbitusAPI.entities.Evento;
import com.Ambitus.AmbitusAPI.entities.Evento.OpcaoEvento;
import com.Ambitus.AmbitusAPI.entities.Usuario;
import com.Ambitus.AmbitusAPI.repositories.EventoRepository;

import jakarta.validation.Valid;

@RestController
@RequestMapping(value = "/eventos")
public class EventoController {
	
	@Autowired
	private EventoRepository eventoRepositoy;

	@PostMapping("/cadastro")
	private ResponseEntity<Void> cadastrarEvento(@RequestBody @Valid DadosEvento dados, UriComponentsBuilder uriBuilder) {
		Usuario usuario = (Usuario)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Evento evento = new Evento(dados,usuario);
		eventoRepositoy.save(evento);
		URI uri = URI.create(uriBuilder.path("/evento/{id}").build(evento.getId()).toASCIIString());
		return ResponseEntity.created(uri).build();
	}
	
	@GetMapping
	private ResponseEntity<List<DadosEventoRetorno>> listarEventos(Pageable paginacao) {
		List<Evento> eventos =  eventoRepositoy.findAll();
		List<DadosEventoRetorno> dadosRetorno = eventos.stream().map(DadosEventoRetorno::new).toList();
		return ResponseEntity.ok(dadosRetorno);
	}
	
	@GetMapping("/{tipoEvento}")
	private ResponseEntity<List<DadosEventoRetorno>> listarEventos(@PathVariable String tipoEvento) {
		OpcaoEvento opcao = OpcaoEvento.valueOf(tipoEvento);
		List<Evento> eventos =  eventoRepositoy.findByTipo(opcao);
		List<DadosEventoRetorno> dadosRetornoEvento = eventos.stream().map(DadosEventoRetorno::new).toList();
		return ResponseEntity.ok(dadosRetornoEvento);
	}

	
	@GetMapping("/participantes/{id}")
	private ResponseEntity<DadosParticipantes> listarParticipantes(@PathVariable(name = "id") Long idEvento){
		Evento evento = eventoRepositoy.findById(idEvento).get();
		DadosParticipantes participantesDoEvento = new DadosParticipantes(evento);
		return ResponseEntity.ok(participantesDoEvento);
	}
	
	@PutMapping("/inscricao/{id}")
	private ResponseEntity<Void> realizarInscricao(@PathVariable(name = "id") Long idEvento){
		Usuario usuario = (Usuario)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Evento evento = eventoRepositoy.findById(idEvento).get();
		evento.getParticipantes().add(usuario);
		eventoRepositoy.save(evento);
		return null;
	}
	
	@GetMapping("/meuseventos")
	private ResponseEntity<MeusEventos> meusEventos(){
		Usuario usuario = (Usuario)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Set<Evento> eventos = usuario.getEventosInscrito();
		eventos.addAll(eventoRepositoy.findByOrganizador(usuario));
		MeusEventos meusEventos = new MeusEventos(eventos);
		return ResponseEntity.ok(meusEventos);
	}

	
	@DeleteMapping("/cancelarInscricao/{id}")
	private ResponseEntity<Void> cancelarInscricao(@PathVariable Long id){
		Usuario usuario = (Usuario)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Evento evento = eventoRepositoy.findById(id).get();
		evento.getParticipantes().remove(usuario);
		eventoRepositoy.save(evento);
		return ResponseEntity.ok().build();
	}
	
	@DeleteMapping("/{id}")
	private ResponseEntity<String> deletarEvento(@PathVariable Long id){
		Evento evento = eventoRepositoy.findById(id).get();
		Usuario usuario = (Usuario)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(evento.getOrganizador().equals(usuario)) {
			evento.getParticipantes().clear();
			eventoRepositoy.delete(evento);
			return ResponseEntity.ok().build();
		}
		return ResponseEntity.badRequest().body("Você não pode excluir um evento que não seja o organizador");
	}
	
	@PutMapping("/editarEvento/{id}")
	private ResponseEntity<Evento> editarEvento(@PathVariable Long id, @RequestBody DadosEvento dados){
		Usuario usuario = (Usuario)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Evento evento = eventoRepositoy.findById(id).get();
		if (evento.getOrganizador().equals(usuario)) {
			evento.atualizarDados(dados);
			eventoRepositoy.save(evento);
			return ResponseEntity.ok(evento);
		}else
			throw new BloqueioEdicao("Você não é o organizador deste evento, portanto não pode editar suas informações");
	}

}

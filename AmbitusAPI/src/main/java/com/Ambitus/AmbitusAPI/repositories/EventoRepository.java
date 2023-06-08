package com.Ambitus.AmbitusAPI.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Ambitus.AmbitusAPI.entities.Evento;
import com.Ambitus.AmbitusAPI.entities.Usuario;

@Repository
public interface EventoRepository extends JpaRepository<Evento, Long>{
	
	Set<Evento> findByOrganizador(Usuario organizador);

}

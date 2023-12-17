package com.Ambitus.AmbitusAPI.repositories;

import java.util.List;
import java.util.Set;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.Ambitus.AmbitusAPI.entities.Evento;
import com.Ambitus.AmbitusAPI.entities.Evento.OpcaoEvento;
import com.Ambitus.AmbitusAPI.entities.Evento.StatusEvento;
import com.Ambitus.AmbitusAPI.entities.Usuario;

@Repository
public interface EventoRepository extends JpaRepository<Evento, Long>{
	
	Set<Evento> findByOrganizador(Usuario organizador);
	
	Page<Evento> findByStatus(StatusEvento status,Pageable pageable);
	
	List<Evento> findByTipoAndStatus(OpcaoEvento tipo,StatusEvento status);

	@Query(value="SELECT * FROM evento e where e.data + interval '1 day'<now() and status='ABERTO'",nativeQuery = true)
	List<Evento> getEventosExpirados();

}

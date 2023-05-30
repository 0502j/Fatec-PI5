package com.Ambitus.AmbitusAPI.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Ambitus.AmbitusAPI.entities.Evento;

@Repository
public interface EventoRepository extends JpaRepository<Evento, Long>{

}

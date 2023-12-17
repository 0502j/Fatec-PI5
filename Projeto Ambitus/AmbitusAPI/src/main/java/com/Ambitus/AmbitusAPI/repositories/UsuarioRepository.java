package com.Ambitus.AmbitusAPI.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Ambitus.AmbitusAPI.entities.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Long>{
	
	Usuario findByEmail(String email);

}

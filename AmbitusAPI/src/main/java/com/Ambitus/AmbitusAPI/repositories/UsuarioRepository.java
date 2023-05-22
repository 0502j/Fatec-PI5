package com.Ambitus.AmbitusAPI.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.core.userdetails.UserDetails;

import com.Ambitus.AmbitusAPI.entities.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Long>{
	
	UserDetails findByEmail(String email);

}

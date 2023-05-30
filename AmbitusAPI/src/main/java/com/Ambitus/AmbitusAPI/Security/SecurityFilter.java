package com.Ambitus.AmbitusAPI.Security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.Ambitus.AmbitusAPI.entities.Usuario;
import com.Ambitus.AmbitusAPI.repositories.UsuarioRepository;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class SecurityFilter extends OncePerRequestFilter{
	
	@Autowired
	private JWTTokenGenerate tokenGenerate;
	@Autowired
	private UsuarioRepository usuarioRepository;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		
		String token = getToken(request);
		
		if(token!=null) {
			String email = tokenGenerate.getSubject(token);
			Usuario usuario = usuarioRepository.findByEmail(email);
			
			Authentication auth = UsernamePasswordAuthenticationToken.authenticated(usuario, null, usuario.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(auth);
		}
		
		filterChain.doFilter(request, response);
	}
	
	
	public String getToken(HttpServletRequest request) {
		String token = request.getHeader("Authorization");
		return token;
	}

}

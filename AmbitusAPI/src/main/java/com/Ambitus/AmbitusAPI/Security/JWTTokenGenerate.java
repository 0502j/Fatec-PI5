package com.Ambitus.AmbitusAPI.Security;

import org.apache.tomcat.util.json.TokenMgrError;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.Ambitus.AmbitusAPI.entities.Usuario;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;

@Service
public class JWTTokenGenerate {
	
	@Value("${ambitus.api.secret}")
	private String secret; 

	public String genToken(Usuario user) {
		try {
			Algorithm algorithm = Algorithm.HMAC256(secret);
			return JWT.create().withIssuer("AMBITUS").withSubject(user.getEmail()).sign(algorithm);
		} catch (JWTCreationException exception) {
			throw new TokenMgrError();
		}
	}
	
	public String getSubject(String token) {
		try {
		    Algorithm algorithm = Algorithm.HMAC256(secret);
		    return  JWT.require(algorithm)
		        .withIssuer("AMBITUS")
		        .build()
		        .verify(token)
		        .getSubject();
		} catch (JWTVerificationException exception){
		    throw new RuntimeException("Token inválido ou expirado!");
		}
	}
}

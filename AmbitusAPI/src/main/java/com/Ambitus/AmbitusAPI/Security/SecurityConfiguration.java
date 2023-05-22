package com.Ambitus.AmbitusAPI.Security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http)throws Exception {
		return http.csrf(csrf -> csrf.disable())
				.authorizeHttpRequests(request->request.requestMatchers(HttpMethod.POST, "usuario/cadastro").permitAll().requestMatchers(HttpMethod.POST, "usuario/login").permitAll().anyRequest().authenticated())
				.build();
	}
	
	@Bean
	public AuthenticationManager authManager(AuthenticationConfiguration config)throws Exception {
		return config.getAuthenticationManager();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
	        return new BCryptPasswordEncoder();    
	}
}

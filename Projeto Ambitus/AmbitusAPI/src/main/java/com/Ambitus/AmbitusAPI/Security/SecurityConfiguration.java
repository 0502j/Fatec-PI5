package com.Ambitus.AmbitusAPI.Security;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {
	
	@Autowired
	private SecurityFilter scFilter;

	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http)throws Exception {
		 http.csrf(csrf->csrf.disable())
				.authorizeHttpRequests(request->request.requestMatchers(HttpMethod.POST, "usuario/cadastro").permitAll().requestMatchers(HttpMethod.POST, "usuario/login").permitAll().anyRequest().authenticated())
				.addFilterBefore(scFilter, UsernamePasswordAuthenticationFilter.class);
		 return http.build();
	}
	
	@Bean
	AuthenticationManager authManager(AuthenticationConfiguration config)throws Exception {
		return config.getAuthenticationManager();
	}
	
	@Bean
	PasswordEncoder passwordEncoder() {
	        return new BCryptPasswordEncoder();    
	}
	
}

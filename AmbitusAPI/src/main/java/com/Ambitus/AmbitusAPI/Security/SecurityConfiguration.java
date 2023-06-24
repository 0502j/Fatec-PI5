package com.Ambitus.AmbitusAPI.Security;

import java.util.Arrays;

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
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration implements WebMvcConfigurer{
	
	@Autowired
	private SecurityFilter scFilter;
	
	 @Bean
	    CorsConfigurationSource corsConfigurationSource() {
	        CorsConfiguration configuration = new CorsConfiguration();
	        configuration.setAllowedOrigins(Arrays.asList("*"));
	        configuration.setAllowedMethods(Arrays.asList("*"));
	        configuration.setAllowedHeaders(Arrays.asList("*"));
	        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
	        source.registerCorsConfiguration("/**", configuration);
	        return source;
	    }
	 

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http)throws Exception {
		http.cors();
		 http.csrf(csrf->csrf.disable())
				.authorizeHttpRequests(request->request.requestMatchers(HttpMethod.POST, "usuario/cadastro").permitAll().requestMatchers(HttpMethod.POST, "usuario/login").permitAll().anyRequest().authenticated())
				.addFilterBefore(scFilter, UsernamePasswordAuthenticationFilter.class);
		 return http.build();
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

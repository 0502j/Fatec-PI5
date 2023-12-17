package com.notificaAmbitus.notificaAmbitus.models;

import java.sql.Timestamp;

import com.notificaAmbitus.notificaAmbitus.dtos.EmailDTO;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "registroemail")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Email {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String emailTo;
	private String subject;
	private String message;
	private Timestamp dateSent;
	@Enumerated(EnumType.STRING)
	private Status status;
	
	
	public void registraEnvio(EmailDTO emailDTO,Status status) {
		this.emailTo = emailDTO.emailTo();
		this.subject = emailDTO.subject();
		this.message = emailDTO.mensagem();
		this.dateSent = new Timestamp(System.currentTimeMillis());
		this.status = status;
	}
	
	public static enum Status{
		ENVIADO,
		FALHA
	}
}

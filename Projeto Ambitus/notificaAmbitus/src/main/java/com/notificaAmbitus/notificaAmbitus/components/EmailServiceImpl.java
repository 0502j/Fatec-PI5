package com.notificaAmbitus.notificaAmbitus.components;

import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import com.notificaAmbitus.notificaAmbitus.dtos.EmailDTO;
import com.notificaAmbitus.notificaAmbitus.models.Email;
import com.notificaAmbitus.notificaAmbitus.models.Email.Status;
import com.notificaAmbitus.notificaAmbitus.repository.EmailRepository;

import jakarta.activation.DataHandler;
import jakarta.mail.BodyPart;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMessage.RecipientType;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.util.ByteArrayDataSource;

@Component
public class EmailServiceImpl {

	@Autowired
	private JavaMailSender emailSender;

	@Value("${spring.mail.username}")
	String from;

	@Autowired
	private EmailRepository repository;

	public void sendMessage(EmailDTO emailDTO) {
		Email email = new Email();
		Status status = Status.ENVIADO;

		try {
			MimeMessage message = emailSender.createMimeMessage();

			message.setFrom(from);
			message.setRecipients(RecipientType.TO, emailDTO.emailTo());
			message.setSubject(emailDTO.subject());

			MimeMultipart multipart = new MimeMultipart("related");

			BodyPart messageBodyPart = new MimeBodyPart();
			StringBuilder htmlText = new StringBuilder();
			htmlText.append(emailDTO.mensagem());
			
			if(emailDTO.imagem()==null || emailDTO.imagem().isBlank()) {
				messageBodyPart.setContent(htmlText.toString(), "text/html");
				multipart.addBodyPart(messageBodyPart);
			}else {
				htmlText.append("<img src=\"cid:image\"/>");
				messageBodyPart.setContent(htmlText.toString(), "text/html");
				multipart.addBodyPart(messageBodyPart);
				
				try {
				messageBodyPart = new MimeBodyPart();
				byte[] imageDecoded = Base64.getDecoder().decode(emailDTO.imagem());
				ByteArrayDataSource bds = new ByteArrayDataSource(imageDecoded, "image/png");
				messageBodyPart.setFileName("./evento.png");
				messageBodyPart.setDataHandler(new DataHandler(bds));
				messageBodyPart.setHeader("Content-ID", "image");
				multipart.addBodyPart(messageBodyPart);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			message.setContent(multipart);

			emailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
			status = Status.FALHA;
		}
		email.registraEnvio(emailDTO, status);
		repository.save(email);
	}
}
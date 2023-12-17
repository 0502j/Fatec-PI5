package com.notificaAmbitus.notificaAmbitus.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.notificaAmbitus.notificaAmbitus.components.EmailServiceImpl;
import com.notificaAmbitus.notificaAmbitus.dtos.EmailDTO;

@RestController
@RequestMapping("/email")
public class EmailSentController {
	
	@Autowired
	private EmailServiceImpl service;

	@PostMapping("/send")
	void enviarEmail(@RequestBody EmailDTO email) {
		service.sendMessage(email);
	}
}

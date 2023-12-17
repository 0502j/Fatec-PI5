package com.Ambitus.AmbitusAPI.clients;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.Ambitus.AmbitusAPI.DTOs.NotificaoAmbitusDTO;

@FeignClient("notifica-ms")
public interface NotificaAmbitusClient {
	@RequestMapping(method = RequestMethod.POST,value = "/email/send")
	public void enviarNotificacao(@RequestBody NotificaoAmbitusDTO dados);
}

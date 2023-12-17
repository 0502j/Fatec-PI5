package com.Ambitus.AmbitusAPI;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@org.springframework.cloud.openfeign.EnableFeignClients
@EnableScheduling
public class AmbitusApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(AmbitusApiApplication.class, args);
	}

}

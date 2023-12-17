package com.notificaAmbitus.notificaAmbitus.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.notificaAmbitus.notificaAmbitus.models.Email;

public interface EmailRepository extends  JpaRepository<Email, Long>{

}

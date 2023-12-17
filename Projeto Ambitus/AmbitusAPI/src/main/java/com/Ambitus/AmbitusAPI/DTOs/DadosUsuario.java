package com.Ambitus.AmbitusAPI.DTOs;

import java.util.List;
import java.util.Set;

import com.Ambitus.AmbitusAPI.entities.Cupom;
import com.Ambitus.AmbitusAPI.entities.Medalha;

public record DadosUsuario(String nome,String email,Integer nivel,Set<Medalha> medalhas,List<Cupom> cupons) {
	
}

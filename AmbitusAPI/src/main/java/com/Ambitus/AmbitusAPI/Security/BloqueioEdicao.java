package com.Ambitus.AmbitusAPI.Security;

public class BloqueioEdicao extends RuntimeException{

	/**
	 * 
	 */
	private static final long serialVersionUID = 542663963058970090L;
	
	public BloqueioEdicao(String msg){
		super(msg);
	}
}

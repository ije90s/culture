package com.ije.domain;

import lombok.Data;

@Data
public class AuthVO {
	private String auth; 
	private String mno;
	
	public AuthVO(String auth, String mno) {
		this.auth=auth;
		this.mno=mno;
	}
}

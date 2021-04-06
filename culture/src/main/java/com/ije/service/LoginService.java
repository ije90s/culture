package com.ije.service;

import com.ije.domain.LoginVO;

public interface LoginService {
	public LoginVO get(String id, String rdate); 
	public void register(LoginVO vo);
	public int getCount(String id);
}

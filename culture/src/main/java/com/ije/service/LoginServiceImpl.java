package com.ije.service;

import org.springframework.stereotype.Service;

import com.ije.domain.LoginVO;
import com.ije.mapper.LoginMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class LoginServiceImpl implements LoginService {
	
	private final LoginMapper mapper; 
	
	@Override
	public LoginVO get(String id, String rdate) {
		return mapper.read(id, rdate) ;
	}

	@Override
	public void register(LoginVO vo) {
		mapper.insert(vo);
	}

	@Override
	public int getCount(String id) {
		// TODO Auto-generated method stub
		return mapper.getCount(id);
	}
	
}

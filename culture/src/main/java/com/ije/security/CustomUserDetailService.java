package com.ije.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.ije.domain.CustomUser;
import com.ije.domain.MemberVO;
import com.ije.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService {

	private final MemberMapper mapper; 
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("userName : "+ username);
		
		MemberVO vo = mapper.read(username); 
		
		log.warn("회원 조회 : " + vo);
		
		return vo==null?null:new CustomUser(vo);
	}

}

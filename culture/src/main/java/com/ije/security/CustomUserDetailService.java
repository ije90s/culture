package com.ije.security;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;


import com.ije.domain.Criteria;
import com.ije.domain.CustomUser;

import com.ije.domain.MemberVO;
import com.ije.mapper.CultureMapper;
import com.ije.mapper.LoginMapper;
import com.ije.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Log4j
public class CustomUserDetailService implements UserDetailsService {

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper; 
	
	@Setter(onMethod_ = {@Autowired})
	private CultureMapper cultureMapper; 
	
	@Setter(onMethod_ = {@Autowired})
	private LoginMapper loginMapper; 

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("userName : "+ username);
		
		MemberVO vo = mapper.read(username); 
		
		log.warn("회원 조회 : " + vo);
		Criteria cri = new Criteria(); 
		String auth = vo.getAuthList().get(0).getAuth(); 
		if(auth.equals("ROLE_USER")) {
			int cultureCnt = cultureMapper.getCount(cri, vo.getMno());
			int loginCnt = loginMapper.getCount(username);
			log.info(cultureCnt);
			log.info(loginCnt);
			if(cultureCnt > 5 && loginCnt > 5) {	
				mapper.updateAuth("ROLE_MEMBER", vo.getMno().toString());
			}
		}
				
		return vo==null?null:new CustomUser(vo);
	}

}

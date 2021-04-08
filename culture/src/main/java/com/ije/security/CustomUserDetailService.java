package com.ije.security;




import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;


import com.ije.domain.Criteria;
import com.ije.domain.CustomUser;
import com.ije.domain.MemberLogVO;
import com.ije.domain.MemberVO;
import com.ije.mapper.CultureMapper;
import com.ije.mapper.LoginMapper;
import com.ije.mapper.MemberLogMapper;
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
	
	@Setter(onMethod_ = {@Autowired})
	private MemberLogMapper logMapper; 	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("userName : "+ username);
		
		MemberVO vo = mapper.read(username); 
		
		log.warn("회원 조회 : " + vo);
		Criteria cri = new Criteria(); 
		String auth = vo.getAuthList().get(0).getAuth(); 
		if(auth.equals("ROLE_USER")) {
			int cultureCnt = cultureMapper.getCount(cri, username);
			int loginCnt = loginMapper.getCount(username);
			log.info(cultureCnt);
			log.info(loginCnt);
			if(cultureCnt > 5 && loginCnt > 5) {	
				mapper.updateAuth("ROLE_MEMBER", vo.getMno().toString());
			}
		}
		
		//블락회원 날짜 체크
		MemberLogVO log = logMapper.read(vo.getLno()); 
		if(vo.getState()==1) {
			try {
				Date today = new Date(); 
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
				Date edate = df.parse(log.getEdate());
				if(today.compareTo(edate)>0)
					mapper.updateState(0, username);
				else
					return null;
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null; 
			}
		}
		
		if(vo.getState()==2) return null;
		
			
		return vo==null?null:new CustomUser(vo);
	}

}

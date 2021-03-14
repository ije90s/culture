package com.ije.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.ije.domain.MemberVO;
import com.ije.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mapper; 
	private final PasswordEncoder pw; 
	
	@Override
	public void register(MemberVO vo) {
		log.info("회원 등록하기");
		vo.setPw(pw.encode(vo.getPw()));
		List<MemberVO> ins = new ArrayList<>(); 
		ins.add(vo); 
		mapper.insert(ins);
	}

	@Override
	public MemberVO read(String id) {
		log.info("아이디 체크하기 : "+id);
		return mapper.read(id);
	}

}

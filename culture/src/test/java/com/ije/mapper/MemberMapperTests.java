package com.ije.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml","file:src\\main\\webapp\\WEB-INF\\spring\\security-context.xml" })
@Log4j
public class MemberMapperTests {
	
	@Autowired
	private MemberMapper mapper; 
	
	@Autowired
	private PasswordEncoder pw; 
	
	@Test
	public void read() {
		
		MemberVO vo = mapper.read("admin90"); 
		
		log.info(vo);
		vo.getAuthList().forEach(auth -> log.info(auth));
	}
	
	@Test
	public void insert() {
		log.info("...............................................");
		List<MemberVO> ins = new ArrayList<>(); 
		MemberVO vo = new MemberVO(); 
		vo.setId("test");
		vo.setPw(pw.encode("test"));
		vo.setName("테스트");
		vo.setPhone("01012341234");
		vo.setEmail("aaa@gmail.com");
		vo.setFavorites("");
		//log.info(vo);
		ins.add(vo);
		log.info(ins);
		mapper.insert(ins);
	}
}

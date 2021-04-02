package com.ije.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.Criteria;
import com.ije.domain.MemberLogVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml","file:src\\main\\webapp\\WEB-INF\\spring\\security-context.xml"})
@Log4j
public class MemberLogTests {
	
	@Autowired
	private MemberLogService service; 
	
	@Test
	public void getList() {
		log.info("......................................");
		Criteria sub = new Criteria(1, 3); 
		String target = "user1"; 
		service.getByTarget(sub, target).forEach(list -> log.info(list));
		
	}
	
	@Test
	public void get() {
		log.info("..............................................");
		log.info(service.get(5L));
	}
	
	@Test
	public void register() {
		log.info(".......................................................");
		MemberLogVO vo = new MemberLogVO(); 
		vo.setKind("R");
		vo.setContent("등급 테스트");
		vo.setAuth("ROLE_MEMBER");
		vo.setSdate("");
		vo.setEdate("");
		vo.setTarget("user4");
		vo.setRid("admin90");
		vo.setMid("admin90");
		service.register(vo);
		//service.getList().forEach(list -> log.info(list));
	}
	
	@Test
	public void modify() {
		log.info("..............................................................");
		MemberLogVO vo = service.get(7L); 
		vo.setContent("등급테스트2");
		vo.setSdate("");
		vo.setEdate("");
		vo.setReason("");
		log.info(service.modify(vo));
	}
	
	@Test
	public void remove() {
		log.info("................................................................");
		log.info(service.remove(9L));
	}
	
	
}

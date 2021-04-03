package com.ije.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.MemberLogVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class MemberLogMapperTests {

	@Autowired
	private MemberLogMapper mapper; 
	
	@Test
	public void getList() {
		log.info("...........................");
		//mapper.getList().forEach(list -> log.info(list));
	}
	
	@Test
	public void insert() {
		log.info("....................................");
		MemberLogVO vo = new MemberLogVO(); 
		vo.setKind("R");
		vo.setContent("등급 테스트");
		vo.setAuth("ROLE_MEMBER");
		vo.setSdate("");
		vo.setEdate("");
		vo.setTarget("user4");
		vo.setRid("admin90");
		vo.setMid("admin90");
		mapper.insert(vo);
	}
	
	@Test
	public void get() {
		log.info("...............................");
		log.info(mapper.read(1L));
	}
	
	@Test
	public void update() {
		log.info("......................................");
		MemberLogVO vo = mapper.read(1L); 
		vo.setContent("등급테스트2");
		vo.setSdate("");
		vo.setEdate("");
		vo.setReason("");
		mapper.update(vo);
		log.info(mapper.read(1L));
	}
	
	@Test
	public void delete() {
		log.info("......................................");
		log.info(mapper.delete(6L));
	}
}

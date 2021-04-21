package com.ije.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.Criteria;
import com.ije.domain.MessageVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml","file:src\\main\\webapp\\WEB-INF\\spring\\security-context.xml"})
@Log4j
public class MessageTests {

	@Autowired
	private MessageService service; 
	
	@Test
	public void getList() {
		Criteria cri = new Criteria(); 
		//service.getList(cri).forEach(list -> log.info(list));
	}
	
	@Test
	public void register() {
		MessageVO ins = new MessageVO(); 
		ins.setSender("user0");
		ins.setTarget("user2");
		ins.setMessage("테스트2");
		ins.setRefno(0L);
		service.register(ins);
	}
	
	@Test
	public void get() {
		//log.info(service.get(6L));
	}
	
	@Test
	public void modify() {
		//MessageVO upt = service.get(7L); 
		//upt.setMessage("리턴 테스트2");
		//log.info(service.modify(upt));
	}
	
}

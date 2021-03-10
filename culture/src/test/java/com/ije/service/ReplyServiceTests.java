package com.ije.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class ReplyServiceTests {

	@Autowired
	private ReplyService service; 
	
	@Test
	public void List() {
		log.info(".............................");
		service.getList().forEach(reply -> log.info(reply));
	}
	
	@Test
	public void Register() {
		log.info(".................................");
		ReplyVO reply = new ReplyVO(); 
		reply.setReply("서비스 테스트입니다.");
		reply.setReplyer("user01");
		reply.setBno(14L);
		log.info(reply);
		service.register(reply);
	}
	
	@Test
	public void Get() {
		log.info(".................................");
		log.info(service.get(10L));
	}
	
	@Test
	public void Modify() {
		log.info(".................................");
		ReplyVO reply = service.get(10L);
		reply.setReply("서비스 테스트");
		log.info(reply);
		log.info("결과 : " + service.modify(reply));
	}
	
	@Test
	public void Remove() {
		log.info(".................................");
		log.info(service.remove(10L));
	}
}

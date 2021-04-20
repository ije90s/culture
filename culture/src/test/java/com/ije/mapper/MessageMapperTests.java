package com.ije.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.Criteria;
import com.ije.domain.MessageVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml","file:src\\main\\webapp\\WEB-INF\\spring\\security-context.xml" })
@Log4j
public class MessageMapperTests {
	
	@Autowired
	private MessageMapper mapper;
	
	@Test
	public void insert() {
		MessageVO ins = new MessageVO(); 
		ins.setSender("user0");
		ins.setTarget("user1");
		ins.setMessage("메시지 테스트5");
		mapper.insert(ins);
	}
	
	@Test
	public void getList() {
		Criteria cri = new Criteria(); 
		cri.setType("T");
		cri.setKeyword("user1");
		
		mapper.getList(cri).forEach(list -> log.info(list));
	}
	
	@Test
	public void read() {
		log.info(mapper.read(6L));
	}
	
	@Test
	public void update() {
		MessageVO upt = mapper.read(6L); 
		upt.setMessage("변경 테스트");
		log.info(mapper.update(upt));
		log.info(mapper.read(6L));
	}
	
	@Test
	public void updateOdate() {
		log.info(mapper.updateOdate(6L));
	}
}

package com.ije.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.Criteria;
import com.ije.domain.ReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class ReplyMapperTests {

	@Autowired
	private ReplyMapper mapper; 
	
	@Test
	public void getList() {
		log.info("...........................");
		mapper.getList().forEach(reply -> log.info(reply));
	}
	
	@Test
	public void insert() {
		log.info("..............................................");
		ReplyVO ins = new ReplyVO(); 
		ins.setReply("mapper 테스트");
		ins.setReplyer("user01");
		ins.setBno(14L);
		log.info(ins);
		mapper.insert(ins);
		
	}
	
	@Test
	public void read() {
		log.info("..........................................................");
		log.info(mapper.read(8L));
	}
	
	@Test
	public void update() {
		log.info("....................................................................");
		ReplyVO upt = mapper.read(8L); 
		upt.setReply("업데이트 테스트");
		log.info(upt);
		log.info("결과 : "+ mapper.update(upt));
	}
	
	@Test
	public void delete() {
		log.info("...............................................................................");
		log.info("결과 : " + mapper.delete(9L));
	}
	
	@Test
	public void getListPagin() {
		log.info("...............................................................................");
		Criteria cri = new Criteria(2,10); 
		List<ReplyVO> replies = mapper.getListPaing(cri,15L); 
		replies.forEach(reply -> log.info(reply));
	}
}

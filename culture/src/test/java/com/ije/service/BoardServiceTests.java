package com.ije.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class BoardServiceTests {

	@Autowired
	private BoardService service; 
	
	@Test
	public void getList() {
		log.info("========================================");
		service.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void register() {
		log.info("========================================");
		BoardVO ins = new BoardVO(); 
		ins.setKind("notice");
		ins.setTitle("service 테스트");
		ins.setContent("service 테스트");
		ins.setWriter("admin");
		service.register(ins);
	}
	
	@Test
	public void get() {
		log.info("========================================");
		log.info(service.get(11L));
	}
	
	@Test
	public void remove() {
		log.info("========================================");
		log.info(service.remove(10L));
	}
	
	@Test
	public void update() {
		log.info("========================================");
		BoardVO upt = service.get(3L); 
		upt.setTitle("service update");
		upt.setContent("service update");
		log.info(service.modify(upt));
		log.info(service.get(3L));
	}
	
	@Test
	public void getListPaging() {
		log.info("========================================");
		Criteria cri = new Criteria(); 
		cri.setAmount(10);
		cri.setPageNum(1);
		service.getListPaging(cri).forEach(board -> log.info(board));
	}
}

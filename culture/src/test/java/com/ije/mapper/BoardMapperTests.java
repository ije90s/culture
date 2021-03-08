package com.ije.mapper;

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
public class BoardMapperTests {

	@Autowired
	private BoardMapper mapper; 
	
	@Test
	public void getList() {
		log.info("..........................");
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void insert() {
		log.info("........................................");
		BoardVO ins = new BoardVO(); 
		ins.setKind("free");
		ins.setTitle("mapper 테스트");
		ins.setContent("mapper 테스트");
		ins.setWriter("user01");
		log.info(ins);
		mapper.insert(ins);
	}
	
	@Test
	public void insertKey() {
		log.info("............................................");
		BoardVO ins = new BoardVO(); 
		ins.setKind("free");
		ins.setTitle("mapper 테스트");
		ins.setContent("mapper 테스트");
		ins.setWriter("user01");
		mapper.insertKey(ins);
		log.info(ins);
	}
	
	@Test
	public void read() {
		log.info("........................................................");
		log.info(mapper.read(3L));
	}
	
	@Test
	public void delete() {
		log.info("..........................................................");
		log.info(mapper.delete(9L));
	}
	
	@Test
	public void update() {
		log.info("....................................................................");
		BoardVO upt = mapper.read(7L); 
		log.info(upt);
		upt.setTitle("update 테스트");
		upt.setContent("update 테스트");
		log.info(mapper.update(upt));
	}
	
	@Test
	public void getListPaging() {
		log.info(".............................................................................");
		Criteria cri = new Criteria(); 
		cri.setPageNum(1);
		cri.setAmount(10);
		mapper.getListPaging(cri).forEach(board -> log.info(board));
	}
}

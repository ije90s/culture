package com.ije.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.Criteria;
import com.ije.domain.ReportVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class ReportMapperTests {

	@Autowired
	private ReportMapper mapper; 
	
	@Test
	public void getList() {
		log.info("......................................");
		Criteria cri = new Criteria(); 
		mapper.getList(cri).forEach(list -> log.info(list));
	}
	
	@Test
	public void insert() {
		ReportVO vo = new ReportVO(); 
		vo.setTitle("신고테스트");
		vo.setContent("신고테스트");
		vo.setKind("culture");
		vo.setNo(61L);
		vo.setReporter("user0");
		vo.setMid("user0");
		//log.info(vo);
		mapper.insert(vo);
	}
	
	@Test
	public void get() {
		log.info("....................................");
		log.info(mapper.read(4L));
	}
	
	@Test
	public void update() {
		log.info("........................................");
		ReportVO vo = mapper.read(5L); 
		vo.setState("1");
		vo.setReason("테스트");
		vo.setMid("admin90");
		//log.info(vo);
		log.info(mapper.update(vo));
	}
	
	@Test
	public void delete() {
		log.info(".................................................");
		log.info(mapper.delete(5L));
	}
}

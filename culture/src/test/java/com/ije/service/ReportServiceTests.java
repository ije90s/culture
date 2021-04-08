package com.ije.service;

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
public class ReportServiceTests {

	@Autowired
	private ReportService service;
	
	@Test
	public void getList() {
		log.info("............................................");
		Criteria cri = new Criteria(); 
		//service.getList(cri).forEach(list -> log.info(list));
	}
	
	@Test
	public void register() {
		log.info("................................................");
		ReportVO vo = new ReportVO(); 
		vo.setTitle("신고테스트");
		vo.setContent("신고테스트");
		vo.setKind("culture");
		vo.setNo(62L);
		vo.setReporter("user0");
		vo.setMid("user0");
		service.register(vo);
	}
	
	@Test
	public void get() {
		log.info("...................................................");
		log.info(service.get(7L));
	}
	
	@Test
	public void modify() {
		log.info("..........................................................");
		ReportVO vo = service.get(4L); 
		vo.setState("1");
		vo.setReason("테스트");
		vo.setMid("admin90");
		log.info(service.modify(vo));
		log.info(service.get(4L));
	}
	
	@Test
	public void remove() {
		log.info(".....................................................");
		log.info(service.remove(4L));
	}
}

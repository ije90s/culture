package com.ije.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.Criteria;
import com.ije.domain.CultureVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class CultureServiceTests {
	
	@Autowired
	private CultureService service; 
	
	@Test
	public void getList() {
		log.info("==================================================");
		service.getList().forEach(c -> log.info(c));
		log.info("==================================================");
	}
	
	@Test
	public void register() {
		log.info("==================================================");
		CultureVO ins = new CultureVO(); 
		ins.setTitle("서비스 테스트");
		ins.setContent("서비스 테스트");
		ins.setKind(1L);
		ins.setRank(1L);
		log.info(service.register(ins));
		log.info(ins);
	}
	
	@Test
	public void registerKey() {
		log.info("==================================================");
		CultureVO ins = new CultureVO(); 
		ins.setTitle("서비스 테스트");
		ins.setContent("서비스 테스트");
		ins.setKind(1L);
		ins.setRank(1L);
		service.registerKey(ins);
		log.info(ins);		
	}
	
	@Test
	public void get() {
		log.info("==================================================");
		log.info(service.get(3L));
	}
	
	@Test
	public void modify() {
		log.info("==================================================");	
		CultureVO upt = service.get(3L); 
		upt.setTitle("service update");
		upt.setContent("service test");
		log.info(service.modify(upt));
	}
	
	@Test
	public void remove() {
		log.info("==================================================");	
		log.info(service.remove(11L));
	}
	
	@Test
	public void paging() {
		log.info("==================================================");	
		Criteria cri = new Criteria(); 
		cri.setPageNum(3);
		cri.setAmount(10);
		service.getListPaging(cri).forEach(culture -> log.info(culture));
	}
	
	@Test
	public void month() {
		log.info("==================================================");	
		Criteria cri = new Criteria(); 
		cri.setSdate("2021-03-01");
		cri.setEdate("2021-03-31");
		service.getMonList(cri).forEach(culture -> log.info(culture));
	}
	
	@Test
	public void year() {
		log.info("==================================================");	
		Criteria cri = new Criteria(); 
		cri.setSdate("2021-01-01");
		cri.setEdate("2021-03-31");
		service.getYearList(cri).forEach(culture -> log.info(culture));		
	}
	
	@Test
	public void chart() {
		log.info("==================================================");	
		Criteria cri = new Criteria(); 
		cri.setSdate("2021-03-01");
		cri.setEdate("2021-03-31");
		service.getChartList(cri).forEach(culture -> log.info(culture));			
	}
	
	@Test
	public void getBySdate() {
		log.info("==================================================");	
		Criteria cri = new Criteria(); 
		cri.setSdate("2021-03-01");
		log.info(service.getBySdate(cri));
	}
}


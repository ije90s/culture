package com.ije.mapper;

import java.util.Calendar;
import java.util.Date;

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
public class CultureMapperTests {

	@Autowired
	private CultureMapper mapper;
	
	@Test
	public void getList() {
		log.info("getList().........................");
		log.info(mapper.getList());
	}
	
	@Test
	public void insert() {
		log.info("insert()..........................");
		Calendar cal = Calendar.getInstance();
		cal.set(2021,0,1);
		Date strToday = cal.getTime(); 
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		//String formatSTr = sdf.format(strToday);
		//log.info(formatSTr);
		CultureVO ins = new CultureVO(); 
		ins.setKind(1L);
		ins.setTitle("insert 테스트");
		ins.setContent("insert 테스트");
		ins.setRank(1L);
		//ins.setCdate(strToday);
		log.info(mapper.insert(ins));
		log.info(ins);
	}
	
	@Test
	public void insertKey() {
		log.info("insertKey()..........................");
		CultureVO ins = new CultureVO(); 
		ins.setKind(1L);
		ins.setTitle("insertKey 테스트");
		ins.setContent("insertKey 테스트");
		ins.setRank(1L);
		mapper.insertKey(ins);
		log.info(ins);		
	}
	
	@Test
	public void read() {
		log.info("read().......................................");
		log.info(mapper.read(3L));
	}
	
	@Test
	public void update() {
		log.info("update()......................................");
		CultureVO upt = mapper.read(3L); 
		upt.setTitle("update 테스트");
		upt.setContent("update 테스트");
		log.info(mapper.update(upt));
		log.info(mapper.read(3L));
	}
	
	@Test
	public void delete() {
		log.info("delete().........................................");
		log.info(mapper.delete(12L));
		log.info(mapper.getList());
	}
	
	@Test
	public void getListPaging() {
		log.info("getListPaging.........................................");
		Criteria cri = new Criteria(); 
		cri.setPageNum(3);
		cri.setAmount(10);
		//mapper.getListPaging(cri, 102L).forEach(culture -> log.info(culture));
	}
	
	
	@Test
	public void getMonList() {
		log.info("getMonList.............................................");
		Criteria cri = new Criteria(); 
		cri.setSdate("2021-03-01");
		cri.setEdate("2021-03-31");
		log.info(cri);
		//mapper.getMonList(cri, 102L).forEach(culture -> log.info(culture));
	}
	
	@Test
	public void getYearList() {
		log.info("getYearList()...........................................");
		Criteria cri = new Criteria(); 
		cri.setSdate("2021-01-01");
		cri.setEdate("2021-03-31");
		//mapper.getYearList(cri, 102L).forEach(culture -> log.info(culture));
	}
	@Test
	public void getChartList() {
		log.info("getChartList()..............................................");
		Criteria cri = new Criteria(); 
		cri.setSdate("2021-03-01");
		cri.setEdate("2021-03-31");
		//mapper.getChartList(cri, 102L).forEach(culture -> log.info(culture));
	}
	
	@Test
	public void getRead2() {
		log.info("getRead2().........................................................");
		Criteria cri = new Criteria(); 
		cri.setSdate("2021-03-01");
		//log.info(mapper.read2(cri, 102L));
	}
	
}

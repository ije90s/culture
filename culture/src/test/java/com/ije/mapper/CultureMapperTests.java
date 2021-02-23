package com.ije.mapper;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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
		ins.setCdate(strToday);
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
		log.info(mapper.insertKey(ins));
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
}

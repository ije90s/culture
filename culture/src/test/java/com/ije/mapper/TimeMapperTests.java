package com.ije.mapper;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class TimeMapperTests {

	@Autowired
	private TimeMapper mapper; 
	
	@Test
	public void getTime() {
		log.info("................................");
		log.info(mapper.getTime());
	}
	
	@Test
	public void getTime2() {
		log.info("...................................");
		log.info(mapper.getTime2());
	}
	

}

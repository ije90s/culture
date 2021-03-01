package com.ije.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class AttachMapperTests {

	@Autowired
	private AttachMapper mapper; 
	
	@Test
	public void getList() {
		log.info("..................................");
		mapper.findByCno(1L).forEach(attach -> log.info(attach));
		
	}
	
	@Test
	public void getInsert() {
		log.info("..........................................");
		AttachVO attach = new AttachVO(); 
		attach.setMno(0L);
		attach.setCno(4L);
		attach.setBno(0L);
		List<AttachFileVO> filelist = new ArrayList<AttachFileVO>(); 
		// AttachFileVO(String uuid, String fileName, char fileType, Long gno, String path) 

		AttachFileVO file = new AttachFileVO(); 
		file.setUuid("d");
		file.setFileName("테스트.jpg");
		file.setFileType(true);
		file.setPath("culture/2021/02/28");
		filelist.add(file);

		AttachFileVO file2 = new AttachFileVO(); 
		file2.setUuid("d2");
		file2.setFileName("테스트.jpg");
		file2.setFileType(true);
		file2.setPath("culture/2021/02/28");
		filelist.add(file2);
		
		
		AttachFileVO file3 = new AttachFileVO(); 
		file3.setUuid("d3");
		file3.setFileName("테스트.jpg");
		file3.setFileType(true);
		file3.setPath("culture/2021/02/28");
		filelist.add(file3);		
		
		attach.setFileList(filelist);
		List<AttachVO> ins = new ArrayList<AttachVO>(); 
		ins.add(attach);
		log.info(attach);
		mapper.insert(ins);
	}
	
	@Test
	public void getDelete() {
		log.info("...............................................:");
		
		//int result = mapper.deleteFile("dd"); 
		//log.info((mapper.deleteFile("d"))>0?mapper.delete():0);

	}
}

package com.ije.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AttachVO {
	private Long gno; 
	private String path; 
	private Date rdate; 
	private Long mno; 
	private Long cno; 
	private Long bno; 
	private List<AttachFileVO> filelist;  
	
}

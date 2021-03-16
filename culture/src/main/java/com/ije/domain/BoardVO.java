package com.ije.domain;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno; 
	private String kind; 
	private String title; 
	private String content; 
	private String writer; 
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date rdate; 
	private Date udate; 
	private List<AttachVO> attachList; 
}

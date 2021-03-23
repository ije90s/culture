package com.ije.domain;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno; 
	private String kind; 
	@NotBlank
	private String title;
	@NotBlank
	private String content; 
	private String writer; 
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date rdate; 
	private Date udate; 
	private List<AttachVO> attachList; 
	
	private int replyCnt;
}

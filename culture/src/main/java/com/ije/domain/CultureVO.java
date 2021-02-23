package com.ije.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CultureVO {
	private Long cno; 
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date cdate; 
	private Long kind; 
	private String title;
	private String content; 
	private Long rank; 
	private Date rdate;
	private Date udate; 
	private Long mno; 
}

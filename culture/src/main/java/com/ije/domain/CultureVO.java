package com.ije.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CultureVO {
	private Long cno; 
	private Date cdate; 
	private Long kind; 
	private String title;
	private String content; 
	private Long rank; 
	private Date rdate;
	private Date udate; 
	private Long mno; 
}

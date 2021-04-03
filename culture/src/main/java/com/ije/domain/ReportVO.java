package com.ije.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReportVO {
	private Long rno; 
	private String title; 
	private String content; 
	private String reporter; 
	private String kind; 
	private Long no; 
	private String reason; 
	private String state; 
	private Date rdate; 
	private String mid; 
	private Date mdate; 
}

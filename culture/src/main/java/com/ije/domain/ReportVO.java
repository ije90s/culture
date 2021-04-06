package com.ije.domain;

import java.sql.Date;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class ReportVO {
	private Long rno; 
	@NotBlank
	private String title; 
	@NotBlank
	private String content; 
	private String reporter; 
	private String kind; 
	private Long no; 
	private String reason; 
	private String state; 
	private Date rdate; 
	@NotBlank
	private String mid; 
	private Date mdate; 
}

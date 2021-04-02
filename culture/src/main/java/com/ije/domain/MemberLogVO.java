package com.ije.domain;

import java.sql.Date;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class MemberLogVO {
	private Long lno; 
	@NotBlank
	private String kind;
	@NotBlank
	private String content; 
	private String auth; 
	private String sdate; 
	private String edate; 
	private String target; 
	private String reason;
	private Date rdate; 
	private String rid; 
	private Date mdate; 
	private String mid; 
	private int state; 
	private String oldauth;
	private int cnt;
	private int rn;
}

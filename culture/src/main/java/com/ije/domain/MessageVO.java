package com.ije.domain;

import java.util.Date;

import lombok.Data;


@Data
public class MessageVO {

	private Long mno; 
	private String sender; 
	private String target; 
	private String message; 
	private Date sdate; 
	private Date odate; 
	private Date udate; 
	private Long refno; 
	private Long cno;
}

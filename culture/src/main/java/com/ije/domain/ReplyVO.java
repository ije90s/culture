package com.ije.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ReplyVO {
	private Long rno; 
	private String reply; 
	private String replyer; 
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date rdate; 
	private Date udate; 
	private Long bno; 
}

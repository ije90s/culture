package com.ije.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private Long mno; 
	private String id; 
	private String pw; 
	private String name; 
	private String phone;
	private String email; 
	private String favorites; 
	private Date rdate;
	private Date udate; 
	private boolean enabled; 
	private List<AuthVO> authList;
	private List<AttachVO> attachList; 
	
}

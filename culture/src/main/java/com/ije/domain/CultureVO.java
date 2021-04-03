package com.ije.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.Digits;
import javax.validation.constraints.PastOrPresent;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CultureVO {
	private Long rn;
	private Long cno; 
	@NotBlank(message = "필수항목입니다.")
	private String cdate; 
	@Digits(integer = 1, fraction = 0)
	private Long kind;
	@NotBlank(message = "필수항목입니다.")
	@Size(max = 25, message = "최대 25자까지 가능합니다.")
	private String title;
	private String content; 
	private Long rank; 
	private Date rdate;
	private Date udate; 
	private Long mno; 
	private List<AttachVO> attachList;
	
	private String day; 
	private int sum; 
	private int ratio; 
	private String open;
	private String report;
}

package com.ije.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@SuppressWarnings("deprecation")
@Data
public class MemberVO {
	private Long mno; 
	@NotBlank(message = "필수항목입니다.")
	@Pattern(regexp = "^[a-z0-9]{5,12}$", message = "최소 5자리이상 영문(소문자)/숫자만 입력가능")
	private String id; 
	@NotBlank(message = "필수항목입니다.")
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$", message = "최소8자리이상 영문/숫자/특수기호 입력가능")
	private String pw; 
	@NotBlank(message = "필수항목입니다.")
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$", message ="최소8자리이상 영문/숫자/특수기호 입력가능")
	private String pw2; 	
	@NotBlank(message = "필수항목입니다.")
	private String name; 
	private String phone;
	@Email(message = "이메일 형식이 맞지 않습니다.")
	private String email; 
	private String favorites; 
	private Date rdate;
	private Date udate; 
	private boolean enabled; 
	private List<AuthVO> authList;
	private List<AttachVO> attachList; 
	
}

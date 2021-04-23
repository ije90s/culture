package com.ije.controller;



import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ije.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	@GetMapping("/accessError")
	public void accessDenined(Authentication auth, Model d) {
		log.info("access Denined : " +auth);
		d.addAttribute("msg", "Access Denined");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(@RequestParam(value="error", required = false) String error, @RequestParam(value="msg", required=false) String msg, String logout, Model d) {
		if(msg==null) {
			msg = "로그인 실패"; 
		}else {
			if(msg.equals("1")) 
				msg = "존재하지 않는 사용자입니다.";
			else
				msg = "아이디 또는 비밀번호가 틀립니다.";
		}
		
		log.info(msg);
		if(error!=null) {
			d.addAttribute("error", msg); 
		}
		
		if(logout!=null) {
			d.addAttribute("logout", "로그아웃!!");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("로그아웃");
	}
	
	@GetMapping("/echo")
	public void echo(Model d) {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		
		log.info("================================");
		log.info(user.getUsername());
		
		d.addAttribute("userid", user.getUsername());
	}
}

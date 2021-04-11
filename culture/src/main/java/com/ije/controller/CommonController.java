package com.ije.controller;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	public void loginInput(String error, String logout, Model d) {
		
		if(error!=null) {
			d.addAttribute("error", "로그인실패!!"); 
		}
		
		if(logout!=null) {
			d.addAttribute("logout", "로그아웃!!");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("로그아웃");
	}
}

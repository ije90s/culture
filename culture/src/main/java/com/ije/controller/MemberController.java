package com.ije.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.MemberVO;
import com.ije.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
@RequiredArgsConstructor
public class MemberController {

	private final MemberService service; 
	

	@GetMapping("/join")
	public void join() {
		log.info("회원가입 폼 ....................");
	}
	
	@PostMapping("/join")
	public String join(MemberVO ins, RedirectAttributes rttr) {
		log.info("회원가입 처리중........................");	
		service.register(ins);
		rttr.addFlashAttribute("result", "1");
		return "redirect:/customLogin"; 
	}
	
	@GetMapping(value="/{id}", produces ={MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> confirm(@PathVariable("id") String id){
		MemberVO vo = service.read(id); 
		String result = "ok"; 
		if(vo!=null) result = "no"; 
		return new ResponseEntity<>(result, HttpStatus.OK); 
	}
}

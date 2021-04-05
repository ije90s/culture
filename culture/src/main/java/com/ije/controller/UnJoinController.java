package com.ije.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ije.domain.Criteria;
import com.ije.domain.PageVO;
import com.ije.domain.UnjoinVO;
import com.ije.service.UnjoinService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/unjoin/*")
@Log4j
public class UnJoinController {
	
	private final UnjoinService service; 
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/list")
	public void list(Criteria cri, Model d) {
		log.info("탈퇴사유리스트..........................");
		d.addAttribute("list", service.getList(cri)); 
		d.addAttribute("page", new PageVO(cri, service.getCount())); 
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/get")
	public void get(@RequestParam("uno") Long uno, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("상세조회.........................."+uno);
		d.addAttribute("unjoin", service.get(uno));
	}
	
	@GetMapping(value="/chart", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<List<UnjoinVO>> chart(){
		return new ResponseEntity<>(service.getCountList(), HttpStatus.OK);
	}
}

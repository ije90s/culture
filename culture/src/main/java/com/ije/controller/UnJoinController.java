package com.ije.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ije.domain.Criteria;
import com.ije.domain.PageVO;
import com.ije.service.UnjoinService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/unjoin/*")
@Log4j
public class UnJoinController {
	
	private final UnjoinService service; 
	
	@GetMapping("/list")
	public void list(Criteria cri, Model d) {
		log.info("탈퇴사유리스트..........................");
		d.addAttribute("list", service.getList(cri)); 
		d.addAttribute("page", new PageVO(cri, service.getCount())); 
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("uno") Long uno, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("상세조회.........................."+uno);
		d.addAttribute("unjoin", service.get(uno));
	}
}

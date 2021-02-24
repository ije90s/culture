package com.ije.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.CultureVO;
import com.ije.service.CultureService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/culture/*")
@Log4j
@RequiredArgsConstructor 
public class CultureController {

	private final CultureService service; 
	
	@GetMapping("/list")
	public void list(Model d) {
		log.info("전체 목록 호출..................................");
		d.addAttribute("list", service.getList()); 
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("cno") Long cno, Model d) {
		log.info("상세보기 호출.........................................");
		log.info("cno : " + cno);
		log.info("...........................................");
		d.addAttribute("culture", service.get(cno)); 
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("입력폼 호출..........................................");
	}
	
	@PostMapping("/register")
	public String register(CultureVO ins, RedirectAttributes rttr) {
		log.info("등록하기 호출.........................................");
		log.info(ins);
		log.info("...........................................");
		rttr.addFlashAttribute("result", service.registerKey(ins));
		return "redirect:/culture/list"; 
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("cno") Long cno, Model d) {
		log.info("수정폼 호출...........................................");
		log.info(service.get(cno));
		log.info("...........................................");
		d.addAttribute("culture", service.get(cno)); 
	}
	
	@PostMapping("/modify")
	public String modify(CultureVO upt, RedirectAttributes rttr) {
		log.info("수정하기 호출.........................................");
		log.info(upt);
		log.info("...........................................");
		rttr.addFlashAttribute("result", service.modify(upt));
		return "redirect:/culture/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("cno") Long cno, RedirectAttributes rttr) {
		log.info("삭제하기 호출...............................................");
		log.info("cno : " + cno);
		log.info("...........................................");
		rttr.addFlashAttribute("result", service.remove(cno)); 
		return "redirect:/culture/list";
	}
}

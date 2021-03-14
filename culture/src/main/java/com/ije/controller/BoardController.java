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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;
import com.ije.domain.PageVO;
import com.ije.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService service; 
	
	
	@GetMapping("/list")
	@PreAuthorize("isAuthenticated()")
	public void list(Criteria cri, Model d) {
		log.info("목록 출력.............................");
		d.addAttribute("list", service.getListPaging(cri)); 
		d.addAttribute("page", new PageVO(cri, service.getCount()));
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri , Model d) {
		log.info("게시글 : " + bno);
		d.addAttribute("board", service.get(bno)); 
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		log.info("게시글 등록폼....................");
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO ins, RedirectAttributes rd) {
		log.info("게시글 등록하기 : "+ins);
		service.register(ins);
		rd.addFlashAttribute("result", "1");
		return "redirect:/board/list";
	}
	
	@PreAuthorize("principal.username == #upt.writer")
	@PostMapping("/modify")
	public String modify(BoardVO upt, @ModelAttribute("cri") Criteria cri, RedirectAttributes rd) {
		log.info("게시글 수정하기: "+upt);
		int result = service.modify(upt); 
		if(result > 0 ) {
			rd.addFlashAttribute("result", result); 
		}
		rd.addAttribute("pageNum", cri.getPageNum());
		rd.addAttribute("amount", cri.getAmount());
		return "redirect:/board/list"; 
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rd, String writer) {
		log.info("게시글 삭제하기: " + bno);
		int result = service.remove(bno); 
		if(result > 0 ) {
			rd.addFlashAttribute("result", result); 
		}
		rd.addAttribute("pageNum", cri.getPageNum());
		rd.addAttribute("amount", cri.getAmount());	
		return "redirect:/board/list"; 
	}
	
	@GetMapping(value="/{kind}/top",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<List<BoardVO>> top(@PathVariable("kind") String kind){
		log.info("게시판 최신글 가져오기 : "+kind);
		return new ResponseEntity<>(service.topList(kind), HttpStatus.OK); 
	}

}

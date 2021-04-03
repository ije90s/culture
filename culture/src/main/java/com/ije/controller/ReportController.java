package com.ije.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.Criteria;
import com.ije.domain.PageVO;
import com.ije.domain.ReportVO;
import com.ije.service.ReportService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/report/*")
@RequiredArgsConstructor
public class ReportController {

	private final ReportService service; 
	
	@GetMapping("/list")
	public void list(@RequestParam("repoter") String reporter, Criteria cri, Model d) {
		log.info("리스트 출력..................");
		d.addAttribute("list", service.getList(cri, reporter)); 
		d.addAttribute("page", new PageVO(cri, service.getCount(cri, reporter))); 
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("rno") Long rno, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("상세 조회 : "+rno);
		d.addAttribute("report", service.get(rno));
	}
	
	
	@PostMapping("/modify")
	public String modify(@ModelAttribute("report") ReportVO upt, @ModelAttribute("cri") Criteria cri, RedirectAttributes rd) {
		log.info("내용 수정.......................");
		log.info(upt);
		int result = service.modify(upt); 
		if(result > 0) {
			rd.addFlashAttribute("result", result); 
		}
		return "redirect:/report/list/"+cri.getListLink(); 
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("rno") Long rno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rd) {
		log.info("내용 삭제......................."+rno);
		int result = service.remove(rno); 
		if(result > 0) {
			rd.addFlashAttribute("result", result); 
		}
		return "redirect:/report/list/"+cri.getListLink(); 
	}
	
	@PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> register(@RequestBody ReportVO ins){
		log.info("신고 등록..........................");
		log.info(ins);
		return service.register(ins)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/{kind}/{no}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<ReportVO> get(@PathVariable("kind") String kind, @PathVariable("no") Long no){
		log.info("신고 조회.........................."+kind+", "+no);
		return new ResponseEntity<>(service.getByNo(kind, no), HttpStatus.OK);
	}
	
	@PutMapping(value="/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> modify(@PathVariable("rno") Long rno, @RequestBody ReportVO upt){
		log.info("신고 수정 : " +rno);
		return service.modify(upt)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@DeleteMapping(value="/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		log.info("신고 삭제 : "+rno);
		return service.remove(rno)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}

package com.ije.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
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

import com.ije.domain.Criteria;
import com.ije.domain.MemberLogVO;
import com.ije.domain.PageVO;
import com.ije.service.MemberLogService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/log/*")
public class MemberLogController {
	
	private final MemberLogService service; 
	
	@GetMapping("/list")
	public void list(Criteria cri, Model d) {
		d.addAttribute("list", service.getList(cri)); 
		d.addAttribute("page", new PageVO(cri, service.getCount(cri)));
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("target") String target, @RequestParam("subPage") int subPage, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("조회 : "+target);
		d.addAttribute("target", target); 
		d.addAttribute("subPage", subPage);
	}
	
	@GetMapping(value="/{target}/pages/{subPage}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<List<MemberLogVO>> get(@PathVariable("target") String target, @PathVariable("subPage") int subPage){
		Criteria sub = new Criteria(subPage, 3);
		return new ResponseEntity<>(service.getByTarget(sub, target), HttpStatus.OK); 
	}
	
	@GetMapping(value="/{lno}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<MemberLogVO> get(@PathVariable("lno") Long lno){
		log.info("최신 1개의 로그 조회 : "+lno);
		return new ResponseEntity<>(service.get(lno), HttpStatus.OK); 
	}
	
	@PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> regiter(@Valid @RequestBody MemberLogVO ins, BindingResult result){
		log.info("로그 등록 ...................................");
		log.info(ins);
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			//log.info(ResponseEntity.badRequest().build());
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR); 
		}
		return service.register(ins)?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@PutMapping(value="/{lno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("lno") Long lno, @Valid @RequestBody MemberLogVO upt, BindingResult result){
		log.info("로그 수정 ...................................");
		log.info(upt);
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			//log.info(ResponseEntity.badRequest().build());
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR); 
		}
		return service.modify(upt)?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@DeleteMapping(value="/{lno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("lno") Long lno){
		log.info("로그 삭제 ...................................");
		log.info(lno);
		return service.remove(lno)?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
}

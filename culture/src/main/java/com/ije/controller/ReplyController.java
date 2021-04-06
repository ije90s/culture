package com.ije.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ije.domain.Criteria;
import com.ije.domain.ReplyPageDTO;
import com.ije.domain.ReplyVO;
import com.ije.service.ReplyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/reply/")
@RestController
@Log4j
@RequiredArgsConstructor
public class ReplyController {
	
	private final ReplyService service; 
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	@PostMapping(value="/new", consumes = "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO ins){
		log.info("ReplyVO : " + ins);
		
		return service.register(ins) ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	
	@GetMapping(value = "/pages/{bno}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getListPaging(@PathVariable("bno") Long bno, @PathVariable("page") int page){
		log.info("getListPaging........................");
		Criteria cri = new Criteria(page,10); 
		log.info(cri);
		return new ResponseEntity<>(service.getListPaging(cri, bno), HttpStatus.OK);
	}
	
	@GetMapping(value="/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		log.info("조회 : " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK); 
	}
	
	@PreAuthorize("principal.username == #upt.replyer or hasRole('ROLE_ADMIN')")
	@PutMapping(value="/{rno}", consumes = "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("rno") Long rno, @RequestBody ReplyVO upt){
		log.info("수정 : " + rno);
		log.info(upt);
		return service.modify(upt)? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PreAuthorize("principal.username == #del.replyer or hasRole('ROLE_ADMIN')")
	@DeleteMapping("/{rno}")
	public ResponseEntity<String> remove(@RequestBody ReplyVO del, @PathVariable("rno") Long rno){
		log.info("삭제 : "+rno);
		log.info("replyer : " + del.getReplyer());
		return service.remove(rno)? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/{replyer}/count", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<Integer> count(@PathVariable("replyer") String replyer){
		return new ResponseEntity<>(service.getCountByReplyer(replyer), HttpStatus.OK);
	}
	
	@GetMapping(value="/{replyer}/pages/{page}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<List<ReplyVO>> replyer(@PathVariable("replyer") String replyer, @PathVariable("page") int page){
		Criteria cri = new Criteria(); 
		cri.setPageNum(page);
		log.info(service.getListReplyer(cri, replyer));
		return new ResponseEntity<>(service.getListReplyer(cri, replyer), HttpStatus.OK);
	}
	
}

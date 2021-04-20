package com.ije.controller;



import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ije.domain.Criteria;
import com.ije.domain.MessageVO;
import com.ije.service.MessageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/message/*")
@Log4j
@RequiredArgsConstructor
public class MessageController {

	private final MessageService service; 
	
	@PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody MessageVO ins){
		log.info("쪽지 등록하기.......................");
		log.info(ins);
		int result = service.register(ins); 
		return result>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/{mno}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<MessageVO> get(@PathVariable("mno") Long mno){
		log.info("쪽지 조회하기............................");
		log.info(mno);
		return new ResponseEntity<>(service.get(mno), HttpStatus.OK); 
	}
	
	@GetMapping(value="/list/{type}/{keyword}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<MessageVO>> list(@PathVariable("type") String type, @PathVariable("keyword") String keyword){
		log.info("리스트 조회하기................................");
		log.info(type+" "+keyword);
		Criteria cri = new Criteria(); 
		cri.setType(type);
		cri.setKeyword(keyword);
		return new ResponseEntity<>(service.getList(cri), HttpStatus.OK); 
	}
	
	@PutMapping(value="/{mno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("mno") Long mno, @RequestBody MessageVO upt){
		log.info("쪽지 수정하기....................");
		log.info(upt);
		return service.modify(upt)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@PutMapping(value="/odate/{mno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modifyOdate(@PathVariable("mno") Long mno){
		log.info("쪽지 읽음....................");
		log.info(mno);
		return service.modifyOdate(mno)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@DeleteMapping(value="{mno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("mno") Long mno){
		log.info("쪽지 삭제..........................");
		log.info(mno);
		return service.remove(mno)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}

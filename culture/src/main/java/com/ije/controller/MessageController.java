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
import com.ije.domain.MessagePageDTO;
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
	
	@GetMapping(value="/{mno}/{userid}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<MessageVO> get(@PathVariable("mno") Long mno, @PathVariable("userid") String userid){
		log.info("쪽지 조회하기............................");
		log.info(mno);
		return new ResponseEntity<>(service.get(mno, userid), HttpStatus.OK); 
	}
	
	@GetMapping(value="/pages/{type}/{keyword}/{page}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<MessagePageDTO> list(@PathVariable("type") String type, @PathVariable("keyword") String keyword, @PathVariable("page") int page){
		log.info("리스트 조회하기................................");
		log.info(type+" "+keyword);
		Criteria cri = new Criteria(); 
		cri.setPageNum(page);
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
	
	@DeleteMapping(value="{mno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("mno") Long mno){
		log.info("쪽지 삭제..........................");
		log.info(mno);
		return service.remove(mno)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/notRead/{target}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<MessageVO>> notRead(@PathVariable("target") String target) {
		log.info("안읽은 쪽지...............................");
		log.info(target);
		log.info(service.getListByTarget(target));
		return new ResponseEntity<>(service.getListByTarget(target), HttpStatus.OK);
	}
	
}

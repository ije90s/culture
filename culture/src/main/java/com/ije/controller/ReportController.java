package com.ije.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.validation.Valid;
import javax.xml.ws.BindingType;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.AttachFileVO;
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
	
	@GetMapping("/list/{object}")
	@PreAuthorize("isAuthenticated()")
	public String list(@PathVariable("object") String object, @RequestParam("tab") String tab, Criteria cri, Model d) {
		log.info("리스트 출력..................");
		d.addAttribute("list", service.getList(cri, object,tab)); 
		d.addAttribute("page", new PageVO(cri, service.getCount(cri, object,tab))); 
		d.addAttribute("tab", tab);
		return "/report/list";
	}
	
	@GetMapping({"/get", "/modify"})
	@PreAuthorize("isAuthenticated()")
	public void get(@RequestParam("rno") Long rno, @ModelAttribute("cri") Criteria cri, @ModelAttribute("tab") String tab, Model d) {
		log.info("상세 조회 : "+rno);
		d.addAttribute("report", service.get(rno));
	}
	
	
	@PostMapping("/modify")
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	public String modify(@RequestParam("object") String object, @Valid @ModelAttribute("report") ReportVO upt, BindingResult result,  @ModelAttribute("cri") Criteria cri, @ModelAttribute("tab") String tab, RedirectAttributes rd) {
		log.info("내용 수정.......................");
		log.info(upt);
	
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			return "/report/modify";
		}		
		
		int updateResult = service.modify(upt); 
		if(updateResult > 0) {
			rd.addFlashAttribute("result", updateResult); 
		}
		rd.addAttribute("tab", tab); 
		return "redirect:/report/list/"+object+cri.getListLink(); 
	}
	
	@PostMapping("/remove")
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	public String remove(@RequestParam("rno") Long rno, @RequestParam("object") String object, @ModelAttribute("cri") Criteria cri, @ModelAttribute("tab") String tab, RedirectAttributes rd) {
		log.info("내용 삭제......................."+rno);
		int result = service.remove(rno); 
		if(result > 0) {
			rd.addFlashAttribute("result", result); 
		}
		rd.addAttribute("tab", tab); 
		return "redirect:/report/list/"+object+cri.getListLink(); 
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping(value="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> register(@Valid @RequestBody ReportVO ins, BindingResult result){
		
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR); 
		}
		
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
	
	@PreAuthorize("principal.username == #upt.mid")
	@PutMapping(value="/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> modify(@PathVariable("rno") Long rno, @Valid @RequestBody ReportVO upt, BindingResult result){
		log.info("신고 수정 : " +rno);
		
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR); 
		}
		
		return service.modify(upt)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@PreAuthorize("principal.username == #del.mid")
	@DeleteMapping(value="/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno, @RequestBody ReportVO del){
		log.info("신고 삭제 : "+rno);
		return service.remove(rno)>0?new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/top", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<List<ReportVO>> top(){
		Criteria cri = new Criteria(); 
		String object = "all"; 
		String tab = "all";  
		return new ResponseEntity<>(service.getList(cri, object, tab), HttpStatus.OK);
	}
}

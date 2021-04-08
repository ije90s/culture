package com.ije.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ije.domain.Criteria;
import com.ije.domain.LoginVO;
import com.ije.domain.MemberVO;
import com.ije.domain.PageVO;
import com.ije.service.BoardService;
import com.ije.service.CultureService;
import com.ije.service.LoginService;
import com.ije.service.MemberService;

import lombok.RequiredArgsConstructor;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private final LoginService service; 
	
	private final BoardService boardService;
	
	private final MemberService memberService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public String home(Authentication auth, Model model) {

		logger.info("방문자 기록 ");
		
		// 방문 기록 추가 
		Date today = new Date(); 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		String rdate = sdf.format(today);
		
		UserDetails userDetails = (UserDetails)	auth.getPrincipal(); 
		String id = userDetails.getUsername();  
		
		LoginVO ins = service.get(id, rdate); 
		if(ins==null && !userDetails.getAuthorities().toString().contains("ROLE_ADMIN")) {
			ins = new LoginVO(); 
			ins.setId(id);
			service.register(ins);
		}		
		
		return "home";
	}
	
	@GetMapping("/search")
	@PreAuthorize("isAuthenticated()")
	public void search(@RequestParam("type") String type, @RequestParam("keyword") String keyword, Model d) {
		logger.info("통합검색 ");
		d.addAttribute("type", type); 
		d.addAttribute("keyword", keyword); 
	}
	
	@GetMapping("/activity")
	@PreAuthorize("isAuthenticated()")
	public void activity(@ModelAttribute("cri") Criteria cri, Model d) {
		String kind = "all"; 
		d.addAttribute("list", boardService.getListPaging(cri, kind)); 
		d.addAttribute("page", new PageVO(cri, boardService.getCount(cri, kind)));
	}
	
	@GetMapping(value="/login/{id}/count", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<Integer> count(@PathVariable("id") String id){
		return new ResponseEntity<>(service.getCount(id), HttpStatus.OK);
	}
	
	@GetMapping(value={"/findId", "/findPw"})
	public void find() {
		logger.info("아이디/비밀번호 찾기");
	}
}

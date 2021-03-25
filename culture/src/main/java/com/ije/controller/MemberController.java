package com.ije.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import javax.xml.crypto.URIDereferencer;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;
import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;
import com.ije.service.MemberService;
import com.ije.service.UnjoinService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
@RequiredArgsConstructor
public class MemberController {

	private final MemberService service; 
	private final UnjoinService unjoinService;
	private final PasswordEncoder pass; 
	

	@GetMapping("/join")
	public void join() {
		log.info("회원가입 폼 ....................");
	}
	
	@PostMapping("/join")
	public String join(@Valid @ModelAttribute MemberVO ins, BindingResult result, RedirectAttributes rttr) {
		log.info("회원가입 처리중........................");	
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			return "/member/join";
		}
		ins.setPw(pass.encode(ins.getPw()));
		service.register(ins);
		rttr.addFlashAttribute("result", "1");
		return "redirect:/customLogin"; 
	}
	
	@GetMapping(value="/{id}", produces ={MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> confirm(@PathVariable("id") String id){
		MemberVO vo = service.read(id); 
		String result = "ok"; 
		if(vo!=null) result = "no"; 
		return new ResponseEntity<>(result, HttpStatus.OK); 
	}
	
	
	@GetMapping(value="/{id}/{pw}", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> confirm(@PathVariable("id") String id, @PathVariable("pw") String pw){
		MemberVO vo = service.read(id); 
		String result = "ok"; 
		pw = URLDecoder.decode(pw); 
		if(pass.matches(pw, vo.getPw())) 
			result = "no"; 
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@GetMapping("/myprofile/{mno}")
	@PreAuthorize("isAuthenticated()")
	public String myprofile(@PathVariable("mno") Long mno, Model d) {
		log.info("프로필 화면..........");
		d.addAttribute("member", service.read2(mno));
		return "/member/myprofile";
	}
	
	
	@PreAuthorize("principal.username == #upt.id")
	@PutMapping(value="/modify", consumes = "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@Valid @RequestBody MemberVO upt, BindingResult result ) {
		log.info("회원 정보 수정하기 : " + upt);
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			//log.info(ResponseEntity.badRequest().build());
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR); 
		}
		int updateResult = service.modify(upt);
		return updateResult>0?new ResponseEntity<>("success", HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);  
	}
	
	@PreAuthorize("principal.username == #upt.id")
	@PatchMapping(value="/changePw", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> changePw(@Valid @RequestBody MemberVO upt, BindingResult result) {
		log.info("비밀번호 변경하기: " + upt);
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR); 			
		}
		String originPw = service.read(upt.getId()).getPw(); 
		if(pass.matches(upt.getPw(), originPw))
			return new ResponseEntity<>("fail2", HttpStatus.INTERNAL_SERVER_ERROR);
		upt.setPw(pass.encode(upt.getPw()));
		int updateResult = service.modify(upt); 
		
		return updateResult>0?new ResponseEntity<>("success", HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);  
	}
	
	private void deleteFiles(List<AttachFileVO> attachList) {
		if(attachList == null || attachList.size() <=0) {
			return; 
		}
		
		log.info("delete attach files........................");
		log.info(attachList);
		
		attachList.forEach(attach ->{
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getPath()+"\\"+attach.getUuid()+"_"+attach.getFileName()); 
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumnail = Paths.get("C:\\upload\\"+attach.getPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumnail);
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				log.info("delete file error : " +e.getMessage());
			}
		});
	}	
	
	@PreAuthorize("principal.username == #ins.id")
	@DeleteMapping(value="/unjoin", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> unjoin(@RequestBody UnjoinVO ins) {
		log.info("unJoinVO : " + ins);
		MemberVO vo = service.read(ins.getId()); 
		if(vo.getAttachList() != null) {
			deleteFiles(vo.getAttachList().get(0).getFileList()); 
		}
		unjoinService.register(ins);
		return new ResponseEntity<>("success", HttpStatus.OK); 
	}
	
	
	@PreAuthorize("principal.member.mno == #mno")
	@PutMapping("/modifyPhoto/{mno}")
	public ResponseEntity<String> modifyPhoto(@PathVariable("mno") Long mno, @RequestBody AttachFileVO files) {
		log.info("사진 바꾸기"); 
		log.info("upt :"+files);
		MemberVO upt = service.read2(mno);
		
		List<AttachFileVO> af = new ArrayList<AttachFileVO>(); 
		af.add(files);
		
		AttachVO vo = new AttachVO(); 
		vo.setFileList(af);
		List<AttachVO> fileList = new ArrayList<AttachVO>();
		fileList.add(vo); 
		
		upt.setMno(mno);
		upt.setAttachList(fileList);
		if(upt.getAttachList()!=null && upt.getAttachList().size()>0) {
			service.modifyPhoto(upt);
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long mno){
		
		log.info("첨부파일 호출..............................................");
		log.info(mno);
		log.info(service.getAttach(mno));
		return new ResponseEntity<>(service.getAttach(mno), HttpStatus.OK);
	}	

}

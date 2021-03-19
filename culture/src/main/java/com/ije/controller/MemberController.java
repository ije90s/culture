package com.ije.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;
import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;
import com.ije.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
@RequiredArgsConstructor
public class MemberController {

	private final MemberService service; 
	

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
	

	@GetMapping("/myprofile")
	@PreAuthorize("isAuthenticated()")
	public void myprofile(@RequestParam("id") String id, Model d) {
		log.info("프로필 화면..........");
		d.addAttribute("member", service.read(id));
	}
	
	@PostMapping("/modify")
	public String modify(MemberVO upt, RedirectAttributes rttr) {
		log.info("회원 정보 수정하기 : " + upt);
		if(service.modify(upt) > 0 ) {
			rttr.addFlashAttribute("result", "1"); 
		}
		rttr.addAttribute("id", upt.getId()); 
		return "redirect:/member/myprofile";
	}
	
	@PostMapping("/changePw")
	public String changePw(MemberVO upt, RedirectAttributes rttr) {
		log.info("비밀번호 변경하기: " + upt);
		if(service.modifyPW(upt) > 0) {
			rttr.addFlashAttribute("result", "1");
		}
		rttr.addAttribute("id", upt.getId()); 
		return "redirect:/member/myprofile";
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
	
	@PostMapping("/unjoin")
	public String unjoin(@RequestParam("mno") Long mno, UnjoinVO ins, RedirectAttributes rttr) {
		log.info("탈퇴하기 "+ mno); 
		log.info("unJoinVO : " + ins);
		if(ins.getMemo()==null) {
			ins.setMemo("");
		}
		service.registerUnjoin(ins);
		if(service.remove(mno) > 0) {
			rttr.addFlashAttribute("result", "1");
		}
		return "redirect:/customLogin"; 
	}
	
	@PostMapping("/modifyPhoto")
	@PreAuthorize("principal.member.mno == #upt.mno")
	public String modifyPhoto(MemberVO upt, RedirectAttributes rttr) {
		log.info("사진 바꾸기"); 
		log.info("upt :"+upt);
		if(upt.getAttachList()!=null && upt.getAttachList().size()>0) {
			service.modifyPhoto(upt);
			rttr.addFlashAttribute("result", "1");
		}
		rttr.addAttribute("id", upt.getId()); 
		return "redirect:/member/myprofile";
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<AttachVO> getAttachList(Long mno){
		
		log.info("첨부파일 호출..............................................");
		
		return new ResponseEntity<>(service.getAttach(mno), HttpStatus.OK);
	}	

}

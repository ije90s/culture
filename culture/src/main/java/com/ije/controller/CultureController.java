package com.ije.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;
import com.ije.domain.Criteria;
import com.ije.domain.CultureVO;
import com.ije.domain.PageVO;
import com.ije.service.CultureService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/culture/*")
@Log4j
@RequiredArgsConstructor 
public class CultureController {

	private final CultureService service; 
	
	/*@GetMapping("/list")
	public void list(Model d) {
		log.info("전체 목록 호출..................................");
		d.addAttribute("list", service.getList()); 
	}*/
	
	@GetMapping("/list")
	public void list(Criteria cri, Model d) {
		log.info("페이징 호출..............................................");
		d.addAttribute("list", service.getListPaging(cri)); 
		d.addAttribute("page", new PageVO(cri, service.getCount(cri)));
	}
		
	@GetMapping("/get")
	public void get(@RequestParam("cno") Long cno, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("상세보기 호출.........................................");
		log.info("cno : " + cno);
		log.info("...........................................");
		d.addAttribute("culture", service.get(cno)); 
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("입력폼 호출..........................................");
	}
	
	
	@PostMapping("/register")
	public String register(CultureVO ins, RedirectAttributes rttr) {
		//log.info("등록하기 호출.........................................");
		//log.info(ins);
		log.info("=============================================================");
		if(ins.getAttachList() != null) {
			ins.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("=============================================================");
		service.registerKey(ins);
		log.info("register : " + ins);
		rttr.addFlashAttribute("result", "1");
		return "redirect:/culture/list"; 
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("cno") Long cno, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("수정폼 호출...........................................");
		log.info(service.get(cno));
		log.info("...........................................");
		d.addAttribute("culture", service.get(cno)); 
	}
	
	@PostMapping("/modify")
	public String modify(CultureVO upt, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("수정하기 호출.........................................");
		log.info(upt);
		log.info("...........................................");
		if(service.modify(upt) > 0) {
			rttr.addFlashAttribute("result", service.modify(upt));
		}
		rttr.addAttribute("pageNum", cri.getPageNum()); 
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/culture/list";
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
	
	@PostMapping("/remove")
	public String remove(@RequestParam("cno") Long cno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("삭제하기 호출...............................................");
		log.info("cno : " + cno);
		log.info("...........................................");
		List<AttachVO> attachList = service.getAttachList(cno); 
		List<AttachFileVO> FileList = attachList.get(0).getFileList();
		if(service.remove(cno) > 0) {
			deleteFiles(FileList); 
			rttr.addFlashAttribute("result", service.remove(cno)); 
		}
		rttr.addAttribute("pageNum", cri.getPageNum()); 
		rttr.addAttribute("amount", cri.getAmount());		
		return "redirect:/culture/list";
	}	
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long cno){
		
		log.info("첨부파일 호출..............................................");
		
		return new ResponseEntity<>(service.getAttachList(cno), HttpStatus.OK);
	}
}

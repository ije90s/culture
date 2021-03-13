package com.ije.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	@PreAuthorize("isAuthenticated()")
	public void list(@RequestParam("mno") Long mno, Criteria cri, Model d) {
		log.info("페이징 호출..............................................");
		d.addAttribute("list", service.getListPaging(cri, mno)); 
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
	@PreAuthorize("isAuthenticated()")
	public void register() {
		log.info("입력폼 호출..........................................");
	}
	
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
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
		rttr.addAttribute("mno", ins.getMno()); 
		return "redirect:/culture/list"; 
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("cno") Long cno, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("수정폼 호출...........................................");
		log.info(service.get(cno));
		log.info("...........................................");
		d.addAttribute("culture", service.get(cno)); 
	}
	
	@PreAuthorize("principal.member.mno == #upt.mno")
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
		rttr.addAttribute("mno", upt.getMno()); 
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
	
	@PreAuthorize("principal.member.mno == #mno")
	@PostMapping("/remove")
	public String remove(@RequestParam("cno") Long cno, @RequestParam("mno") Long mno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("삭제하기 호출...............................................");
		log.info("cno : " + cno);
		log.info("...........................................");
		List<AttachVO> attachList = service.getAttachList(cno); 
		if(service.remove(cno) > 0) {
			if(attachList !=null && attachList.size() > 0) {
				List<AttachFileVO> FileList = attachList.get(0).getFileList();
				deleteFiles(FileList); 
			}
			rttr.addFlashAttribute("result", service.remove(cno)); 
		}
		rttr.addAttribute("pageNum", cri.getPageNum()); 
		rttr.addAttribute("amount", cri.getAmount()); 
		rttr.addAttribute("mno", mno);
		return "redirect:/culture/list";
	}	
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long cno){
		
		log.info("첨부파일 호출..............................................");
		
		return new ResponseEntity<>(service.getAttachList(cno), HttpStatus.OK);
	}
	
	@GetMapping("/stats")
	@PreAuthorize("isAuthenticated()")
	public void stats(Criteria cri, Model d) {
		log.info("통계..............................................");
	}
	

	
	@GetMapping(value="/{tab}/{mno}/{sdate}/{edate}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CultureVO>> stats(@PathVariable("tab") String tab,@PathVariable("mno") Long mno,  @PathVariable("sdate") String sdate, @PathVariable("edate") String edate,  Criteria cri, Model d) {
		log.info("통계..............................................");
		cri.setSdate(sdate);
		cri.setEdate(edate);
		List<CultureVO> list = new ArrayList<CultureVO>(); 
		if(tab.equals("mon")) {
			list = service.getMonList(cri, mno);
		}else if(tab.equals("year")) {
			list = service.getYearList(cri, mno); 
		}else {
			list = service.getChartList(cri, mno);
		}
		log.info(list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping(value="/{mno}/{sdate}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CultureVO>> get(@PathVariable("mno") Long mno, @PathVariable("sdate") String sdate, Criteria cri){
		log.info("get : " + sdate);
		cri.setSdate(sdate);
		return new ResponseEntity<>(service.getBySdate(cri, mno), HttpStatus.OK);
	}
	
}

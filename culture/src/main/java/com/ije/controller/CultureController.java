package com.ije.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
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
	
	@GetMapping("/list/{id}")
	@PreAuthorize("isAuthenticated()")
	public String list(@PathVariable("id") String id, Criteria cri, Model d) {
		log.info("페이징 호출..............................................");
		d.addAttribute("list", service.getListPaging(cri,id)); 
		d.addAttribute("page", new PageVO(cri, service.getCount(cri,id)));
		return "/culture/list";
	}
		
	@GetMapping("/get")
	@PreAuthorize("isAuthenticated()")
	public void get(@RequestParam("cno") Long cno, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("상세보기 호출.........................................");
		log.info("cno : " + cno);
		log.info("...........................................");
		d.addAttribute("culture", service.get(cno)); 
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register(Model d) {
		log.info("입력폼 호출..........................................");
	}
	
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(@RequestHeader("User-Agent") String userAgent, @Valid @ModelAttribute CultureVO ins, BindingResult result, RedirectAttributes rttr) {
		//log.info("등록하기 호출.........................................");
		//log.info(ins);
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			if(ins.getAttachList() !=null) {
				List<AttachFileVO> fileList = ins.getAttachList().get(0).getFileList();
				fileList.forEach(attach -> {
					try {
						if(userAgent.contains("IE browser")) {
							attach.setPath(URLEncoder.encode(attach.getPath(), "UTF-8").replaceAll("\\+", " "));
						}else{
							attach.setPath(URLEncoder.encode(attach.getPath(), "UTF-8"));	
						}
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				});

			}
			return "/culture/register";
		}
		
		log.info("=============================================================");
		if(ins.getAttachList() != null) {
			ins.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("=============================================================");
		service.registerKey(ins);
		log.info("register : " + ins);
		rttr.addFlashAttribute("result", "1");
		return "redirect:/culture/list/"+ins.getWriter(); 
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("cno") Long cno, @ModelAttribute("cri") Criteria cri, Model d) {
		log.info("수정폼 호출...........................................");
		log.info(service.get(cno));
		log.info("...........................................");
		d.addAttribute("culture", service.get(cno)); 
	}
	
	@PreAuthorize("principal.username == #upt.writer or hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modify(@RequestParam("object") String object, @RequestHeader("User-Agent") String userAgent, @Valid @ModelAttribute("culture") CultureVO upt, BindingResult result, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}
			if(upt.getAttachList() !=null) {
				List<AttachFileVO> fileList = upt.getAttachList().get(0).getFileList();
				fileList.forEach(attach -> {
					try {
						if(userAgent.contains("IE browser")) {
							attach.setPath(URLEncoder.encode(attach.getPath(), "UTF-8").replaceAll("\\+", " "));
						}else{
							attach.setPath(URLEncoder.encode(attach.getPath(), "UTF-8"));	
						}
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				});

			}
			return "/culture/modify";			
		}
		
		log.info("수정하기 호출.........................................");
		log.info(upt);
		log.info("...........................................");
		if(service.modify(upt) > 0) {
			rttr.addFlashAttribute("result", service.modify(upt));
		}
		return "redirect:/culture/list/"+object+cri.getListLink();
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
	
	@PreAuthorize("principal.username == #object or hasRole('ROLE_ADMIN')")
	@PostMapping("/remove")
	public String remove(@RequestParam("cno") Long cno, @RequestParam("object") String object, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("삭제하기 호출...............................................");
		log.info("cno : " + cno);
		log.info("...........................................");
		CultureVO vo = service.get(cno);
		List<AttachVO> attachList = service.getAttachList(cno); 
		if(service.remove(cno) > 0) {
			if(attachList !=null && attachList.size() > 0) {
				List<AttachFileVO> FileList = attachList.get(0).getFileList();
				deleteFiles(FileList); 
			}
			rttr.addFlashAttribute("result", service.remove(cno)); 
		}
		return "redirect:/culture/list/"+object+cri.getListLink();
	}	
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long cno){
		
		log.info("첨부파일 호출..............................................");
		
		return new ResponseEntity<>(service.getAttachList(cno), HttpStatus.OK);
	}
	
	@GetMapping("/stats/{id}")
	@PreAuthorize("isAuthenticated()")
	public String stats(@PathVariable("id") String id, Criteria cri, Model d) {
		log.info("통계..............................................");
		return "/culture/stats";
	}
	

	
	@GetMapping(value="/{tab}/{id}/{sdate}/{edate}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CultureVO>> stats(@PathVariable("tab") String tab,@PathVariable("id") String id,  @PathVariable("sdate") String sdate, @PathVariable("edate") String edate,  Criteria cri, Model d) {
		log.info("통계..............................................");
		cri.setSdate(sdate);
		cri.setEdate(edate);
		List<CultureVO> list = new ArrayList<CultureVO>(); 
		if(tab.equals("mon")) {
			list = service.getMonList(cri,id);
		}else if(tab.equals("year")) {
			list = service.getYearList(cri,id); 
		}else {
			list = service.getChartList(cri,id);
		}
		log.info(list);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping(value="/{id}/{sdate}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CultureVO>> get(@PathVariable("id") String id, @PathVariable("sdate") String sdate, Criteria cri){
		log.info("get : " + sdate);
		cri.setSdate(sdate);
		return new ResponseEntity<>(service.getBySdate(cri,id), HttpStatus.OK);
	}
	
	
	@GetMapping(value="/top/{id}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<CultureVO>> top(@PathVariable("id") String id){
		log.info("최근 글 10기만 가져오기"); 
		Criteria cri = new Criteria(); 
		return new ResponseEntity<>(service.getListPaging(cri,id), HttpStatus.OK); 
	}	
	
	@GetMapping(value="/search/pages/{page}/{type}/{keyword}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<List<CultureVO>> search(@PathVariable("page") int page, @PathVariable("type") String type, @PathVariable("keyword") String keyword){
		log.info("검색 내용 : "+type+","+keyword);
		Criteria cri = new Criteria(page, 3);
		cri.setType(type);
		cri.setKeyword(keyword);
		return new ResponseEntity<>(service.getListSearch(cri), HttpStatus.OK);
	}
	
	@GetMapping(value="/count/{id}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public int count(@PathVariable("id") String id){
		log.info("문화기록 등록건수 : " + id);
		Criteria cri = new Criteria(); 
		return service.getCount(cri, id); 
	}
}

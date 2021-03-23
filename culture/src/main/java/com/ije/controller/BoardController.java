package com.ije.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;
import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;
import com.ije.domain.PageVO;
import com.ije.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService service; 
	
	
	@GetMapping("/list/{kind}")
	@PreAuthorize("isAuthenticated()")
	public String list(@PathVariable("kind") String kind, Criteria cri, Model d) {
		log.info("목록 출력.............................");
		//log.info( service.getListPaging(cri));
		d.addAttribute("list", service.getListPaging(cri, kind)); 
		d.addAttribute("page", new PageVO(cri, service.getCount(cri, kind)));
		d.addAttribute("kind", kind);
		return "/board/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri , Model d) {
		log.info("게시글 : " + bno);
		d.addAttribute("board", service.get(bno)); 
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register(@RequestParam("kind") String kind, Model d) {
		log.info("게시글 등록폼....................");
		d.addAttribute("kind", kind);
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(@RequestHeader("User-Agent") String userAgent, @Valid @ModelAttribute BoardVO ins, BindingResult result, RedirectAttributes rd) {
		
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
			return "/board/register";
		}
		log.info("게시글 등록하기 : "+ins);
		log.info("=============================================================");
		if(ins.getAttachList() != null) {
			ins.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("=============================================================");
		service.register(ins);
		rd.addFlashAttribute("result", "1");
		return "redirect:/board/list/"+ins.getKind();
	}
	
	@PreAuthorize("principal.username == #upt.writer")
	@PostMapping("/modify")
	public String modify(@RequestHeader("User-Agent") String userAgent, @Valid @ModelAttribute("board") BoardVO upt, BindingResult result, @ModelAttribute("cri") Criteria cri, RedirectAttributes rd) {
		log.info("게시글 수정하기: "+upt);
		
		if(result.hasErrors()) {
			for(ObjectError obj : result.getAllErrors()) {
				System.out.println("메시지 : "+obj.getDefaultMessage());
				System.out.println("코드 :"+obj.getCode());
				System.out.println("ObjectName :"+obj.getObjectName());
			}		
			return "/board/modify";
		}		
		
		int updateResult = service.modify(upt); 
		if(updateResult > 0 ) {
			rd.addFlashAttribute("result", updateResult); 
		}
		return "redirect:/board/list/"+upt.getKind()+cri.getListLink(); 
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
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rd, String writer) {
		log.info("게시글 삭제하기: " + bno);
		BoardVO vo = service.get(bno); 
		int result = service.remove(bno); 
		List<AttachVO> attachList = service.getAttachList(bno); 
		if(result > 0 ) {
			if(attachList !=null && attachList.size() > 0) {
				List<AttachFileVO> FileList = attachList.get(0).getFileList();
				deleteFiles(FileList); 
			}
			rd.addFlashAttribute("result", result); 
		}
		return "redirect:/board/list/"+vo.getKind()+cri.getListLink(); 
	}
	
	@GetMapping(value="/{kind}/top",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<List<BoardVO>> top(@PathVariable("kind") String kind){
		log.info("게시판 최신글 가져오기 : "+kind);
		return new ResponseEntity<>(service.topList(kind), HttpStatus.OK); 
	}


	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long bno){
		
		log.info("첨부파일 호출..............................................");
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}	
	
}

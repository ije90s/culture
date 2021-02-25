package com.ije.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ije.domain.FileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class uploadController {

	private String getFolder(String folder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		Date date = new Date(); 
		String str = folder+sdf.format(date);
		
		return str.replace("-", File.separator); 
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image"); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return false; 
	}
	
	@PostMapping(value="/uploadAction", produces= MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<FileDTO>> uploadFile(MultipartFile[] upload, String folder) {
		log.info("파일 첨부.....................................");
		
		List<FileDTO> list = new ArrayList<>(); 
		
		//log.info(folder);
		String uploadFolder = "C:\\upload";
		String uploadFolderPath = getFolder(folder+"-");
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("Upload Path: "+uploadPath);
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs(); 
		}
		
		for(MultipartFile multipartFile : upload) {
			log.info("---------------------------------------------");
			log.info("Upload File Name: "+multipartFile.getOriginalFilename());
			log.info("Upload File Size: "+multipartFile.getSize());
			
			FileDTO attach = new FileDTO(); 
			
			String uploadFileName = multipartFile.getOriginalFilename(); 
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1); 
			attach.setFileName(uploadFileName);
			log.info(uploadFileName);
			
			UUID uuid = UUID.randomUUID(); 
			uploadFileName = uuid.toString()+"_"+uploadFileName; 
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attach.setUuid(uuid.toString());
				attach.setUploadPath(uploadFolderPath);
				
				if(checkImageType(saveFile)) {
					attach.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				list.add(attach); 
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		
		return new ResponseEntity<>(list, HttpStatus.OK); 
		
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("fileName : " + fileName);
		
		File file = new File("c:\\upload\\"+fileName); 
		
		log.info("file: "+file);
		
		ResponseEntity<byte[]> result=null; 
		
		try {
			HttpHeaders header = new HttpHeaders(); 
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result; 
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("delete FileName : "+ fileName);
		
		File file; 
		
		try {
			file = new File("C:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete(); 
			
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", ""); 
				log.info("largeFileName: "+largeFileName);
				file = new File(largeFileName); 
				
				file.delete(); 
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND); 
		} 
		
		return new ResponseEntity<>("deleted", HttpStatus.OK); 
	}
}

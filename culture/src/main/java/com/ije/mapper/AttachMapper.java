package com.ije.mapper;

import java.util.List;

import com.ije.domain.AttachVO;


public interface AttachMapper {

	
	public List<AttachVO> findByCno(Long cno);	
	
	public void insert(List<AttachVO> ins);
	
	
	//public int delete(String uuid);
	public void deleteFile(String uuid); 
	public void deleteFileAll(Long cno);
	public void delete(); 
	
}

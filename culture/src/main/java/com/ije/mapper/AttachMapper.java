package com.ije.mapper;

import java.util.List;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;


public interface AttachMapper {

	
	public List<AttachVO> findByCno(Long cno);	
	public List<AttachVO> findByBno(Long bno); 
	public List<AttachVO> findByMno(Long mno); 
	public List<AttachVO> findByAllBno(Long bno);

	
	public void insert(List<AttachVO> ins);
	
	public void deleteByCno(Long cno);
	public void deleteByBno(Long bno); 
	public void deleteByMno(Long mno);


	
}

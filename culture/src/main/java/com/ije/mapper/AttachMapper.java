package com.ije.mapper;

import java.util.List;

import com.ije.domain.AttachVO;


public interface AttachMapper {

	
	public List<AttachVO> findByCno(Long cno);	
	public List<AttachVO> findByBno(Long bno); 
	public AttachVO findByMno(Long mno); 
	
	public void insert(List<AttachVO> ins);
	
	public void deleteByCno(Long cno);
	public void deleteByBno(Long bno); 
	public void deleteByMno(Long mno);

	
}

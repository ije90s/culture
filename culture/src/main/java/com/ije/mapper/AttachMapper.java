package com.ije.mapper;

import java.util.List;

import com.ije.domain.AttachVO;

public interface AttachMapper {

	public void insert(AttachVO ins); 
	
	public void delete(Long gno);
	
	public List<AttachVO> findByCno(Long cno);
	
}

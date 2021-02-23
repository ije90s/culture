package com.ije.mapper;

import java.util.List;

import com.ije.domain.CultureVO;

public interface CultureMapper {

	// 전체리스트
	public List<CultureVO> getList();
	
	//CRUD 구현 
	public int insert(CultureVO ins);
	public int insertKey(CultureVO ins); 
	public CultureVO read(Long cno);
	public int update(CultureVO upt);
	public int delete(Long cno);
}

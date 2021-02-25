package com.ije.service;

import java.util.List;

import com.ije.domain.Criteria;
import com.ije.domain.CultureVO;

public interface CultureService {
	// 전체리스트
	public List<CultureVO> getList();
	
	//CRUD 구현 
	public int register(CultureVO ins);
	public int registerKey(CultureVO ins); 
	public CultureVO get(Long cno);
	public int modify(CultureVO upt);
	public int remove(Long cno);
	
	public List<CultureVO> getListPaging(Criteria cri); 
	public int getCount(Criteria cri);  
	
}

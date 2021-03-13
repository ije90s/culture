package com.ije.service;

import java.util.List;

import com.ije.domain.AttachVO;
import com.ije.domain.Criteria;
import com.ije.domain.CultureVO;

public interface CultureService {
	// 전체리스트
	public List<CultureVO> getList();
	
	//CRUD 구현 
	public int register(CultureVO ins);
	public void registerKey(CultureVO ins); 
	public CultureVO get(Long cno);
	public int modify(CultureVO upt);
	public int remove(Long cno);
	
	public List<CultureVO> getListPaging(Criteria cri, Long mno); 
	public int getCount(Criteria cri);  
	
	public List<AttachVO> getAttachList(Long cno);
	
	public List<CultureVO> getMonList(Criteria cri, Long mno); 
	public List<CultureVO> getYearList(Criteria cri, Long mno);
	public List<CultureVO> getChartList(Criteria cri, Long mno);
	public List<CultureVO> getBySdate(Criteria cri, Long mno); 
}

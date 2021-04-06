package com.ije.service;

import java.util.List;

import com.ije.domain.Criteria;
import com.ije.domain.ReportVO;

public interface ReportService {
	
	public List<ReportVO> getList(Criteria cri, String object, String tab);
	public int getCount(Criteria cri, String object, String tab);
	public int register(ReportVO ins);
	public ReportVO get(Long rno); 
	public int modify(ReportVO upt);
	public int remove(Long rno);
	public ReportVO getByNo(String kind, Long no);
}

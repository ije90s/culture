package com.ije.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ije.domain.Criteria;
import com.ije.domain.ReportVO;

public interface ReportMapper {
	
	public List<ReportVO> getList(@Param("cri") Criteria cri, @Param("object") String object, @Param("tab") String tab); 
	public int getCount(@Param("cri") Criteria cri, @Param("object") String object, @Param("tab") String tab); 
	public int insert(ReportVO ins);
	public ReportVO read(Long rno);
	public int update(ReportVO upt);
	public int delete(Long rno);
	public ReportVO getByNo(@Param("kind") String kind, @Param("no") Long no);
}

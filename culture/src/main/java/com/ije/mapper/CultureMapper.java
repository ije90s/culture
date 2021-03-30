package com.ije.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ije.domain.Criteria;
import com.ije.domain.CultureVO;

public interface CultureMapper {

	// 전체리스트
	public List<CultureVO> getList();
	
	//CRUD 구현 
	public int insert(CultureVO ins);
	public void insertKey(CultureVO ins); 
	public CultureVO read(Long cno);
	public int update(CultureVO upt);
	public int delete(Long cno);
	
	//페이징 처리 
	public List<CultureVO> getListPaging(@Param("cri") Criteria cri, @Param("mno") Long mno);
	public int getCount(@Param("cri") Criteria cri, @Param("mno") Long mno); 
	public List<CultureVO> getListSearch(@Param("cri") Criteria cri);
	
	//통계 
	public List<CultureVO> getMonList(@Param("cri") Criteria cri, @Param("mno") Long mno); 
	public List<CultureVO> getYearList(@Param("cri") Criteria cri, @Param("mno") Long mno);
	public List<CultureVO> getChartList(@Param("cri") Criteria cri, @Param("mno") Long mno);
	public List<CultureVO> read2(@Param("cri") Criteria cri, @Param("mno") Long mno); 
}

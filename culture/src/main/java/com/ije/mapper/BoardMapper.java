package com.ije.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getList(); 
	
	//CRUD 구현 
	public void insert(BoardVO ins); 
	public void insertKey(BoardVO ins); 
	public BoardVO read(Long bno); 
	public int delete(Long bno); 
	public int update(BoardVO upt); 
	
	public List<BoardVO> getListPaging(@Param("cri") Criteria cri, @Param("kind") String kind); 
	public int getCount(@Param("cri") Criteria cri, @Param("kind") String kind);
	
	public List<BoardVO> topList(String kind);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}

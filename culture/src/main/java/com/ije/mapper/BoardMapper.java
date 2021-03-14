package com.ije.mapper;

import java.util.List;

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
	
	public List<BoardVO> getListPaging(Criteria cri); 
	public int getCount();
	
	public List<BoardVO> topList(String kind);
}

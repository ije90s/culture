package com.ije.service;

import java.util.List;

import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;

public interface BoardService {

	public List<BoardVO> getList(); 
	public void register(BoardVO ins); 
	public BoardVO get(Long bno); 
	public int remove(Long bno); 
	public int modify(BoardVO upt);
	
	public List<BoardVO> getListPaging(Criteria cri);
	public int getCount();
}

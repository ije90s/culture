package com.ije.service;

import java.util.List;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;
import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;

public interface BoardService {

	public List<BoardVO> getList(); 
	public void register(BoardVO ins); 
	public BoardVO get(Long bno); 
	public int remove(Long bno); 
	public int modify(BoardVO upt);
	
	public List<BoardVO> getListPaging(Criteria cri, String kind);
	public int getCount(Criteria cri, String kind);

	public List<BoardVO> topList(String kind);
	public List<BoardVO> topWriterList(String writer);
	public List<BoardVO> getWriterList(Criteria cri, String writer);
	public int getWriterCount(Criteria cri, String writer); 

	
	public List<AttachVO> getAttachList(Long bno);
	public List<AttachVO> getAllAttachList(Long bno);
}

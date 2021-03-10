package com.ije.service;

import java.util.List;

import com.ije.domain.Criteria;
import com.ije.domain.ReplyPageDTO;
import com.ije.domain.ReplyVO;

public interface ReplyService {
	public List<ReplyVO> getList(); 
	public boolean register(ReplyVO ins); 
	public ReplyVO get(Long rno); 
	public boolean modify(ReplyVO upt); 
	public boolean remove(Long rno);
	public ReplyPageDTO getListPaging(Criteria cri, Long bno);
}

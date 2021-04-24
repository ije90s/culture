package com.ije.mapper;

import java.util.List;

import com.ije.domain.Criteria;
import com.ije.domain.MessageVO;

public interface MessageMapper {
	
	public int insert(MessageVO ins);
	public MessageVO read(Long mno); 
	public List<MessageVO> getList(Criteria cri); 
	public int update(MessageVO upt); 
	public int updateOdate(Long mno); 
	public int delete(Long mno);
	public int getCount(Criteria cri);
	public int getCountByTarget(String target); 
	public List<MessageVO> getListByTarget(String target);
}

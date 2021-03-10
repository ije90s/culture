package com.ije.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ije.domain.Criteria;
import com.ije.domain.ReplyVO;

public interface ReplyMapper {
	
	public List<ReplyVO> getList();
	
	public int insert(ReplyVO ins); 
	public ReplyVO read(Long rno);
	public int update(ReplyVO upt);
	public int delete(Long rno);
	
	public List<ReplyVO> getListPaing(@Param("cri") Criteria cri, @Param("bno") Long bno);
	public int getCountByRno(Long bno);
}

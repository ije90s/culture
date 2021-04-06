package com.ije.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ije.domain.Criteria;
import com.ije.domain.MemberLogVO;

public interface MemberLogMapper {
	
	public List<MemberLogVO> getList(@Param("cri") Criteria cri); 
	public int getCount(@Param("cri") Criteria cri);
	public MemberLogVO read(Long lno);
	public List<MemberLogVO> read2(@Param("sub") Criteria cri, @Param("target") String target);
	public int getCount2(String target);
	public int insert(MemberLogVO ins); 
	public int update(MemberLogVO upt); 
	public int delete(Long lno); 
	public int updateReason(MemberLogVO upt);
}

package com.ije.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ije.domain.Criteria;
import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;

public interface MemberMapper {
	
	public MemberVO read(String id);
	public void insert(List<MemberVO> ins);
	public MemberVO get(Long mno);
	public int update(MemberVO upt);
	public int delete(String id);
	public int updateAuth(@Param("auth") String auth, @Param("mno") String mno);
	public int updateState(@Param("state") int state, @Param("id") String id);
	
	public List<MemberVO> getList(@Param("cri") Criteria cri);
	public int getCount(@Param("cri") Criteria cri);
	
	
}

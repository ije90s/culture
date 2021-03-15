package com.ije.mapper;

import java.util.List;

import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;

public interface MemberMapper {
	
	public MemberVO read(String id);
	public void insert(List<MemberVO> ins);
	public int update(MemberVO upt);
	public int updatePw(MemberVO upt);
	public int delete(Long mno);
	
	public void insert2(UnjoinVO ins);
}

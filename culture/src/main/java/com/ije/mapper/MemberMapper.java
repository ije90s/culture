package com.ije.mapper;

import java.util.List;

import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;

public interface MemberMapper {
	
	public MemberVO read(String id);
	public void insert(List<MemberVO> ins);
	public MemberVO get(Long mno);
	public int update(MemberVO upt);
	public int delete(String id);
}

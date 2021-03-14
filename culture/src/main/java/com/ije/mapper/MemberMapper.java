package com.ije.mapper;

import java.util.List;

import com.ije.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String id);
	public void insert(List<MemberVO> ins);
}

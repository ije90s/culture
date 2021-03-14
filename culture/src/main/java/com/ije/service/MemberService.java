package com.ije.service;


import com.ije.domain.MemberVO;

public interface MemberService {
	public void register(MemberVO ins);
	public MemberVO read(String id);
}

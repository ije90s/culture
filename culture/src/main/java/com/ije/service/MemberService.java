package com.ije.service;


import com.ije.domain.AttachVO;
import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;

public interface MemberService {
	public void register(MemberVO ins);
	public MemberVO read(String id);
	public int modify(MemberVO upt);
	public int modifyPW(MemberVO upt);
	public int remove(Long mno);
	public AttachVO getAttach(Long mno);
	public void modifyPhoto(MemberVO vo);
	public void registerUnjoin(UnjoinVO ins);
}

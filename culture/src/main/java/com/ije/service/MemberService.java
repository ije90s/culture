package com.ije.service;


import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.ije.domain.AttachVO;
import com.ije.domain.Criteria;
import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;

public interface MemberService {
	public void register(MemberVO ins);
	public MemberVO read(String id);
	public MemberVO read2(Long mno);
	public int modify(MemberVO upt);
	public int remove(String id);
	public List<AttachVO> getAttach(Long mno);
	public void modifyPhoto(MemberVO vo);
	public void deletePhoto(Long mno);
	public List<MemberVO> getList(Criteria cri);
	public int getCount(Criteria cri);
	public MemberVO findById(String name, String email);
	public void sendEmail(MemberVO vo) throws Exception; 
	public void findPw(HttpServletResponse resp, MemberVO vo) throws Exception; 
}

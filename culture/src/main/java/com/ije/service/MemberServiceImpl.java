package com.ije.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.AttachVO;
import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;
import com.ije.mapper.AttachMapper;
import com.ije.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberMapper mapper; 
	private final AttachMapper attachMapper; 
	
	@Override
	public void register(MemberVO vo) {
		log.info("회원 등록하기");
		List<MemberVO> ins = new ArrayList<>(); 
		ins.add(vo); 
		mapper.insert(ins);
	}

	@Override
	public MemberVO read(String id) {
		log.info("아이디 체크하기 : "+id);
		return mapper.read(id);
	}

	@Override
	public int modify(MemberVO upt) {
		log.info("회원정보 변경 : "+upt);	
		return mapper.update(upt);
	}

	@Transactional
	@Override
	public void modifyPhoto(MemberVO vo) {
		log.info("사진 번경......................");
		attachMapper.deleteByMno(vo.getMno());
		
		if(vo.getAttachList()!=null && vo.getAttachList().size() >0) {
			vo.getAttachList().forEach(attach ->{
				attach.setCno(0L);
				attach.setBno(0L);
				attach.setMno(vo.getMno());
				attachMapper.insert(vo.getAttachList());
			});
		}
	}

	@Override
	public List<AttachVO> getAttach(Long mno) {
		// TODO Auto-generated method stub
		return attachMapper.findByMno(mno);
	}

	@Override
	public MemberVO read2(Long mno) {
		// TODO Auto-generated method stub
		return mapper.get(mno);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return mapper.delete(id);
	}



}

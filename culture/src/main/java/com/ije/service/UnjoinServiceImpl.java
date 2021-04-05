package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.Criteria;
import com.ije.domain.MemberVO;
import com.ije.domain.UnjoinVO;
import com.ije.mapper.AttachMapper;
import com.ije.mapper.MemberMapper;
import com.ije.mapper.UnJoinMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class UnjoinServiceImpl implements UnjoinService {
	
	private final UnJoinMapper mapper; 
	private final AttachMapper attachMapper; 
	private final MemberMapper memberMapper; 

	@Transactional
	@Override
	public void register(UnjoinVO ins) {
		log.info("탈퇴사유 작성하기");
		mapper.insert(ins);
		MemberVO vo = memberMapper.read(ins.getId()); 
		attachMapper.deleteByMno(vo.getMno());
		memberMapper.delete(ins.getId()); 
	}

	@Override
	public List<UnjoinVO> getList(Criteria cri) {
		return mapper.getList(cri);
	}

	@Override
	public int getCount() {
		return mapper.getCount();
	}

	@Override
	public UnjoinVO get(Long uno) {
		return mapper.read(uno);
	}

	@Override
	public List<UnjoinVO> getCountList() {
		return mapper.getCountList();
	}

}

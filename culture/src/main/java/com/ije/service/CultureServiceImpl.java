package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ije.domain.CultureVO;
import com.ije.mapper.CultureMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class CultureServiceImpl implements CultureService {

	private final CultureMapper mapper;

	@Override
	public List<CultureVO> getList() {
		log.info("getList...................");
		return mapper.getList();
	}

	@Override
	public int register(CultureVO ins) {
		log.info("register...................");
		return mapper.insert(ins);
	}

	@Override
	public int registerKey(CultureVO ins) {
		log.info("registerKey...................");
		return mapper.insertKey(ins);
	}

	@Override
	public CultureVO get(Long cno) {
		log.info("get...................");
		return mapper.read(cno);
	}

	@Override
	public int modify(CultureVO upt) {
		log.info("modify...................");
		return mapper.update(upt);
	}

	@Override
	public int remove(Long cno) {
		log.info("remove.......................");
		return mapper.delete(cno);
	} 
	


}

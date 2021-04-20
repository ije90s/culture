package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ije.domain.Criteria;
import com.ije.domain.MessageVO;
import com.ije.mapper.MessageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {
	
	private final MessageMapper mapper; 
	
	
	@Override
	public int register(MessageVO ins) {
		log.info("쪽지 등록하기");
		return mapper.insert(ins);
	}

	@Override
	public MessageVO get(Long mno) {
		log.info("쪽지 조회하기");
		return mapper.read(mno);
	}

	@Override
	public List<MessageVO> getList(Criteria cri) {
		log.info("쪽지 리스트");
		return mapper.getList(cri);
	}

	@Override
	public int modify(MessageVO upt) {
		log.info("쪽지 수정하기");
		return mapper.update(upt);
	}

	@Override
	public int modifyOdate(Long mno) {
		log.info("odate 업데이트");
		return mapper.updateOdate(mno);
	}

	@Override
	public int remove(Long mno) {
		log.info("쪽지 삭제하기");
		return mapper.delete(mno);
	}

}

package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.Criteria;
import com.ije.domain.MessagePageDTO;
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

	@Transactional
	@Override
	public MessageVO get(Long mno, String userid) {
		log.info("쪽지 조회하기");
		MessageVO vo = mapper.read(mno); 
		if(vo.getOdate()==null && userid.equals(vo.getTarget())) {
			mapper.updateOdate(mno);
		}
		return mapper.read(mno);
	}

	@Override
	public MessagePageDTO getList(Criteria cri) {
		log.info("쪽지 리스트");
		return new MessagePageDTO(mapper.getCount(cri), mapper.getList(cri));
	}

	@Override
	public int modify(MessageVO upt) {
		log.info("쪽지 수정하기");
		return mapper.update(upt);
	}

	@Override
	public int remove(Long mno) {
		log.info("쪽지 삭제하기");
		return mapper.delete(mno);
	}

}

package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.Criteria;
import com.ije.domain.ReplyPageDTO;
import com.ije.domain.ReplyVO;
import com.ije.mapper.BoardMapper;
import com.ije.mapper.ReplyMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	private final ReplyMapper mapper; 
	
	private final BoardMapper boardMapper; 

	@Override
	public List<ReplyVO> getList() {
		log.info("..................................");
		return mapper.getList();
	}

	@Transactional
	@Override
	public boolean register(ReplyVO ins) {
		log.info("..................................");
		boardMapper.updateReplyCnt(ins.getBno(), 1);
		return mapper.insert(ins) > 0;
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("..................................");
		return mapper.read(rno);
	}

	@Override
	public boolean modify(ReplyVO upt) {
		log.info("..................................");
		return mapper.update(upt) > 0;
	}

	@Transactional
	@Override
	public boolean remove(Long rno) {
		log.info("..................................");
		ReplyVO vo = mapper.read(rno); 
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno) > 0;
	}

	@Override
	public ReplyPageDTO getListPaging(Criteria cri, Long bno) {
		log.info("..................................");
		log.info("게시글 : " + bno);
		return new ReplyPageDTO(mapper.getCountByRno(bno), mapper.getListPaing(cri, bno));
	}

}

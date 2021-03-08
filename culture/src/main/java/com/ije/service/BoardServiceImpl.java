package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;
import com.ije.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper; 
	
	
	@Override
	public List<BoardVO> getList() {
		log.info("전체 목록 가져오기.....................");
		return mapper.getList();
	}

	@Override
	public void register(BoardVO ins) {
		log.info("게시물 등록하기...............................");
		mapper.insertKey(ins);
		log.info(ins);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("게시물 조회 : "+bno);
		return mapper.read(bno);
	}

	@Override
	public int remove(Long bno) {
		log.info("게시물 삭제 : "+bno);
		return mapper.delete(bno);
	}

	@Override
	public int modify(BoardVO upt) {
		log.info("게시물 수정 : "+upt);
		return mapper.update(upt);
	}

	@Override
	public List<BoardVO> getListPaging(Criteria cri) {
		log.info("페이징 : "+cri);
		return mapper.getListPaging(cri);
	}

	@Override
	public int getCount() {
		return mapper.getCount();
	}

}

package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;
import com.ije.domain.BoardVO;
import com.ije.domain.Criteria;
import com.ije.mapper.AttachMapper;
import com.ije.mapper.BoardMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper mapper; 
	
	private final AttachMapper attachMapper; 
	
	@Override
	public List<BoardVO> getList() {
		//log.info("전체 목록 가져오기.....................");
		return mapper.getList();
	}

	@Transactional
	@Override
	public void register(BoardVO ins) {
		//log.info("게시물 등록하기...............................");
		mapper.insertKey(ins);
		if(ins.getAttachList() == null || ins.getAttachList().size() <=0) {
			return; 
		} 
		
		ins.getAttachList().forEach(attach ->{
			attach.setCno(0L);
			attach.setBno(ins.getBno());
			attach.setMno(0L);
			attachMapper.insert(ins.getAttachList());
		});
		//log.info(ins);
	}

	@Override
	public BoardVO get(Long bno) {
		//log.info("게시물 조회 : "+bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public int remove(Long bno) {
		//log.info("게시물 삭제 : "+bno);
		attachMapper.deleteByBno(bno);
		return mapper.delete(bno);
	}

	@Transactional
	@Override
	public int modify(BoardVO upt) {
		//log.info("게시물 수정 : "+upt);
		attachMapper.deleteByBno(upt.getBno());
		
		if(upt.getAttachList() != null && upt.getAttachList().size() > 0) {
			upt.getAttachList().forEach(attach ->{
				attach.setCno(0L);
				attach.setBno(upt.getBno());
				attach.setMno(0L);
				attachMapper.insert(upt.getAttachList());
			});
		}		
		
		return mapper.update(upt);
	}

	@Override
	public List<BoardVO> getListPaging(Criteria cri, String kind) {
		//log.info("페이징 : "+cri+" kind : "+kind);
		//log.info(mapper.getListPaging(cri, kind));
		return mapper.getListPaging(cri, kind);
	}

	@Override
	public int getCount(Criteria cri, String kind) {
		return mapper.getCount(cri, kind);
	}

	@Override
	public List<BoardVO> topList(String kind) {
		//log.info("kind : " + kind);
		return mapper.topList(kind);
	}

	@Override
	public List<AttachVO> getAttachList(Long bno) {
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<AttachVO> getAllAttachList(Long bno) {
		return attachMapper.findByAllBno(bno);
	}

	@Override
	public List<BoardVO> topWriterList(String writer) {
		return mapper.topWriterList(writer);
	}

	@Override
	public int getWriterCount(String writer) {
		// TODO Auto-generated method stub
		return mapper.getWriterCount(writer);
	}
	

}

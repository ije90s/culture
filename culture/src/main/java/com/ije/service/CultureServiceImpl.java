package com.ije.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.AttachFileVO;
import com.ije.domain.AttachVO;
import com.ije.domain.Criteria;
import com.ije.domain.CultureVO;
import com.ije.mapper.AttachMapper;
import com.ije.mapper.CultureMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class CultureServiceImpl implements CultureService {

	private final CultureMapper mapper;
	
	private final AttachMapper attachMapper; 

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
	public void registerKey(CultureVO ins) {
		log.info("registerKey...................");
		mapper.insertKey(ins);
		if(ins.getAttachList() == null || ins.getAttachList().size() <=0) {
			return; 
		} 
		
		ins.getAttachList().forEach(attach ->{
			attach.setCno(ins.getCno());
			attach.setBno(0L);
			attach.setMno(0L);
			attachMapper.insert(ins.getAttachList());
		});
	}

	@Override
	public CultureVO get(Long cno) {
		log.info("get...................");
		return mapper.read(cno);
	}

	@Override
	public int modify(CultureVO upt) {
		log.info("modify...................");
		log.info("modify..............." + upt);
		attachMapper.deleteByCno(upt.getCno());

		if(upt.getAttachList() != null && upt.getAttachList().size() > 0) {
			upt.getAttachList().forEach(attach ->{
				attach.setCno(upt.getCno());
				attach.setBno(0L);
				attach.setMno(0L);
				attachMapper.insert(upt.getAttachList());
			});
		}
		
		return mapper.update(upt);
	}

	@Override
	public int remove(Long cno) {
		log.info("remove.......................");
		attachMapper.deleteByCno(cno);
		return mapper.delete(cno);
	}

	@Override
	public List<CultureVO> getListPaging(Criteria cri, Long mno) {
		log.info("paging.......................");
		return mapper.getListPaging(cri, mno);
	}

	@Override
	public int getCount(Criteria cri) {
		log.info("count.......................");
		return mapper.getCount(cri);
	}


	@Override
	public List<AttachVO> getAttachList(Long cno) {
		log.info("첨부파일 리스트 호출 : " + cno);
		return attachMapper.findByCno(cno);
	}


	@Override
	public List<CultureVO> getMonList(Criteria cri, Long mno) {
		log.info("월별 조회 : " + cri + ", mno  : "+mno );
		return mapper.getMonList(cri, mno);
	}


	@Override
	public List<CultureVO> getYearList(Criteria cri, Long mno) {
		log.info("연별 조회 : " + cri+ ", mno  : "+mno );
		return mapper.getYearList(cri, mno);
	}


	@Override
	public List<CultureVO> getChartList(Criteria cri, Long mno) {
		log.info("차트 조회 : " + cri+ ", mno  : "+mno );
		return mapper.getChartList(cri, mno);
	}


	@Override
	public List<CultureVO> getBySdate(Criteria cri, Long mno) {
		log.info("일별 자세히 조회 : "+cri+ ", mno  : "+mno );
		return mapper.read2(cri, mno);
	}
}

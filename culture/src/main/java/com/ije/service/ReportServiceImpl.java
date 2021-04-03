package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.Criteria;
import com.ije.domain.ReportVO;
import com.ije.mapper.BoardMapper;
import com.ije.mapper.CultureMapper;
import com.ije.mapper.ReportMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {
	
	private final ReportMapper mapper;
	private final CultureMapper cultureMapper; 
	private final BoardMapper boardMapper; 
	
	@Override
	public List<ReportVO> getList(Criteria cri, String repoter) {
		log.info("리스트 출력............................");
		return mapper.getList(cri, repoter);
	}

	@Override
	public int getCount(Criteria cri, String repoter) {
		log.info("건수 출력............................");
		return mapper.getCount(cri, repoter);
	}

	@Transactional
	@Override
	public int register(ReportVO ins) {
		log.info("신고사유 등록............................");
		if(ins.getKind().equals("culture")) {
			cultureMapper.reportUpdate(ins.getReporter(), ins.getNo()); 
		}else {
			boardMapper.reportUpdate(ins.getReporter(), ins.getNo());
		}
		return mapper.insert(ins);
	}

	@Override
	public ReportVO get(Long rno) {
		log.info("신고사유 조회............................");
		return mapper.read(rno);
	}

	@Override
	public int modify(ReportVO upt) {
		log.info("신고사유 수정............................");
		return mapper.update(upt);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("신고사유 삭제............................");
		ReportVO vo = mapper.read(rno); 
		if(vo.getKind().equals("culture")) {
			cultureMapper.reportUpdate("N", vo.getNo()); 
		}else {
			boardMapper.reportUpdate("N", vo.getNo()); 
		}
		return mapper.delete(rno);
	}

	@Override
	public ReportVO getByNo(String kind, Long no) {
		log.info("신고사유 조회............................");
		return mapper.getByNo(kind, no);
	}

}

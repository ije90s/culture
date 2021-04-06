package com.ije.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ije.domain.Criteria;
import com.ije.domain.MemberLogVO;
import com.ije.domain.MemberVO;
import com.ije.mapper.MemberLogMapper;
import com.ije.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class MemberLogServiceImpl implements MemberLogService {
	
	private final MemberLogMapper mapper; 
	private final MemberMapper memberMapper; 
	
	@Override
	public List<MemberLogVO> getList(Criteria cri) {
		log.info("조회 ");
		return mapper.getList(cri);
	}

	@Override
	public MemberLogVO get(Long lno) {
		log.info("회원 로그 조회 : "+lno);
		return mapper.read(lno);
	}

	@Transactional
	@Override
	public boolean register(MemberLogVO ins) {
		log.info("register : "+ins);
		MemberVO vo = memberMapper.read(ins.getTarget()); 
		if(ins.getKind().equals("R")) {
			memberMapper.updateAuth(ins.getAuth(), vo.getMno().toString()); 		
		}else if(ins.getKind().equals("B")) {
			memberMapper.updateState(1, ins.getTarget()); 
		}else {
			memberMapper.updateState(2, ins.getTarget()); 
		}
		return mapper.insert(ins)>0;
	}

	@Transactional
	@Override
	public boolean modify(MemberLogVO upt) {
		log.info("modify : "+upt);
		MemberVO vo = memberMapper.read(upt.getTarget()); 
		MemberLogVO vo2 = mapper.read(upt.getLno()); 
		if(upt.getKind().equals("R")) {
			memberMapper.updateAuth(upt.getAuth(), vo.getMno().toString()); 
			memberMapper.updateState(0, upt.getTarget()); 
		}else if(upt.getKind().equals("B")) {
			memberMapper.updateAuth("ROLE_USER", vo.getMno().toString());
			memberMapper.updateState(1, upt.getTarget()); 
		}else {
			memberMapper.updateAuth("ROLE_USER", vo.getMno().toString());
			memberMapper.updateState(2, upt.getTarget()); 
		}
		return mapper.update(upt)>0;
	}

	@Transactional
	@Override
	public boolean remove(Long lno) {
		log.info("remove : "+lno);
		MemberLogVO vo = mapper.read(lno);
		MemberVO vo2 = memberMapper.read(vo.getTarget()); 
		if(vo.getLno() == vo2.getLno()) {
			memberMapper.updateAuth(vo.getOldauth(), vo2.getMno().toString()); 
			memberMapper.updateState(vo.getState(), vo.getTarget());			
		}
		return mapper.delete(lno)>0;
	}

	@Override	
	public List<MemberLogVO> getByTarget(Criteria cri, String target) {
		log.info("아이디별 조회 : "+target);
		return mapper.read2(cri, target);
	}

	@Override
	public int getCount(Criteria cri) {
		return mapper.getCount(cri);
	}

	@Override
	public int getByTargetCount(String target) {
		return mapper.getCount2(target);
	}

	@Override
	public boolean modifyReason(MemberLogVO upt) {
		return mapper.updateReason(upt)>0;
	}
	
	

}
